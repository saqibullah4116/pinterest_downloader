// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get appTitle => 'Downloader do Pinterest';

  @override
  String get welcomeMessage => 'Bem-vindo ao aplicativo!';

  @override
  String get themeOptions => 'Opções de Tema';

  @override
  String currentTheme(Object theme) {
    return 'Atual: $theme';
  }

  @override
  String get selectTheme => 'Selecionar Tema';

  @override
  String get pinterest => 'Pinterest';

  @override
  String get light => 'Claro';

  @override
  String get dark => 'Escuro';

  @override
  String get midnightBlue => 'Azul Meia-Noite';

  @override
  String get nature => 'Natureza';

  @override
  String get sunset => 'Pôr do Sol';

  @override
  String get purpleHaze => 'Névoa Roxa';

  @override
  String get lightTheme => 'Tema claro';

  @override
  String get darkTheme => 'Tema escuro';

  @override
  String get privacyPolicy => 'Política de Privacidade';

  @override
  String get aboutUs => 'Sobre Nós';

  @override
  String get selectThemeStyle => 'Selecione seu estilo de tema preferido';

  @override
  String get download => 'Baixar';

  @override
  String get myFiles => 'Meus Arquivos';

  @override
  String get pastePinterestUrl => 'Cole o URL do Pinterest';

  @override
  String get preview => 'Pré-visualização';

  @override
  String get adPlaceholder => 'Espaço Reservado para Banner de Anúncio';

  @override
  String get reset => 'Redefinir';

  @override
  String get no_files_found => 'Nenhum arquivo encontrado';
}
