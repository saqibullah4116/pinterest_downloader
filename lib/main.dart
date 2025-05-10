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

    // Show loading indicator while theme is loading
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
          supportedLocales: [
            Locale('en'),
            Locale('ur'),
            Locale('fr'),
            Locale('hi'),
            Locale('bn'),
          ],
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          home: MyHomePage(),
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
          PopupMenuButton<String>(
            icon: Icon(
              Icons.language,
              color: isDarkTheme ? Colors.white : AppColors.pinterestBlack,
            ),
            onSelected: (String value) {
              final languageProvider = Provider.of<LanguageProvider>(
                context,
                listen: false,
              );
              switch (value) {
                case 'Urdu':
                  languageProvider.setLocale(const Locale('ur'));
                  break;
                case 'French':
                  languageProvider.setLocale(const Locale('fr'));
                  break;
                case 'Hindi':
                  languageProvider.setLocale(const Locale('hi'));
                  break;
                case 'Bangla':
                  languageProvider.setLocale(const Locale('bn'));
                  break;
                case 'English':
                default:
                  languageProvider.setLocale(const Locale('en'));
              }
            },
            itemBuilder: (BuildContext context) {
              return {'English', 'Urdu', 'French', 'Hindi', 'Bangla'}.map((
                String choice,
              ) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          ),
        ],
      ),
      drawer: ThemeDrawer(),
      body: const HomeScreen(),
    );
  }
}
