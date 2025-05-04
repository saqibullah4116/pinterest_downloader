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
  // Light theme
  static final light = AppTheme(
    name: 'Light',
    themeData: ThemeData(
      brightness: Brightness.light,
      primaryColor: Colors.red,
      colorScheme: ColorScheme.light(
        primary: Colors.red,
        secondary: Colors.blue,
        surface: Colors.white,
        background: Color(0xFFF5F5F5),
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: Colors.black,
        onBackground: Colors.black,
      ),
      scaffoldBackgroundColor: Color(0xFFF5F5F5),
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      cardTheme: CardTheme(
        color: Colors.white,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      iconTheme: IconThemeData(
        color: Colors.red,
      ),
      textTheme: TextTheme(
        titleLarge: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
        titleMedium: TextStyle(color: Colors.black87),
        bodyLarge: TextStyle(color: Colors.black87),
        bodyMedium: TextStyle(color: Colors.black54),
      ),
    ),
  );

  // Dark theme
  static final dark = AppTheme(
    name: 'Dark',
    themeData: ThemeData(
      brightness: Brightness.dark,
      primaryColor: Colors.red,
      colorScheme: ColorScheme.dark(
        primary: Colors.red,
        secondary: Colors.blue,
        surface: Color(0xFF303030),
        background: Color(0xFF121212),
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: Colors.white,
        onBackground: Colors.white,
      ),
      scaffoldBackgroundColor: Color(0xFF121212),
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      cardTheme: CardTheme(
        color: Color(0xFF303030),
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      iconTheme: IconThemeData(
        color: Colors.red,
      ),
      textTheme: TextTheme(
        titleLarge: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        titleMedium: TextStyle(color: Colors.white),
        bodyLarge: TextStyle(color: Colors.white),
        bodyMedium: TextStyle(color: Colors.white70),
      ),
    ),
  );

  // Midnight Blue theme
  static final midnight = AppTheme(
    name: 'Midnight Blue',
    themeData: ThemeData(
      brightness: Brightness.dark,
      primaryColor: Colors.red,
      colorScheme: ColorScheme.dark(
        primary: Colors.red,
        secondary: Colors.lightBlue,
        surface: Color(0xFF253858),
        background: Color(0xFF172B4D),
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: Colors.white,
        onBackground: Colors.white,
      ),
      scaffoldBackgroundColor: Color(0xFF172B4D),
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      cardTheme: CardTheme(
        color: Color(0xFF253858),
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      iconTheme: IconThemeData(
        color: Colors.red,
      ),
      textTheme: TextTheme(
        titleLarge: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        titleMedium: TextStyle(color: Colors.white),
        bodyLarge: TextStyle(color: Colors.white),
        bodyMedium: TextStyle(color: Colors.white70),
      ),
    ),
  );

  // Nature theme
  static final nature = AppTheme(
    name: 'Nature',
    themeData: ThemeData(
      brightness: Brightness.light,
      primaryColor: Colors.red,
      colorScheme: ColorScheme.light(
        primary: Colors.red,
        secondary: Color(0xFF2E7D32),
        surface: Color(0xFFDCEDC8),
        background: Color(0xFFF1F8E9),
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: Color(0xFF33691E),
        onBackground: Color(0xFF33691E),
      ),
      scaffoldBackgroundColor: Color(0xFFF1F8E9),
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      cardTheme: CardTheme(
        color: Color(0xFFDCEDC8),
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      iconTheme: IconThemeData(
        color: Colors.red,
      ),
      textTheme: TextTheme(
        titleLarge: TextStyle(color: Color(0xFF33691E), fontWeight: FontWeight.bold),
        titleMedium: TextStyle(color: Color(0xFF33691E)),
        bodyLarge: TextStyle(color: Color(0xFF33691E)),
        bodyMedium: TextStyle(color: Color(0xFF558B2F)),
      ),
    ),
  );

  // Sunset theme
  static final sunset = AppTheme(
    name: 'Sunset',
    themeData: ThemeData(
      brightness: Brightness.light,
      primaryColor: Colors.red,
      colorScheme: ColorScheme.light(
        primary: Colors.red,
        secondary: Color(0xFFFF6F00),
        surface: Color(0xFFFFF8E1),
        background: Color(0xFFFFF3E0),
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: Color(0xFF4E342E),
        onBackground: Color(0xFF4E342E),
      ),
      scaffoldBackgroundColor: Color(0xFFFFF3E0),
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      cardTheme: CardTheme(
        color: Color(0xFFFFF8E1),
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      iconTheme: IconThemeData(
        color: Colors.red,
      ),
      textTheme: TextTheme(
        titleLarge: TextStyle(color: Color(0xFF4E342E), fontWeight: FontWeight.bold),
        titleMedium: TextStyle(color: Color(0xFF4E342E)),
        bodyLarge: TextStyle(color: Color(0xFF4E342E)),
        bodyMedium: TextStyle(color: Color(0xFF795548)),
      ),
    ),
  );

  // Purple Haze theme
  static final purpleHaze = AppTheme(
    name: 'Purple Haze',
    themeData: ThemeData(
      brightness: Brightness.dark,
      primaryColor: Colors.red,
      colorScheme: ColorScheme.dark(
        primary: Colors.red,
        secondary: Color(0xFF9C27B0),
        surface: Color(0xFF4A148C),
        background: Color(0xFF311B92),
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: Colors.white,
        onBackground: Colors.white,
      ),
      scaffoldBackgroundColor: Color(0xFF311B92),
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      cardTheme: CardTheme(
        color: Color(0xFF4A148C),
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      iconTheme: IconThemeData(
        color: Colors.red,
      ),
      textTheme: TextTheme(
        titleLarge: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        titleMedium: TextStyle(color: Colors.white),
        bodyLarge: TextStyle(color: Colors.white),
        bodyMedium: TextStyle(color: Colors.white70),
      ),
    ),
  );

  // All themes list
  static final List<AppTheme> availableThemes = [
    light,
    dark,
    midnight,
    nature,
    sunset,
    purpleHaze,
  ];
}