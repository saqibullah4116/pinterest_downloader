// lib/theme/app_themes.dart

import 'package:flutter/material.dart';

// Theme class to store our custom themes
class AppTheme {
  final String name;
  final ThemeData themeData;

  AppTheme({required this.name, required this.themeData});
}

// Class to define all our themes
class AppThemes {
  static final pinterest = AppTheme(
    name: 'Pinterest',
    themeData: ThemeData(
      brightness: Brightness.light,
      primaryColor: const Color(0xFFE60023),
      colorScheme: const ColorScheme.light(
        primary: Color(0xFFE60023),
        secondary: Color(0xFFBD081C),
        surface: Colors.white,
        background: Color(0xFFF8F8F8),
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: Colors.black87,
        onBackground: Colors.black87,
      ),
      scaffoldBackgroundColor: const Color(0xFFF8F8F8),
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFFE60023),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      cardTheme: CardTheme(
        color: Colors.white,
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      iconTheme: const IconThemeData(color: Color(0xFFE60023)),
    ),
  );

  static final light = AppTheme(
    name: 'Light',
    themeData: ThemeData(
      brightness: Brightness.light,
      primaryColor: const Color(0xFFF5F5F5),
      colorScheme: const ColorScheme.light(
        primary: Colors.red,
        secondary: Colors.blue,
        surface: Colors.white,
        background: Color(0xFFF5F5F5),
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: Colors.black,
        onBackground: Colors.black,
      ),
      scaffoldBackgroundColor: const Color(0xFFF5F5F5),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      cardTheme: CardTheme(
        color: Colors.white,
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      iconTheme: const IconThemeData(color: Colors.red),
    ),
  );

  static final dark = AppTheme(
    name: 'Dark',
    themeData: ThemeData(
      brightness: Brightness.dark,
      primaryColor: const Color(0xFF121212),
      colorScheme: const ColorScheme.dark(
        primary: Colors.red,
        secondary: Colors.blue,
        surface: Color(0xFF303030),
        background: Color(0xFF121212),
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: Colors.white,
        onBackground: Colors.white,
      ),
      scaffoldBackgroundColor: const Color(0xFF121212),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      cardTheme: CardTheme(
        color: const Color(0xFF303030),
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      iconTheme: const IconThemeData(color: Colors.red),
    ),
  );

  static final midnight = AppTheme(
    name: 'Midnight Blue',
    themeData: ThemeData(
      brightness: Brightness.dark,
      primaryColor: const Color(0xFF172B4D),
      colorScheme: const ColorScheme.dark(
        primary: Color(0xFF172B4D),
        secondary: Colors.lightBlue,
        surface: Color(0xFF253858),
        background: Color(0xFF172B4D),
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: Colors.white,
        onBackground: Colors.white,
      ),
      scaffoldBackgroundColor: const Color(0xFF172B4D),
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFF172B4D),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      cardTheme: CardTheme(
        color: const Color(0xFF253858),
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      iconTheme: const IconThemeData(color: Colors.red),
    ),
  );

  static final nature = AppTheme(
    name: 'Nature',
    themeData: ThemeData(
      brightness: Brightness.light,
      primaryColor: const Color(0xFF2E7D32),
      colorScheme: const ColorScheme.light(
        primary: Color(0xFF2E7D32),
        secondary: Color(0xFF558B2F),
        surface: Color(0xFFDCEDC8),
        background: Color(0xFFF1F8E9),
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: Color(0xFF33691E),
        onBackground: Color(0xFF33691E),
      ),
      scaffoldBackgroundColor: const Color(0xFFF1F8E9),
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFF2E7D32),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      cardTheme: CardTheme(
        color: const Color(0xFFDCEDC8),
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      iconTheme: const IconThemeData(color: Color(0xFF2E7D32)),
    ),
  );

  static final sunset = AppTheme(
    name: 'Sunset',
    themeData: ThemeData(
      brightness: Brightness.light,
      primaryColor: const Color(0xFFFF6F00),
      colorScheme: const ColorScheme.light(
        primary: Color(0xFFFF6F00),
        secondary: Color(0xFFFFA000),
        surface: Color(0xFFFFF8E1),
        background: Color(0xFFFFF3E0),
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: Color(0xFF4E342E),
        onBackground: Color(0xFF4E342E),
      ),
      scaffoldBackgroundColor: const Color(0xFFFFF3E0),
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFFFF6F00),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      cardTheme: CardTheme(
        color: const Color(0xFFFFF8E1),
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      iconTheme: const IconThemeData(color: Color(0xFFFF6F00)),
    ),
  );

  static final purpleHaze = AppTheme(
    name: 'Purple Haze',
    themeData: ThemeData(
      brightness: Brightness.dark,
      primaryColor: const Color(0xFFAB47BC),
      colorScheme: const ColorScheme.dark(
        primary: Color(0xFFAB47BC),
        secondary: Color(0xFFCE93D8),
        surface: Color(0xFF5E35B1),
        background: Color(0xFF4527A0),
        onPrimary: Colors.white,
        onSecondary: Colors.black,
        onSurface: Colors.white,
        onBackground: Colors.white,
      ),
      scaffoldBackgroundColor: const Color(0xFF4527A0),
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFF7E57C2),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      cardTheme: CardTheme(
        color: const Color(0xFF673AB7),
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      iconTheme: const IconThemeData(color: Color(0xFFCE93D8)),
    ),
  );

  static final List<AppTheme> all = [
    pinterest,
    light,
    dark,
    midnight,
    nature,
    sunset,
    purpleHaze,
  ];
}
