import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/preview_provider.dart';
import '../provider/download_provider.dart';

class DownloadScreen extends StatefulWidget {
  const DownloadScreen({super.key});

  @override
  State<DownloadScreen> createState() => _DownloadScreenState();
}

class _DownloadScreenState extends State<DownloadScreen> {
  final TextEditingController _urlController = TextEditingController();
  bool _previewFetched = false;

  void _handleFetchPreview() async {
    final url = _urlController.text.trim();
    if (url.isNotEmpty) {
      await context.read<PreviewProvider>().fetchPreview(url);
      final previewUrl = context.read<PreviewProvider>().previewImageUrl;
      if (previewUrl != null) {
        setState(() {
          _previewFetched = true;
        });
      }
    }
  }

  void _handleDownload() {
    final previewProvider = context.read<PreviewProvider>();
    final downloadProvider = context.read<DownloadProvider>();

    downloadProvider.downloadFile(
      _urlController.text.trim(),
      previewProvider.mediaType ?? '',
      previewProvider.previewImageUrl ?? '',
    );
  }

  void _handleReset() {
    _urlController.clear();
    context.read<PreviewProvider>().resetPreview();
    context.read<DownloadProvider>().downloadStatus;
    setState(() {
      _previewFetched = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final previewProvider = context.watch<PreviewProvider>();
    final downloadProvider = context.watch<DownloadProvider>();

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextField(
            controller: _urlController,
            decoration: const InputDecoration(
              labelText: 'Paste Pinterest URL',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 20),

          if (!_previewFetched && !previewProvider.isFetchingPreview)
            ElevatedButton(
              onPressed: _handleFetchPreview,
              child: const Text('Preview'),
            ),

          if (previewProvider.isFetchingPreview)
            const CircularProgressIndicator(),

          const SizedBox(height: 20),

          if (_previewFetched && previewProvider.previewImageUrl != null)
            Card(
              elevation: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.network(previewProvider.previewImageUrl!),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      'Type: ${previewProvider.mediaType}',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: downloadProvider.isDownloading
                        ? null
                        : _handleDownload,
                    child: downloadProvider.isDownloading
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : const Text('Download'),
                  ),
                  if (downloadProvider.downloadStatus.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(downloadProvider.downloadStatus),
                    ),
                  TextButton(
                    onPressed: _handleReset,
                    child: const Text('Reset'),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
