import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'firebase_client.dart';

/// The "Remember me" choice on the login screens.
///
/// On web, Firebase Auth can keep the session for just the browser tab, so
/// we hand it the matching persistence. On mobile the session always
/// persists, so we save the choice and sign out on the next launch when
/// the user didn't want to be remembered.
class RememberMe {
  static const _key = 'rememberMe';

  /// Call just before signing in or up.
  static Future<void> set(bool remember) async {
    if (kIsWeb) {
      await auth.setPersistence(
        remember ? Persistence.LOCAL : Persistence.SESSION,
      );
      return;
    }
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_key, remember);
  }

  /// Call once at startup, before the app reads the auth state.
  static Future<void> applyOnLaunch() async {
    if (kIsWeb) return;
    final prefs = await SharedPreferences.getInstance();
    if (!(prefs.getBool(_key) ?? true) && auth.currentUser != null) {
      await auth.signOut();
    }
  }
}
