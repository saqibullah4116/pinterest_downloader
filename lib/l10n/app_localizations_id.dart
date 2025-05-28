// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Indonesian (`id`).
class AppLocalizationsId extends AppLocalizations {
  AppLocalizationsId([String locale = 'id']) : super(locale);

  @override
  String get appTitle => 'Pengunduh Pinterest';

  @override
  String get welcomeMessage => 'Selamat datang di aplikasi!';

  @override
  String get themeOptions => 'Opsi Tema';

  @override
  String currentTheme(Object theme) {
    return 'Saat ini: $theme';
  }

  @override
  String get selectTheme => 'Pilih Tema';

  @override
  String get pinterest => 'Pinterest';

  @override
  String get light => 'Terang';

  @override
  String get dark => 'Gelap';

  @override
  String get midnightBlue => 'Biru Tengah Malam';

  @override
  String get nature => 'Alam';

  @override
  String get sunset => 'Senja';

  @override
  String get purpleHaze => 'Kabut Ungu';

  @override
  String get lightTheme => 'Tema terang';

  @override
  String get darkTheme => 'Tema gelap';

  @override
  String get privacyPolicy => 'Kebijakan Privasi';

  @override
  String get aboutUs => 'Tentang Kami';

  @override
  String get selectThemeStyle => 'Pilih gaya tema yang Anda sukai';

  @override
  String get download => 'Unduh';

  @override
  String get myFiles => 'File Saya';

  @override
  String get pastePinterestUrl => 'Tempel URL Pinterest';

  @override
  String get preview => 'Pratinjau';

  @override
  String get adPlaceholder => 'Placeholder Iklan Banner';

  @override
  String get reset => 'Atur Ulang';

  @override
  String get no_files_found => 'Tidak ada file ditemukan';
}
