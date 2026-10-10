import 'package:flutter/material.dart';

/// The app's only two colours: gold (primary) for bars, buttons and
/// highlights, maroon (secondary) for the selected tab, errors and accents.
/// [brandGoldSoft] is a pale tint of the gold for selected chips and other
/// soft fills. Everything else is plain black or white — every ColorScheme
/// slot is set below so Material doesn't generate tones of its own.
const brandGold = Color(0xFFEAA839);
const brandMaroon = Color(0xFF61040C);
const brandGoldSoft = Color(0xFFF9E5C4);

/// Warm ivory behind every screen; cards, dialogs and inputs stay white.
const brandIvory = Color(0xFFFCF8ED);

/// Secondary text (emails, hints, captions).
const mutedText = Colors.black54;

const _scheme = ColorScheme(
  brightness: Brightness.light,
  primary: brandGold,
  onPrimary: Colors.black,
  primaryContainer: brandGoldSoft,
  onPrimaryContainer: Colors.black,
  secondary: brandMaroon,
  onSecondary: Colors.white,
  secondaryContainer: brandGoldSoft,
  onSecondaryContainer: brandMaroon,
  tertiary: brandMaroon,
  onTertiary: Colors.white,
  tertiaryContainer: brandGoldSoft,
  onTertiaryContainer: brandMaroon,
  error: brandMaroon,
  onError: Colors.white,
  errorContainer: brandGoldSoft,
  onErrorContainer: brandMaroon,
  surface: Colors.white,
  onSurface: Colors.black87,
  onSurfaceVariant: mutedText,
  surfaceContainerLowest: Colors.white,
  surfaceContainerLow: Colors.white,
  surfaceContainer: Colors.white,
  surfaceContainerHigh: Colors.white,
  surfaceContainerHighest: brandGoldSoft,
  surfaceTint: Colors.transparent,
  outline: Colors.black38,
  outlineVariant: Colors.black12,
  shadow: Colors.black,
  scrim: Colors.black,
  inverseSurface: Colors.black87,
  onInverseSurface: Colors.white,
  inversePrimary: brandGold,
);

final appTheme = ThemeData(
  useMaterial3: true,
  colorScheme: _scheme,
  scaffoldBackgroundColor: brandIvory,
  inputDecorationTheme: const InputDecorationTheme(
    border: OutlineInputBorder(),
    filled: true,
    fillColor: Colors.white,
  ),
  // Gold text on white is too faint to read, so text buttons use maroon.
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(foregroundColor: brandMaroon),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(foregroundColor: Colors.black87),
  ),
  appBarTheme: const AppBarTheme(
    centerTitle: false,
    backgroundColor: brandGold,
    foregroundColor: Colors.black,
  ),
  navigationBarTheme: NavigationBarThemeData(
    backgroundColor: brandGold,
    indicatorColor: brandMaroon,
    iconTheme: WidgetStateProperty.resolveWith((states) => IconThemeData(
        color: states.contains(WidgetState.selected)
            ? Colors.white
            : Colors.black87)),
    labelTextStyle: WidgetStateProperty.resolveWith((states) => TextStyle(
        fontSize: 12,
        color: states.contains(WidgetState.selected)
            ? brandMaroon
            : Colors.black87)),
  ),
  navigationRailTheme: const NavigationRailThemeData(
    backgroundColor: brandGold,
    indicatorColor: brandMaroon,
    selectedIconTheme: IconThemeData(color: Colors.white),
    unselectedIconTheme: IconThemeData(color: Colors.black87),
    selectedLabelTextStyle:
        TextStyle(color: brandMaroon, fontWeight: FontWeight.w700),
    unselectedLabelTextStyle: TextStyle(color: Colors.black87),
  ),
);
