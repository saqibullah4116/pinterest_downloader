import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; 
import '../utils/constants.dart'; 
import '../utils/download_provider.dart'; 

class DownloadScreen extends StatelessWidget {
  const DownloadScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController _urlController = TextEditingController(); 

    return ChangeNotifierProvider(
      create: (_) => DownloadProvider(), 
      builder: (context, child) {
        final downloadProvider = Provider.of<DownloadProvider>(context); 

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: _urlController, 
                decoration: InputDecoration(
                  hintText: AppStrings.enterUrlHint,
                  border: const OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              if (downloadProvider.downloadStatus.isNotEmpty)
                Text(
                  downloadProvider.downloadStatus,
                  style: TextStyle(
                    color: downloadProvider.downloadStatus.contains('Error')
                        ? Colors.red
                        : Colors.green, 
                    fontWeight: FontWeight.bold,
                  ),
                ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: downloadProvider.isDownloading
                      ? null 
                      : () {
                          final url = _urlController.text.trim();
                          if (url.isNotEmpty) {
                            print("******************************************************");
                            print("******************************************************");
                            print("******************************************************");
                            print("******************************************************");
                            print("******************************************************");
                            print(url);
                            downloadProvider.downloadFile(url); 
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Please enter a valid URL'),
                              ),
                            );
                          }
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.pinterestRed,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.download, color: Colors.white, size: 25),
                      const SizedBox(width: 12),
                      Text(
                        AppStrings.downloadButton,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}