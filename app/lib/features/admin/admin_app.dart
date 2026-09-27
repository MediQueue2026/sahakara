import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../core/supabase_client.dart';
import 'admin_login_screen.dart';
import 'admin_shell.dart';

/// Web entry point — the staff-only admin panel (households overview, task
/// library, holidays). Signs in as a plain Supabase auth user marked
/// app_metadata.is_staff = true (see supabase/README.md), not a household
/// member, so it's routed separately from [MobileApp].
class AdminApp extends StatelessWidget {
  const AdminApp({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<AuthState>(
      stream: supabase.auth.onAuthStateChange,
      builder: (context, snapshot) {
        final session = supabase.auth.currentSession;
        return session == null ? const AdminLoginScreen() : const AdminShell();
      },
    );
  }
}
