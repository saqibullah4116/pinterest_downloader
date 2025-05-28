// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get appTitle => 'Pinterest Downloader';

  @override
  String get welcomeMessage => 'Willkommen in der App!';

  @override
  String get themeOptions => 'Themenoptionen';

  @override
  String currentTheme(Object theme) {
    return 'Aktuell: $theme';
  }

  @override
  String get selectTheme => 'Thema auswählen';

  @override
  String get pinterest => 'Pinterest';

  @override
  String get light => 'Hell';

  @override
  String get dark => 'Dunkel';

  @override
  String get midnightBlue => 'Mitternachtsblau';

  @override
  String get nature => 'Natur';

  @override
  String get sunset => 'Sonnenuntergang';

  @override
  String get purpleHaze => 'Lila Dunst';

  @override
  String get lightTheme => 'Helles Thema';

  @override
  String get darkTheme => 'Dunkles Thema';

  @override
  String get privacyPolicy => 'Datenschutzrichtlinie';

  @override
  String get aboutUs => 'Über uns';

  @override
  String get selectThemeStyle => 'Wählen Sie Ihren bevorzugten Themenstil';

  @override
  String get download => 'Herunterladen';

  @override
  String get myFiles => 'Meine Dateien';

  @override
  String get pastePinterestUrl => 'Pinterest-URL einfügen';

  @override
  String get preview => 'Vorschau';

  @override
  String get adPlaceholder => 'Anzeigenbanner-Platzhalter';

  @override
  String get reset => 'Zurücksetzen';

  @override
  String get no_files_found => 'Keine Dateien gefunden';
}
