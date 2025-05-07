import 'package:flutter/material.dart';
import 'package:pinterest_downloader/provider/auth_provider.dart';
import 'package:pinterest_downloader/provider/theme_provider.dart';
import 'package:pinterest_downloader/theme/theme_drawer.dart';
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

    return MaterialApp(
      title: AppStrings.appName,
      theme: themeProvider.themeData,
      home: MyHomePage(),
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
          AppStrings.appName,
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
              print('Selected language: $value');
            },
            itemBuilder: (BuildContext context) {
              return {'English', 'Spanish', 'French', 'German'}.map((
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
