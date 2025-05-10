import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageProvider with ChangeNotifier {
  static const String _languageCodeKey = 'selected_language_code';
  static const String _languageSetFlag = 'is_language_set';

  Locale _locale = const Locale('en');
  bool _isLanguageChosen = false;

  Locale get locale => _locale;
  bool get isLanguageChosen => _isLanguageChosen;

  LanguageProvider() {
    _loadSavedLocale();
  }

  Future<void> _loadSavedLocale() async {
    final prefs = await SharedPreferences.getInstance();
    final code = prefs.getString(_languageCodeKey);
    _isLanguageChosen = prefs.getBool(_languageSetFlag) ?? false;

    if (code != null) {
      _locale = Locale(code);
    }
    notifyListeners();
  }

  Future<void> setLocale(Locale newLocale) async {
    if (_locale == newLocale) return;
    _locale = newLocale;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_languageCodeKey, newLocale.languageCode);
    await prefs.setBool(_languageSetFlag, true);
    _isLanguageChosen = true;
    notifyListeners();
  }

  Future<void> clearLocale() async {
    _locale = const Locale('en');
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_languageCodeKey);
    await prefs.remove(_languageSetFlag);
    _isLanguageChosen = false;
    notifyListeners();
  }

  Future<void> checkIfLanguageIsSet() async {
    final prefs = await SharedPreferences.getInstance();
    _isLanguageChosen = prefs.getBool(_languageSetFlag) ?? false;
    notifyListeners();
  }
}
