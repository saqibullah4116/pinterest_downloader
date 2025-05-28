import 'package:flutter/material.dart';
import 'package:pinterest_downloader/l10n/app_localizations.dart';
import 'package:pinterest_downloader/provider/theme_provider.dart';
import 'package:provider/provider.dart';
import '../utils/constants.dart';
import 'download_screen.dart';
import 'my_files_screen.dart';
import '../provider/auth_provider.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<AuthProvider>(context, listen: false).fetchToken();
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkTheme = themeProvider.themeData.brightness == Brightness.dark;
    final theme = Theme.of(context);
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: theme.colorScheme.surface,
          toolbarHeight: 0,
          bottom: TabBar(
            indicatorColor: AppColors.pinterestRed,
            labelColor: theme.colorScheme.primary,
            unselectedLabelColor: isDarkTheme ? Colors.white : AppColors.pinterestBlack,
            labelStyle: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16.0,
            ),
            unselectedLabelStyle: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16.0,
            ),
            indicator: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: theme.colorScheme.secondary,
                  width: 4.0,
                ),
              ),
            ),
            indicatorSize: TabBarIndicatorSize.tab,
            indicatorWeight: 4.0,
            tabs: [
              Tab(text: AppLocalizations.of(context).download),
              Tab(text: AppLocalizations.of(context).myFiles),
            ],
          ),
        ),
        body: const TabBarView(children: [DownloadScreen(), MyFilesScreen()]),
      ),
    );
  }
}
