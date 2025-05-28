import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:pinterest_downloader/components/language_selector_menu.dart';
import 'package:pinterest_downloader/l10n/app_localizations.dart';
import 'package:pinterest_downloader/provider/auth_provider.dart';
import 'package:pinterest_downloader/provider/language_provider.dart';
import 'package:pinterest_downloader/provider/theme_provider.dart';
import 'package:pinterest_downloader/screens/on_boarding_screen.dart';
import 'package:pinterest_downloader/theme/theme_drawer.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'utils/constants.dart';
import 'screens/home_screen.dart';
import 'provider/preview_provider.dart';
import 'provider/download_provider.dart';

Future<void> main() async {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => PreviewProvider()),
        ChangeNotifierProvider(create: (context) => DownloadProvider()),
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
        ChangeNotifierProvider(create: (context) => AuthProvider()),
        ChangeNotifierProvider(create: (context) => LanguageProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isOnboardingComplete = false;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _checkOnboardingStatus();
  }

  Future<void> _checkOnboardingStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final completed = prefs.getBool('onboarding_complete') ?? false;
    setState(() {
      _isOnboardingComplete = completed;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    if (!themeProvider.isLoaded || _isLoading) {
      return MaterialApp(
        home: Scaffold(
          body: Center(child: CircularProgressIndicator(color: Colors.red)),
        ),
      );
    }

    return Consumer<LanguageProvider>(
      builder: (context, languageProvider, _) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
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
              _isOnboardingComplete
                  ? const MyHomePage()
                  : const OnboardingScreen(),
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
        actions: [LanguageSelector()],
      ),
      drawer: ThemeDrawer(),
      body: const HomeScreen(),
    );
  }
}
