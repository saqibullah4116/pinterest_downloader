import 'package:flutter/material.dart';
import 'package:pinterest_downloader/provider/auth_provider.dart';
import 'package:pinterest_downloader/provider/language_provider.dart';
import 'package:pinterest_downloader/provider/theme_provider.dart';
import 'package:pinterest_downloader/theme/theme_drawer.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'utils/constants.dart';
import 'screens/home_screen.dart';
import 'screens/language_setup_screen.dart';
import 'provider/preview_provider.dart';
import 'provider/download_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => PreviewProvider()),
        ChangeNotifierProvider(create: (context) => DownloadProvider()),
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
        ChangeNotifierProvider(create: (context) => AuthProvider()),
        ChangeNotifierProvider(create: (context) => LanguageProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    if (!themeProvider.isLoaded) {
      return MaterialApp(
        home: Scaffold(
          body: Center(child: CircularProgressIndicator(color: Colors.red)),
        ),
      );
    }

    return Consumer<LanguageProvider>(
      builder: (context, languageProvider, _) {
        return MaterialApp(
          title: AppStrings.appName,
          theme: themeProvider.themeData,
          locale: languageProvider.locale,
          supportedLocales: const [
            Locale('en'),
            Locale('ur'),
            Locale('fr'),
            Locale('hi'),
            Locale('bn'),
            Locale('es'),
            Locale('de'),
            Locale('tr'),
            Locale('pt'),
            Locale('id'),
          ],
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          home:
              languageProvider.isLanguageChosen
                  ? const MyHomePage()
                  : const LanguageSetupScreen(),
        );
      },
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkTheme = themeProvider.themeData.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context).appTitle,
          style: TextStyle(
            color: isDarkTheme ? Colors.white : AppColors.pinterestBlack,
          ),
        ),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: Icon(
                Icons.menu,
                color: isDarkTheme ? Colors.white : AppColors.pinterestBlack,
              ),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
        actions: [
          Consumer<LanguageProvider>(
            builder: (context, languageProvider, _) {
              final langCode = languageProvider.locale.languageCode;

              final flagMap = {
                'en': '🇺🇸',
                'ur': '🇵🇰',
                'fr': '🇫🇷',
                'hi': '🇮🇳',
                'bn': '🇧🇩',
                'es': '🇪🇸',
                'de': '🇩🇪',
                'tr': '🇹🇷',
                'pt': '🇧🇷 ',
                'id': '🇮🇩',
              };

              return PopupMenuButton<String>(
                icon: Text(
                  flagMap[langCode] ?? '🌐',
                  style: const TextStyle(fontSize: 24),
                ),
                onSelected: (String code) {
                  languageProvider.setLocale(Locale(code));
                },
                itemBuilder: (BuildContext context) {
                  final languageOptions = {
                    'en': '🇺🇸 English',
                    'ur': '🇵🇰 Urdu',
                    'fr': '🇫🇷 French',
                    'hi': '🇮🇳 Hindi',
                    'bn': '🇧🇩 Bangla',
                    'es': '🇪🇸 Spanish',
                    'de': '🇩🇪 German',
                    'tr': '🇹🇷 Turkish',
                    'pt': '🇧🇷 Portuguese (Brazil)',
                    'id': '🇮🇩 Indonesian',
                  };

                  return languageOptions.entries.map((entry) {
                    return PopupMenuItem<String>(
                      value: entry.key,
                      child: Text(entry.value),
                    );
                  }).toList();
                },
              );
            },
          ),
        ],
      ),
      drawer: ThemeDrawer(),
      body: const HomeScreen(),
    );
  }
}
