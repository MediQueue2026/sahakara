import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'core/app_data.dart';
import 'core/app_language.dart';
import 'core/supabase_client.dart';
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
    return StreamBuilder<AuthState>(
      stream: supabase.auth.onAuthStateChange,
      builder: (context, snapshot) {
        final session = supabase.auth.currentSession;
        if (session == null) {
          return PhoneLoginScreen(lang: lang);
        }
        return _AuthedRouter(lang: lang);
      },
    );
  }
}

class _AuthedRouter extends StatefulWidget {
  final LanguageController lang;
  const _AuthedRouter({required this.lang});

  @override
  State<_AuthedRouter> createState() => _AuthedRouterState();
}

class _AuthedRouterState extends State<_AuthedRouter> {
  late Future<(Map<String, dynamic>, Map<String, dynamic>?)> _future;

  @override
  void initState() {
    super.initState();
    _future = _bootstrap();
  }

  Future<(Map<String, dynamic>, Map<String, dynamic>?)> _bootstrap() async {
    final profile = await AppData.ensureUserProfile();
    final storedLang = profile['language'] as String?;
    if (storedLang != null) {
      widget.lang.value = AppLanguage.values.byName(storedLang);
    }
    final membership = await AppData.fetchMyMembership(profile['id'] as String);
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
          return HouseholdSetupScreen(
            lang: widget.lang,
            ownerId: profile['id'] as String,
            onDone: refresh,
          );
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
