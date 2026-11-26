import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../firebase_options.dart';
import 'firebase_client.dart';

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  debugPrint('Handling background message: ${message.messageId}');
}

class FcmService {
  FcmService._();

  static const _savedTokenKey = 'fcm.savedDeviceToken';

  static Future<void>? _initialization;
  static Future<void>? _permissionRequest;
  static Future<void> _tokenSync = Future<void>.value();
  static String? _currentToken;
  static String? _savedToken;
  static bool _userReady = false;

  static Future<void> initialize() => _initialization ??= _initialize();

  static Future<void> _initialize() async {
    if (kIsWeb) return;

    FirebaseMessaging.onBackgroundMessage(
      firebaseMessagingBackgroundHandler,
    );
    FirebaseMessaging.onMessage.listen((message) {
      debugPrint('Received foreground message: ${message.messageId}');
    });
    FirebaseMessaging.onMessageOpenedApp.listen(_handleNotificationTap);
    FirebaseMessaging.instance.onTokenRefresh.listen((token) {
      _currentToken = token;
      debugPrint('FCM device token refreshed: $token');
      if (_userReady) {
        unawaited(
            _queueTokenSync().catchError((Object error, StackTrace stackTrace) {
          _logError('Could not sync refreshed FCM token', error, stackTrace);
        }));
      }
    });

    final preferences = await SharedPreferences.getInstance();
    _savedToken = preferences.getString(_savedTokenKey);

    final initialMessage = await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) {
      _handleNotificationTap(initialMessage);
    }
  }

  static Future<void> onUserReady() async {
    if (kIsWeb) return;
    _userReady = true;
    await initialize();
    await _requestPermission();
    _currentToken = await FirebaseMessaging.instance.getToken();
    debugPrint('FCM device token: $_currentToken');
    await _queueTokenSync();
  }

  static Future<void> _requestPermission() {
    final pending = _permissionRequest;
    if (pending != null) return pending;

    final request =
        FirebaseMessaging.instance.requestPermission().then<void>((_) {});
    _permissionRequest = request;
    return request.catchError((Object error, StackTrace stackTrace) {
      _permissionRequest = null;
      Error.throwWithStackTrace(error, stackTrace);
    });
  }

  static Future<void> _queueTokenSync() {
    final next = _tokenSync.then<void>(
      (_) => _syncCurrentToken(),
      onError: (Object error, StackTrace stackTrace) {
        _logError('Previous FCM token sync failed', error, stackTrace);
        return _syncCurrentToken();
      },
    );
    _tokenSync = next;
    return next;
  }

  static Future<void> _syncCurrentToken() async {
    if (!_userReady) return;
    final token = _currentToken;
    if (token == null) return;

    await db.saveMyFcmToken(token: token).previousToken(_savedToken).execute();

    final preferences = await SharedPreferences.getInstance();
    await preferences.setString(_savedTokenKey, token);
    _savedToken = token;
  }

  static Future<void> signOut() async {
    _userReady = false;
    if (kIsWeb) {
      await auth.signOut();
      return;
    }

    try {
      var tokensRemoved = true;
      try {
        await _tokenSync;
      } catch (error, stackTrace) {
        _logError(
          'Could not finish FCM token sync before sign-out',
          error,
          stackTrace,
        );
        tokensRemoved = false;
      }

      final preferences = await SharedPreferences.getInstance();
      _savedToken ??= preferences.getString(_savedTokenKey);

      try {
        _currentToken ??= await FirebaseMessaging.instance.getToken();
      } catch (error, stackTrace) {
        _logError(
          'Could not read the FCM token during sign-out',
          error,
          stackTrace,
        );
        tokensRemoved = false;
      }

      final tokens = {
        _currentToken,
        _savedToken,
      }.whereType<String>().toSet();
      for (final token in tokens) {
        try {
          await db.removeMyFcmToken(token: token).execute();
        } catch (error, stackTrace) {
          _logError(
            'Could not remove FCM token during sign-out',
            error,
            stackTrace,
          );
          tokensRemoved = false;
        }
      }

      if (tokensRemoved) {
        await preferences.remove(_savedTokenKey);
        _savedToken = null;
      }
    } catch (error, stackTrace) {
      _logError('FCM token cleanup failed during sign-out', error, stackTrace);
    } finally {
      _currentToken = null;
      await auth.signOut();
    }
  }

  static void _handleNotificationTap(RemoteMessage message) {
    debugPrint('Notification opened the app: ${message.messageId}');
  }

  static void _logError(String action, Object error, StackTrace stackTrace) {
    debugPrint('$action: $error\n$stackTrace');
  }
}
