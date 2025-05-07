// lib/provider/theme_provider.dart

import 'package:flutter/material.dart';
import 'package:pinterest_downloader/theme/app_themes.dart';
import 'package:shared_preferences/shared_preferences.dart';


class ThemeProvider extends ChangeNotifier {
  // ignore: constant_identifier_names
  static const String THEME_KEY = 'theme_preference';
  
  late AppTheme _currentTheme;
  late SharedPreferences _prefs;
  bool _isLoaded = false;

  ThemeProvider() {
    _currentTheme = AppThemes.all.first; // Pinterest by default
    _loadThemePreference();
  }

  AppTheme get currentTheme => _currentTheme;
  ThemeData get themeData => _currentTheme.themeData;
  bool get isLoaded => _isLoaded;

  static List<AppTheme> get availableThemes => AppThemes.all;

  Future<void> _loadThemePreference() async {
    _prefs = await SharedPreferences.getInstance();
    String? themeName = _prefs.getString(THEME_KEY);

    if (themeName != null) {
      for (var theme in AppThemes.all) {
        if (theme.name == themeName) {
          _currentTheme = theme;
          break;
        }
      }
    }

    _isLoaded = true;
    notifyListeners();
  }

  Future<void> setTheme(AppTheme theme) async {
    _currentTheme = theme;
    await _prefs.setString(THEME_KEY, theme.name);
    notifyListeners();
  }
}
