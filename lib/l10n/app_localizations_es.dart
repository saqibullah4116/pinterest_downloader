// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'Descargador de Pinterest';

  @override
  String get welcomeMessage => '¡Bienvenido a la aplicación!';

  @override
  String get themeOptions => 'Opciones de Tema';

  @override
  String currentTheme(Object theme) {
    return 'Actual: $theme';
  }

  @override
  String get selectTheme => 'Seleccionar Tema';

  @override
  String get pinterest => 'Pinterest';

  @override
  String get light => 'Claro';

  @override
  String get dark => 'Oscuro';

  @override
  String get midnightBlue => 'Azul Medianoche';

  @override
  String get nature => 'Naturaleza';

  @override
  String get sunset => 'Atardecer';

  @override
  String get purpleHaze => 'Niebla Púrpura';

  @override
  String get lightTheme => 'Tema claro';

  @override
  String get darkTheme => 'Tema oscuro';

  @override
  String get privacyPolicy => 'Política de Privacidad';

  @override
  String get aboutUs => 'Sobre Nosotros';

  @override
  String get selectThemeStyle => 'Seleccione su estilo de tema preferido';

  @override
  String get download => 'Descargar';

  @override
  String get myFiles => 'Mis Archivos';

  @override
  String get pastePinterestUrl => 'Pegar URL de Pinterest';

  @override
  String get preview => 'Vista previa';

  @override
  String get adPlaceholder => 'Espacio reservado para banner publicitario';

  @override
  String get reset => 'Restablecer';

  @override
  String get no_files_found => 'No se encontraron archivos';
}
