import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../utils/constants.dart';
import 'download_screen.dart';
import 'my_files_screen.dart';
import '../provider/auth_provider.dart'; // import your AuthProvider

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
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          toolbarHeight: 0,
          bottom: TabBar(
            indicatorColor: AppColors.pinterestRed,
            labelColor: AppColors.pinterestRed,
            unselectedLabelColor: AppColors.pinterestBlack,
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
                bottom: BorderSide(color: AppColors.pinterestRed, width: 4.0),
              ),
            ),
            indicatorSize: TabBarIndicatorSize.tab,
            indicatorWeight: 4.0,
            tabs: const [Tab(text: 'DOWNLOAD'), Tab(text: 'MY FILES')],
          ),
        ),
        body: const TabBarView(
          children: [
            DownloadScreen(),
            MyFilesScreen(),
          ],
        ),
      ),
    );
  }
}
