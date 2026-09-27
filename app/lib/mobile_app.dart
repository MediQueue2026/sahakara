import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'core/app_data.dart';
import 'core/app_language.dart';
import 'core/firebase_client.dart';
import 'features/auth/phone_login_screen.dart';
import 'features/home/home_shell.dart';
import 'features/onboarding/household_setup_screen.dart';

/// Routes a signed-out phone to login, a signed-in phone with no household
/// yet to setup, and everyone else into the home shell.
class MobileApp extends StatefulWidget {
  const MobileApp({super.key});

  @override
  State<MobileApp> createState() => _MobileAppState();
}

class _MobileAppState extends State<MobileApp> {
  final lang = LanguageController();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: auth.authStateChanges(),
      builder: (context, snapshot) {
        final user = snapshot.data;
        if (user == null) {
          return PhoneLoginScreen(lang: lang);
        }
        return _AuthedRouter(key: ValueKey(user.uid), lang: lang);
      },
    );
  }
}

class _AuthedRouter extends StatefulWidget {
  final LanguageController lang;
  const _AuthedRouter({super.key, required this.lang});

  @override
  State<_AuthedRouter> createState() => _AuthedRouterState();
}

class _AuthedRouterState extends State<_AuthedRouter> {
  late Future<(Profile, Membership?)> _future;

  @override
  void initState() {
    super.initState();
    _future = _bootstrap();
  }

  Future<(Profile, Membership?)> _bootstrap() async {
    final profile = await AppData.ensureUserProfile();
    final storedLang = AppLanguage.values
        .asNameMap()[profile.language.stringValue];
    if (storedLang != null) {
      widget.lang.value = storedLang;
    }
    final membership = await AppData.fetchMyMembership();
    return (profile, membership);
  }

  void refresh() => setState(() => _future = _bootstrap());

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
        final (profile, membership) = snapshot.data!;
        if (membership == null) {
          return HouseholdSetupScreen(lang: widget.lang, onDone: refresh);
        }
        return HomeShell(
          lang: widget.lang,
          profile: profile,
          membership: membership,
        );
      },
    );
  }
}
