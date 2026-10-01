import 'package:flutter/material.dart';

/// The app's only two colours: amber for buttons and highlights, pale yellow
/// for bars, selected chips and other soft fills. Everything else is plain
/// black or white — every ColorScheme slot is set below so Material doesn't
/// generate tones of its own.
const brandAmber = Color(0xFFF2A900);
const brandCream = Color(0xFFF9E6A8);

/// Secondary text (emails, hints, captions).
const mutedText = Colors.black54;

const _scheme = ColorScheme(
  brightness: Brightness.light,
  primary: brandAmber,
  onPrimary: Colors.black,
  primaryContainer: brandCream,
  onPrimaryContainer: Colors.black,
  secondary: brandAmber,
  onSecondary: Colors.black,
  secondaryContainer: brandCream,
  onSecondaryContainer: Colors.black,
  tertiary: brandAmber,
  onTertiary: Colors.black,
  tertiaryContainer: brandCream,
  onTertiaryContainer: Colors.black,
  error: Color(0xFFB3261E),
  onError: Colors.white,
  errorContainer: brandCream,
  onErrorContainer: Colors.black,
  surface: Colors.white,
  onSurface: Colors.black87,
  onSurfaceVariant: mutedText,
  surfaceContainerLowest: Colors.white,
  surfaceContainerLow: Colors.white,
  surfaceContainer: Colors.white,
  surfaceContainerHigh: Colors.white,
  surfaceContainerHighest: brandCream,
  surfaceTint: Colors.transparent,
  outline: Colors.black38,
  outlineVariant: Colors.black12,
  shadow: Colors.black,
  scrim: Colors.black,
  inverseSurface: Colors.black87,
  onInverseSurface: Colors.white,
  inversePrimary: brandCream,
);

final appTheme = ThemeData(
  useMaterial3: true,
  colorScheme: _scheme,
  scaffoldBackgroundColor: Colors.white,
  inputDecorationTheme: const InputDecorationTheme(
    border: OutlineInputBorder(),
    filled: true,
    fillColor: Colors.white,
  ),
  // Amber text on white is too faint to read, so text buttons stay black.
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(foregroundColor: Colors.black87),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(foregroundColor: Colors.black87),
  ),
  appBarTheme: const AppBarTheme(
    centerTitle: false,
    backgroundColor: brandCream,
    foregroundColor: Colors.black,
  ),
  navigationBarTheme: const NavigationBarThemeData(
    backgroundColor: brandCream,
    indicatorColor: brandAmber,
  ),
  navigationRailTheme: const NavigationRailThemeData(
    backgroundColor: brandCream,
    indicatorColor: brandAmber,
  ),
);
