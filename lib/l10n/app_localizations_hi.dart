// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Hindi (`hi`).
class AppLocalizationsHi extends AppLocalizations {
  AppLocalizationsHi([String locale = 'hi']) : super(locale);

  @override
  String get appTitle => 'पिंटरेस्ट डाउनलोडर';

  @override
  String get welcomeMessage => 'एप में आपका स्वागत है!';

  @override
  String get themeOptions => 'थीम विकल्प';

  @override
  String currentTheme(Object theme) {
    return 'वर्तमान: $theme';
  }

  @override
  String get selectTheme => 'थीम चुनें';

  @override
  String get pinterest => 'पिंटरेस्ट';

  @override
  String get light => 'हल्का';

  @override
  String get dark => 'गहरा';

  @override
  String get midnightBlue => 'मिडनाइट ब्लू';

  @override
  String get nature => 'प्रकृति';

  @override
  String get sunset => 'सूर्यास्त';

  @override
  String get purpleHaze => 'बैंगनी धुंध';

  @override
  String get lightTheme => 'हल्का थीम';

  @override
  String get darkTheme => 'गहरा थीम';

  @override
  String get privacyPolicy => 'गोपनीयता नीति';

  @override
  String get aboutUs => 'हमारे बारे में';

  @override
  String get selectThemeStyle => 'अपनी पसंदीदा थीम शैली चुनें';

  @override
  String get download => 'डाउनलोड';

  @override
  String get myFiles => 'मेरी फ़ाइलें';

  @override
  String get pastePinterestUrl => 'Pinterest URL पेस्ट करें';

  @override
  String get preview => 'पूर्वावलोकन';

  @override
  String get adPlaceholder => 'विज्ञापन स्थान';

  @override
  String get reset => 'रीसेट करें';

  @override
  String get no_files_found => 'No files found';
}
