import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../core/app_data.dart';
import '../../core/firebase_client.dart';
import '../../dataconnect_generated/sahakara.dart' show AccountType;
import 'admin_login_screen.dart';
import 'admin_shell.dart';

/// Web entry point — the admin-only panel (households overview, task
/// library, holidays). Signs in with a Firebase email/password account whose
/// user row has account type `admin` (see dataconnect/README.md), not a
/// household member, so it's routed separately from [MobileApp].
class AdminApp extends StatelessWidget {
  const AdminApp({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: auth.authStateChanges(),
      builder: (context, snapshot) {
        final user = snapshot.data;
        if (user == null) return const AdminLoginScreen();
        return FutureBuilder<Profile?>(
          key: ValueKey(user.uid),
          // Also links a pre-created admin row to this account on its first
          // sign-in. Admin operations re-check the role server-side; this
          // only decides which screen to show.
          future: AppData.ensureUserProfile(),
          builder: (context, profile) {
            if (profile.connectionState != ConnectionState.done) {
              return const Scaffold(
                body: Center(child: CircularProgressIndicator()),
              );
            }
            if (profile.hasError) {
              return _NotAdminScreen(
                'Could not load this account: ${profile.error}',
              );
            }
            final type = profile.data?.accountType.stringValue;
            if (type == AccountType.admin.name) return const AdminShell();
            return _NotAdminScreen(
              '${user.email} is not an admin account '
              '(account type: ${type ?? 'no user row'}).',
            );
          },
        );
      },
    );
  }
}

class _NotAdminScreen extends StatelessWidget {
  final String message;
  const _NotAdminScreen(this.message);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Text(message, textAlign: TextAlign.center),
            ),
            const SizedBox(height: 12),
            OutlinedButton(
              onPressed: () => auth.signOut(),
              child: const Text('Sign out'),
            ),
          ],
        ),
      ),
    );
  }
}
