import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../core/firebase_client.dart';
import 'admin_login_screen.dart';
import 'admin_shell.dart';

/// Web entry point — the staff-only admin panel (households overview, task
/// library, holidays). Signs in with a Firebase email/password account that
/// has the `is_staff` custom claim (see the README), not a household member,
/// so it's routed separately from [MobileApp].
class AdminApp extends StatelessWidget {
  const AdminApp({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: auth.idTokenChanges(),
      builder: (context, snapshot) {
        final user = snapshot.data;
        if (user == null) return const AdminLoginScreen();
        return FutureBuilder<IdTokenResult>(
          key: ValueKey(user.uid),
          future: user.getIdTokenResult(),
          builder: (context, token) {
            if (!token.hasData) {
              return const Scaffold(
                body: Center(child: CircularProgressIndicator()),
              );
            }
            final isStaff = token.data!.claims?['is_staff'] == true;
            return isStaff ? const AdminShell() : const _NotStaffScreen();
          },
        );
      },
    );
  }
}

class _NotStaffScreen extends StatelessWidget {
  const _NotStaffScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('This account is not a staff account.'),
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
