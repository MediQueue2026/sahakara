// Placeholder — replace by running, from the app/ folder:
//
//   dart pub global activate flutterfire_cli
//   flutterfire configure --project=sahakara-f78dd
//
// which overwrites this file with your project's real config.

import 'package:firebase_core/firebase_core.dart';

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    throw UnsupportedError(
      'Firebase is not configured yet. Run `flutterfire configure` in app/.',
    );
  }
}
