// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Pinterest Downloader';

  @override
  String get welcomeMessage => 'Welcome to the app!';

  @override
  String get themeOptions => 'Theme Options';

  @override
  String currentTheme(Object theme) {
    return 'Current: $theme';
  }

  @override
  String get selectTheme => 'Select Theme';

  @override
  String get pinterest => 'Pinterest';

  @override
  String get light => 'Light';

  @override
  String get dark => 'Dark';

  @override
  String get midnightBlue => 'Midnight Blue';

  @override
  String get nature => 'Nature';

  @override
  String get sunset => 'Sunset';

  @override
  String get purpleHaze => 'Purple Haze';

  @override
  String get lightTheme => 'Light theme';

  @override
  String get darkTheme => 'Dark theme';

  @override
  String get privacyPolicy => 'Privacy Policy';

  @override
  String get aboutUs => 'About Us';

  @override
  String get selectThemeStyle => 'Select your preferred theme style';

  @override
  String get download => 'Download';

  @override
  String get myFiles => 'My Files';

  @override
  String get pastePinterestUrl => 'Paste Pinterest URL';

  @override
  String get preview => 'Preview And Download';

  @override
  String get adPlaceholder => 'Ad Banner Placeholder';

  @override
  String get reset => 'Reset';

  @override
  String get no_files_found => 'No files found';
}
