import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; 
import 'utils/constants.dart'; 
import 'screens/home_screen.dart'; 
import 'utils/download_provider.dart'; 

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => DownloadProvider(), 
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppStrings.appName,
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            AppStrings.appName,
            style: TextStyle(color: AppColors.pinterestBlack),
          ),
          leading: IconButton(
            icon: const Icon(Icons.menu, color: AppColors.pinterestBlack),
            onPressed: () {},
          ),
          actions: [
            PopupMenuButton<String>(
              icon: const Icon(Icons.language, color: AppColors.pinterestBlack),
              onSelected: (String value) {
                print('Selected language: $value');
              },
              itemBuilder: (BuildContext context) {
                return {'English', 'Spanish', 'French', 'German'}.map((String choice) {
                  return PopupMenuItem<String>(
                    value: choice,
                    child: Text(choice),
                  );
                }).toList();
              },
            ),
          ],
        ),
        body: const HomeScreen(),
      ),
    );
  }
}