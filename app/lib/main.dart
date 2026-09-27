import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'core/env.dart';
import 'core/theme.dart';
import 'features/admin/admin_app.dart';
import 'mobile_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (Env.supabaseUrl.isEmpty || Env.supabaseAnonKey.isEmpty) {
    runApp(const _MissingConfigApp());
    return;
  }

  await Supabase.initialize(
    url: Env.supabaseUrl,
    publishableKey: Env.supabaseAnonKey,
  );
  runApp(const RootApp());
}

class _MissingConfigApp extends StatelessWidget {
  const _MissingConfigApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: appTheme,
      home: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Text(
              'Missing Supabase credentials.\n\n'
              'Copy env.example.json to env.json, fill in your project URL '
              'and anon key, then run:\n\n'
              'flutter run --dart-define-from-file=env.json',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
        ),
      ),
    );
  }
}

/// One Flutter codebase, two front doors: the owner/maid experience on
/// mobile, and the staff admin panel on web (see env.example.json for how
/// to supply Supabase credentials to either).
class RootApp extends StatelessWidget {
  const RootApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sahakara',
      debugShowCheckedModeBanner: false,
      theme: appTheme,
      home: kIsWeb ? const AdminApp() : const MobileApp(),
    );
  }
}
