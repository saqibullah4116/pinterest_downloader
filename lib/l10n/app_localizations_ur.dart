// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Urdu (`ur`).
class AppLocalizationsUr extends AppLocalizations {
  AppLocalizationsUr([String locale = 'ur']) : super(locale);

  @override
  String get appTitle => 'پنٹیرسٹ ڈاؤنلوڈر';

  @override
  String get welcomeMessage => 'ایپ میں خوش آمدید!';

  @override
  String get themeOptions => 'تھیم کے اختیارات';

  @override
  String currentTheme(Object theme) {
    return 'موجودہ: $theme';
  }

  @override
  String get selectTheme => 'تھیم منتخب کریں';

  @override
  String get pinterest => 'پنٹیرسٹ';

  @override
  String get light => 'ہلکا';

  @override
  String get dark => 'گہرا';

  @override
  String get midnightBlue => 'آدھی رات نیلا';

  @override
  String get nature => 'قدرت';

  @override
  String get sunset => 'سورج غروب';

  @override
  String get purpleHaze => 'ارغوانی دھند';

  @override
  String get lightTheme => 'ہلکی تھیم';

  @override
  String get darkTheme => 'گہری تھیم';

  @override
  String get privacyPolicy => 'رازداری کی پالیسی';

  @override
  String get aboutUs => 'ہمارے بارے میں';

  @override
  String get selectThemeStyle => 'اپنی پسندیدہ تھیم اسٹائل منتخب کریں';

  @override
  String get download => 'ڈاؤن لوڈ';

  @override
  String get myFiles => 'میری فائلیں';

  @override
  String get pastePinterestUrl => 'Pinterest URL چسپاں کریں';

  @override
  String get preview => 'پیش نظارہ';

  @override
  String get adPlaceholder => 'اشتہار بینر پلیس ہولڈر';

  @override
  String get reset => 'ری سیٹ کریں';

  @override
  String get no_files_found => 'کوئی فائل نہیں ملی';
}
