import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../components/preview_bottom_sheet.dart';
import '../provider/preview_provider.dart';
import '../provider/download_provider.dart';

class DownloadScreen extends StatefulWidget {
  const DownloadScreen({super.key});

  @override
  State<DownloadScreen> createState() => _DownloadScreenState();
}

class _DownloadScreenState extends State<DownloadScreen> {
  final TextEditingController _urlController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _urlController.addListener(_onUrlChanged);
  }

  @override
  void dispose() {
    _urlController.removeListener(_onUrlChanged);
    _urlController.dispose();
    super.dispose();
  }

  void _onUrlChanged() {
    setState(() {});
  }

  void _handleFetchPreview() async {
    final url = _urlController.text.trim();
    if (url.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please paste a valid Pinterest URL')),
      );
      return;
    }

    final previewProvider = context.read<PreviewProvider>();
    await previewProvider.fetchPreview(url);

    if (previewProvider.previewImageUrl != null && mounted) {
      _showPreviewBottomSheet();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(previewProvider.previewStatus)),
      );
    }
  }

  Future<void> _handleDownload(BuildContext bottomSheetContext) async {
    final previewProvider = context.read<PreviewProvider>();
    final downloadProvider = context.read<DownloadProvider>();

    await downloadProvider.downloadFile(
      _urlController.text.trim(),
      previewProvider.mediaType ?? '',
      previewProvider.previewImageUrl ?? '',
    );

    final message = downloadProvider.downloadStatus;

    if (mounted) {
      Navigator.of(bottomSheetContext).pop(); // Close bottom sheet
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );
    }
     _handleReset();
  }

  void _handleReset() {
    _urlController.clear();
    context.read<PreviewProvider>().resetPreview();
    context.read<DownloadProvider>().downloadStatus;
  }

  void _showPreviewBottomSheet() {
    final previewProvider = context.read<PreviewProvider>();
    final downloadProvider = context.read<DownloadProvider>();

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      isScrollControlled: false,
      builder: (bottomSheetContext) {
        return PreviewBottomSheet(
          imageUrl: previewProvider.previewImageUrl ?? '',
          mediaSize: previewProvider.mediaSize ?? 'Unknown Size',
          mediaType: previewProvider.mediaType ?? 'Unknown Type',
          isDownloading: downloadProvider.isDownloading,
          onDownload: () => _handleDownload(bottomSheetContext),
          onReset: _handleReset,
          downloadStatus: downloadProvider.downloadStatus,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final previewProvider = context.watch<PreviewProvider>();
    final isUrlNotEmpty = _urlController.text.trim().isNotEmpty;

    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 30, 16, 16),
        child: Column(
          children: [
            TextField(
              controller: _urlController,
              decoration: InputDecoration(
                labelText: 'Paste Pinterest URL',
                hintText: 'https://www.pinterest.com/pin/...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                prefixIcon: const Icon(Icons.link),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.paste),
                  tooltip: 'Paste from clipboard',
                  onPressed: () async {
                    final clipboardData =
                        await Clipboard.getData('text/plain');
                    if (clipboardData != null && clipboardData.text != null) {
                      _urlController.text = clipboardData.text!;
                    }
                  },
                ),
                filled: true,
                fillColor: Colors.grey[100],
              ),
              keyboardType: TextInputType.url,
              textInputAction: TextInputAction.done,
            ),
            const SizedBox(height: 16),

            if (!previewProvider.isFetchingPreview)
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: isUrlNotEmpty ? _handleFetchPreview : null,
                  icon: const Icon(Icons.remove_red_eye),
                  label: const Text('Preview'),
                ),
              ),

            if (previewProvider.isFetchingPreview)
              const Center(child: CircularProgressIndicator()),

            const SizedBox(height: 30),
            Container(
              height: 100,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(12),
              ),
              alignment: Alignment.center,
              child: const Text(
                'Ad Banner Placeholder',
                style: TextStyle(color: Colors.black54),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
