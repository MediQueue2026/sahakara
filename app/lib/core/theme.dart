import 'package:flutter/material.dart';

final appTheme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF166534)),
  scaffoldBackgroundColor: const Color(0xFFF5F5F4),
  inputDecorationTheme: const InputDecorationTheme(
    border: OutlineInputBorder(),
    filled: true,
    fillColor: Colors.white,
  ),
  appBarTheme: const AppBarTheme(centerTitle: false),
);
