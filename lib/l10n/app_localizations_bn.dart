// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Bengali Bangla (`bn`).
class AppLocalizationsBn extends AppLocalizations {
  AppLocalizationsBn([String locale = 'bn']) : super(locale);

  @override
  String get appTitle => 'পিন্টারেস্ট ডাউনলোডার';

  @override
  String get welcomeMessage => 'অ্যাপে স্বাগতম!';

  @override
  String get themeOptions => 'থিম অপশন';

  @override
  String currentTheme(Object theme) {
    return 'বর্তমান: $theme';
  }

  @override
  String get selectTheme => 'থিম নির্বাচন করুন';

  @override
  String get pinterest => 'পিন্টারেস্ট';

  @override
  String get light => 'হালকা';

  @override
  String get dark => 'গা dark ়';

  @override
  String get midnightBlue => 'মধ্যরাতের নীল';

  @override
  String get nature => 'প্রকৃতি';

  @override
  String get sunset => 'সূর্যাস্ত';

  @override
  String get purpleHaze => 'বেগুনি ধোঁয়া';

  @override
  String get lightTheme => 'হালকা থিম';

  @override
  String get darkTheme => 'গা dark ় থিম';

  @override
  String get privacyPolicy => 'গোপনীয়তা নীতি';

  @override
  String get aboutUs => 'আমাদের সম্পর্কে';

  @override
  String get selectThemeStyle => 'আপনার পছন্দসই থিম শৈলী নির্বাচন করুন';

  @override
  String get download => 'ডাউনলোড';

  @override
  String get myFiles => 'আমার ফাইল';

  @override
  String get pastePinterestUrl => 'Pinterest URL পেস্ট করুন';

  @override
  String get preview => 'প্রিভিউ';

  @override
  String get adPlaceholder => 'বিজ্ঞাপন ব্যানার স্থানধারক';

  @override
  String get reset => 'রিসেট করুন';

  @override
  String get no_files_found => 'No files found';
}
