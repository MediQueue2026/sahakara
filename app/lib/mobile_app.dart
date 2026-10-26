import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'core/app_data.dart';
import 'core/app_language.dart';
import 'core/firebase_client.dart';
import 'core/strings.dart';
import 'core/transitions.dart';
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
      // Without this a remembered session renders the login screen for a
      // frame, and its entrance animation starts before fading away.
      initialData: auth.currentUser,
      builder: (context, snapshot) =>
          FadeThroughSwitcher(child: _screenFor(snapshot.data)),
    );
  }

  Widget _screenFor(User? user) {
    if (user == null) {
      final rejectedAs = _rejectedAs;
      return EmailLoginScreen(
        lang: lang,
        onIntent: (intent) {
          _intent = intent;
          _rejectedAs = null;
        },
        // An admin has no mobile form to go back to.
        initialAccountType: rejectedAs == AccountType.admin ? null : rejectedAs,
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

  // A maid who just signed up (the login screen only passes a name then)
  // lands on their profile first. Any later reload of this router is
  // after that, so refresh() clears it.
  late bool _openProfile = widget.intent?.name != null &&
      widget.intent?.accountType == AccountType.maid;

  @override
  void initState() {
    super.initState();
    _future = _bootstrap();
  }

  Future<(Profile, Membership?)?> _bootstrap() async {
    // A persisted session can outlive its account (e.g. the Auth emulator
    // restarted and dropped its users). Data Connect would then send no
    // token and every operation fails as unauthenticated, so force a token
    // refresh up front and sign out if the account is gone. A session the
    // login screen just started has a fresh token, so skip the round trip.
    if (widget.intent == null) {
      try {
        await auth.currentUser?.getIdToken(true);
      } on FirebaseAuthException catch (e) {
        if (e.code != 'network-request-failed') {
          await auth.signOut();
        }
        rethrow;
      }
    }
    // The membership doesn't depend on the profile, so fetch both at once.
    // Errors surface when it's awaited below; ignore() only stops one from
    // being reported as unhandled if the profile step throws first.
    final membershipFuture = _fetchMembership()..ignore();
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
    // Memberships match on authUid, which an invited profile only gets once
    // ensureUserProfile claims it, so an empty result may just be early.
    final membership = await membershipFuture ?? await _fetchMembership();
    return (profile, membership);
  }

  Future<Membership?> _fetchMembership() {
    final membershipId = _preferredMembershipId;
    return membershipId == null
        ? AppData.fetchMyMembership()
        : AppData.fetchMyMembershipById(membershipId);
  }

  void refresh() => setState(() {
        _openProfile = false;
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
      builder: (context, snapshot) =>
          FadeThroughSwitcher(child: _screenFor(snapshot)),
    );
  }

  Widget _screenFor(AsyncSnapshot<(Profile, Membership?)?> snapshot) {
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
          openProfileOnStart: _openProfile,
        );
      }
      return HouseholdSetupScreen(lang: widget.lang, onDone: refresh);
    }
    return HomeShell(
      lang: widget.lang,
      profile: profile,
      membership: membership,
      onHouseholdAccepted: _onHouseholdAccepted,
      openProfileOnStart: _openProfile,
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
