// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Turkish (`tr`).
class AppLocalizationsTr extends AppLocalizations {
  AppLocalizationsTr([String locale = 'tr']) : super(locale);

  @override
  String get appTitle => 'Pinterest İndirici';

  @override
  String get welcomeMessage => 'Uygulamaya hoş geldiniz!';

  @override
  String get themeOptions => 'Tema Seçenekleri';

  @override
  String currentTheme(Object theme) {
    return 'Mevcut: $theme';
  }

  @override
  String get selectTheme => 'Tema Seç';

  @override
  String get pinterest => 'Pinterest';

  @override
  String get light => 'Açık';

  @override
  String get dark => 'Koyu';

  @override
  String get midnightBlue => 'Gece Yarısı Mavisi';

  @override
  String get nature => 'Doğa';

  @override
  String get sunset => 'Gün Batımı';

  @override
  String get purpleHaze => 'Mor Sis';

  @override
  String get lightTheme => 'Açık tema';

  @override
  String get darkTheme => 'Koyu tema';

  @override
  String get privacyPolicy => 'Gizlilik Politikası';

  @override
  String get aboutUs => 'Hakkımızda';

  @override
  String get selectThemeStyle => 'Tercih ettiğiniz tema stilini seçin';

  @override
  String get download => 'İndir';

  @override
  String get myFiles => 'Dosyalarım';

  @override
  String get pastePinterestUrl => 'Pinterest URL\'sini yapıştırın';

  @override
  String get preview => 'Önizleme';

  @override
  String get adPlaceholder => 'Reklam Afişi Yer Tutucu';

  @override
  String get reset => 'Sıfırla';

  @override
  String get no_files_found => 'Dosya bulunamadı';
}
