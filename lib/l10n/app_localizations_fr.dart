// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appTitle => 'Téléchargeur Pinterest';

  @override
  String get welcomeMessage => 'Bienvenue dans l\'application!';

  @override
  String get themeOptions => 'Options de Thème';

  @override
  String currentTheme(Object theme) {
    return 'Actuel: $theme';
  }

  @override
  String get selectTheme => 'Sélectionner le Thème';

  @override
  String get pinterest => 'Pinterest';

  @override
  String get light => 'Clair';

  @override
  String get dark => 'Sombre';

  @override
  String get midnightBlue => 'Bleu Minuit';

  @override
  String get nature => 'Nature';

  @override
  String get sunset => 'Coucher de Soleil';

  @override
  String get purpleHaze => 'Brume Pourpre';

  @override
  String get lightTheme => 'Thème clair';

  @override
  String get darkTheme => 'Thème sombre';

  @override
  String get privacyPolicy => 'Politique de Confidentialité';

  @override
  String get aboutUs => 'À Propos de Nous';

  @override
  String get selectThemeStyle => 'Sélectionnez votre style de thème préféré';

  @override
  String get download => 'Télécharger';

  @override
  String get myFiles => 'Mes Fichiers';

  @override
  String get pastePinterestUrl => 'Coller l\'URL de Pinterest';

  @override
  String get preview => 'Aperçu';

  @override
  String get adPlaceholder => 'Espace réservé pour la bannière publicitaire';

  @override
  String get reset => 'Réinitialiser';

  @override
  String get no_files_found => 'Aucun fichier trouvé';
}
