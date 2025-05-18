import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PreviewBottomSheet extends StatelessWidget {
  final String imageUrl;
  final String mediaSize;
  final String mediaType;
  final bool isDownloading;
  final VoidCallback onDownload;
  final VoidCallback onReset;
  final String downloadStatus;
  final double progress;

  const PreviewBottomSheet({
    super.key,
    required this.imageUrl,
    required this.mediaSize,
    required this.mediaType,
    required this.isDownloading,
    required this.onDownload,
    required this.onReset,
    required this.downloadStatus,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Image.network(imageUrl, fit: BoxFit.cover),
                ),
              ),
              title: Text(
                mediaSize,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                mediaType,
                style: const TextStyle(color: Colors.black54),
              ),
              trailing:
                  isDownloading
                      ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                      : IconButton(
                        icon: const Icon(
                          Icons.download_rounded,
                          color: Colors.blue,
                        ),
                        tooltip: 'Download',
                        onPressed: onDownload,
                      ),
            ),
          ),

          if (isDownloading)
            Padding(
              padding: const EdgeInsets.only(top: 24),
              child: Column(
                children: [
                  LinearProgressIndicator(
                    value: progress > 0 ? progress : null,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${(progress * 100).toStringAsFixed(0)}%',
                    style: const TextStyle(color: Colors.green),
                  ),
                ],
              ),
            ),

          const SizedBox(height: 12),

          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: () {
                onReset();
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.refresh),
              label: Text(AppLocalizations.of(context).reset),
            ),
          ),
        ],
      ),
    );
  }
}
