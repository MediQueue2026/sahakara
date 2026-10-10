import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'core/app_data.dart';
import 'core/app_language.dart';
import 'core/firebase_client.dart';
import 'core/strings.dart';
import 'dataconnect_generated/sahakara.dart' show AccountType;
import 'features/auth/email_login_screen.dart';
import 'features/home/home_shell.dart';
import 'features/onboarding/household_setup_screen.dart';

/// Routes a signed-out user to login, a signed-in owner with no household
/// yet to setup, a maid with none to a waiting screen, and everyone else
/// into the home shell.
class MobileApp extends StatefulWidget {
  const MobileApp({super.key});

  @override
  State<MobileApp> createState() => _MobileAppState();
}

class _MobileAppState extends State<MobileApp> {
  final lang = LanguageController();

  // What the login screen last asked for; see EmailLoginScreen.onIntent.
  AuthIntent? _intent;

  // Set when a sign-in used the wrong account type, so the login screen
  // reopens on the right one with an explanation.
  AccountType? _rejectedAs;

  void _onWrongAccountType(WrongAccountTypeException e) {
    setState(() {
      _intent = null;
      _rejectedAs = AccountType.values.byName(e.accountType);
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: auth.authStateChanges(),
      builder: (context, snapshot) {
        final user = snapshot.data;
        if (user == null) {
          final rejectedAs = _rejectedAs;
          return EmailLoginScreen(
            lang: lang,
            onIntent: (intent) {
              _intent = intent;
              _rejectedAs = null;
            },
            // An admin has no mobile form to go back to.
            initialAccountType:
                rejectedAs == AccountType.admin ? null : rejectedAs,
            initialErrorKey: switch (rejectedAs) {
              AccountType.owner => 'registeredAsOwner',
              AccountType.maid => 'registeredAsMaid',
              AccountType.admin => 'adminUseWebPanel',
              null => null,
            },
          );
        }
        return _AuthedRouter(
          key: ValueKey(user.uid),
          lang: lang,
          intent: _intent,
          onWrongAccountType: _onWrongAccountType,
        );
      },
    );
  }
}

class _AuthedRouter extends StatefulWidget {
  final LanguageController lang;
  final AuthIntent? intent;
  final ValueChanged<WrongAccountTypeException> onWrongAccountType;

  const _AuthedRouter({
    super.key,
    required this.lang,
    required this.intent,
    required this.onWrongAccountType,
  });

  @override
  State<_AuthedRouter> createState() => _AuthedRouterState();
}

class _AuthedRouterState extends State<_AuthedRouter> {
  // Null means the account has no user row yet and nothing says which type
  // it is (e.g. a remembered session), so ask before creating one.
  late Future<(Profile, Membership?)?> _future;
  late AuthIntent? _intent = widget.intent;
  String? _preferredMembershipId;

  @override
  void initState() {
    super.initState();
    _future = _bootstrap();
  }

  Future<(Profile, Membership?)?> _bootstrap() async {
    // A persisted session can outlive its account (e.g. the Auth emulator
    // restarted and dropped its users). Data Connect would then send no
    // token and every operation fails as unauthenticated, so force a token
    // refresh up front and sign out if the account is gone.
    try {
      await auth.currentUser?.getIdToken(true);
    } on FirebaseAuthException catch (e) {
      if (e.code != 'network-request-failed') {
        await auth.signOut();
      }
      rethrow;
    }
    final Profile? profile;
    try {
      profile = await AppData.ensureUserProfile(signUp: _intent);
    } on WrongAccountTypeException catch (e) {
      widget.onWrongAccountType(e);
      await auth.signOut();
      rethrow;
    }
    if (profile == null) return null;
    final storedLang =
        AppLanguage.values.asNameMap()[profile.language.stringValue];
    if (storedLang != null) {
      widget.lang.value = storedLang;
    }
    final membershipId = _preferredMembershipId;
    final membership = membershipId == null
        ? await AppData.fetchMyMembership()
        : await AppData.fetchMyMembershipById(membershipId);
    return (profile, membership);
  }

  void refresh() => setState(() {
        _future = _bootstrap();
      });

  void _onHouseholdAccepted(String memberId) {
    _preferredMembershipId = memberId;
    refresh();
  }

  void _chooseAccountType(AccountType type) {
    _intent = AuthIntent(accountType: type);
    refresh();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _future,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        if (snapshot.hasError) {
          return Scaffold(
            body: Center(
              child: Text('Something went wrong: ${snapshot.error}'),
            ),
          );
        }
        final data = snapshot.data;
        if (data == null) {
          return _AccountTypeScreen(
            lang: widget.lang,
            onSelected: _chooseAccountType,
          );
        }
        final (profile, membership) = data;
        if (profile.accountType.stringValue == AccountType.admin.name) {
          return _AdminOnMobileScreen(lang: widget.lang);
        }
        if (membership == null) {
          if (profile.accountType.stringValue == AccountType.maid.name) {
            return HomeShell(
              lang: widget.lang,
              profile: profile,
              membership: AppData.previewMaidMembership(),
              onHouseholdAccepted: _onHouseholdAccepted,
            );
          }
          return HouseholdSetupScreen(lang: widget.lang, onDone: refresh);
        }
        return HomeShell(
          lang: widget.lang,
          profile: profile,
          membership: membership,
          onHouseholdAccepted: _onHouseholdAccepted,
        );
      },
    );
  }
}

/// Asks a signed-in account with no user row which type it is.
class _AccountTypeScreen extends StatelessWidget {
  final LanguageController lang;
  final ValueChanged<AccountType> onSelected;

  const _AccountTypeScreen({required this.lang, required this.onSelected});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<AppLanguage>(
      valueListenable: lang,
      builder: (context, lang, _) {
        return Scaffold(
          body: SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 360),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      AccountTypeChoice(lang: lang, onSelected: onSelected),
                      const SizedBox(height: 16),
                      TextButton(
                        onPressed: () => auth.signOut(),
                        child: Text(Strings.of('signOut', lang)),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

/// An admin account opened in the mobile app (a remembered session, since
/// the login screen turns admins away). Admins use the web panel instead.
class _AdminOnMobileScreen extends StatelessWidget {
  final LanguageController lang;

  const _AdminOnMobileScreen({required this.lang});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<AppLanguage>(
      valueListenable: lang,
      builder: (context, lang, _) {
        return Scaffold(
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    Strings.of('adminUseWebPanel', lang),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  OutlinedButton(
                    onPressed: () => auth.signOut(),
                    child: Text(Strings.of('signOut', lang)),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
