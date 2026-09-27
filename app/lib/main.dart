import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'core/env.dart';
import 'core/firebase_client.dart';
import 'core/theme.dart';
import 'features/admin/admin_app.dart';
import 'firebase_options.dart';
import 'mobile_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } on UnsupportedError {
    runApp(const _MissingConfigApp());
    return;
  }

  if (Env.useEmulators) {
    // The Android emulator reaches the host machine at 10.0.2.2.
    final host = !kIsWeb && defaultTargetPlatform == TargetPlatform.android
        ? '10.0.2.2'
        : 'localhost';
    await auth.useAuthEmulator(host, 9099);
    db.dataConnect.useDataConnectEmulator(host, 9399);
  }

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
              'Firebase is not configured yet.\n\n'
              'From the app/ folder, run:\n\n'
              'flutterfire configure --project=sahakara-f78dd',
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
/// mobile, and the staff admin panel on web.
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
