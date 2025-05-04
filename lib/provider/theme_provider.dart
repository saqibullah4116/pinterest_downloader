// lib/provider/theme_provider.dart

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Theme class to store custom themes
class AppTheme {
  final String name;
  final ThemeData themeData;

  AppTheme({required this.name, required this.themeData});
}

class ThemeProvider extends ChangeNotifier {
  static const String THEME_KEY = 'theme_preference';
  
  late AppTheme _currentTheme;
  late SharedPreferences _prefs;
  bool _isLoaded = false;

  // All themes
  static final light = AppTheme(
    name: 'Light',
    themeData: ThemeData(
      brightness: Brightness.light,
      primarySwatch: Colors.red,
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
    ),
  );

  static final dark = AppTheme(
    name: 'Dark',
    themeData: ThemeData(
      brightness: Brightness.dark,
      primarySwatch: Colors.red,
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
    ),
  );

  static final midnight = AppTheme(
    name: 'Midnight Blue',
    themeData: ThemeData(
      brightness: Brightness.dark,
      primarySwatch: Colors.red,
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
    ),
  );

  static final nature = AppTheme(
    name: 'Nature',
    themeData: ThemeData(
      brightness: Brightness.light,
      primarySwatch: Colors.red,
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
    ),
  );

  static final sunset = AppTheme(
    name: 'Sunset',
    themeData: ThemeData(
      brightness: Brightness.light,
      primarySwatch: Colors.red,
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
    ),
  );

  static final purpleHaze = AppTheme(
    name: 'Purple Haze',
    themeData: ThemeData(
      brightness: Brightness.dark,
      primarySwatch: Colors.red,
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

  ThemeProvider() {
    _currentTheme = light; // Default theme
    _loadThemePreference();
  }

  // Getter for current theme
  AppTheme get currentTheme => _currentTheme;
  ThemeData get themeData => _currentTheme.themeData;
  bool get isLoaded => _isLoaded;

  // Load theme from SharedPreferences
  Future<void> _loadThemePreference() async {
    _prefs = await SharedPreferences.getInstance();
    String? themeName = _prefs.getString(THEME_KEY);
    
    if (themeName != null) {
      for (var theme in availableThemes) {
        if (theme.name == themeName) {
          _currentTheme = theme;
          break;
        }
      }
    }
    
    _isLoaded = true;
    notifyListeners();
  }

  // Set new theme
  Future<void> setTheme(AppTheme theme) async {
    _currentTheme = theme;
    await _prefs.setString(THEME_KEY, theme.name);
    notifyListeners();
  }
}