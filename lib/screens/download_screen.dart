import 'package:flutter/material.dart';
import 'package:pinterest_downloader/components/media_preview.dart';
import 'package:pinterest_downloader/provider/download_provider.dart';
import 'package:provider/provider.dart';
import '../utils/constants.dart';
import '../provider/preview_provider.dart'; // For preview functionality

class DownloadScreen extends StatelessWidget {
  const DownloadScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController _urlController = TextEditingController();
    final previewProvider = Provider.of<PreviewProvider>(context);
    final downloadProvider = Provider.of<DownloadProvider>(context);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
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
            if (previewProvider.previewStatus.isNotEmpty)
              Text(
                previewProvider.previewStatus,
                style: TextStyle(
                  color:
                      previewProvider.previewStatus.contains('Error')
                          ? Colors.red
                          : Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),
            const SizedBox(height: 20),
            if (previewProvider.previewImageUrl != null &&
                previewProvider.mediaType != null)
              MediaPreview(
                mediaUrl: previewProvider.previewImageUrl!,
                mediaType: previewProvider.mediaType!,
              ),
            const SizedBox(height: 20),
            if (previewProvider.previewImageUrl == null)
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed:
                      previewProvider.isFetchingPreview
                          ? null
                          : () {
                            final url = _urlController.text.trim();
                            if (url.isNotEmpty) {
                              previewProvider.fetchPreview(url);
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Please enter a valid URL'),
                                ),
                              );
                            }
                          },
                  icon: const Icon(
                    Icons.remove_red_eye,
                    size: 25,
                    color: Colors.white,
                  ),
                  label: const Text(
                    'Preview',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.pinterestRed,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                ),
              ),
            if (previewProvider.previewImageUrl != null)
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed:
                      downloadProvider.isDownloading
                          ? null
                          : () {
                            final url = _urlController.text.trim();
                            final previewUrl = previewProvider.previewImageUrl;
                            final mediaType = previewProvider.mediaType ?? '';

                            if (mediaType == 'image' &&
                                previewUrl != null &&
                                previewUrl.isNotEmpty) {
                              // If it's an image, use previewUrl directly
                              downloadProvider.downloadFile(
                                previewUrl,
                                mediaType,
                                previewUrl,
                              );
                            } else if (url.isNotEmpty) {
                              // Otherwise, use user-entered URL
                              downloadProvider.downloadFile(
                                url,
                                mediaType,
                                previewUrl ?? '',
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    'Please enter a valid URL or select an image',
                                  ),
                                ),
                              );
                            }
                          },
                  icon: const Icon(
                    Icons.download,
                    size: 25,
                    color: Colors.white,
                  ),
                  label: const Text(
                    'Download',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.pinterestRed,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                ),
              ),

            const SizedBox(height: 20),
            if (downloadProvider.downloadStatus.isNotEmpty)
              Text(
                downloadProvider.downloadStatus,
                style: TextStyle(
                  color:
                      downloadProvider.downloadStatus.contains('Error')
                          ? Colors.red
                          : Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
