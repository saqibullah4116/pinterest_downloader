import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pinterest_downloader/l10n/app_localizations.dart';
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
        SnackBar(content: Text(AppLocalizations.of(context).pastePinterestUrl)),
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
      previewProvider.videoDownloadURL ?? '',
    );

    final message = downloadProvider.downloadStatus;

    if (mounted) {
      Navigator.of(bottomSheetContext).pop();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
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

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      isScrollControlled: false,
      builder: (bottomSheetContext) {
        return Consumer<DownloadProvider>(
          builder: (context, downloadProvider, _) {
            print("isDownloading: ${downloadProvider.isDownloading}");
            print("progress: ${downloadProvider.progress}");
            print("downloadStatus: ${downloadProvider.downloadStatus}");

            return PreviewBottomSheet(
              imageUrl: previewProvider.previewImageUrl ?? '',
              mediaSize: previewProvider.mediaSize ?? 'Unknown Size',
              mediaType: previewProvider.mediaType ?? 'Unknown Type',
              isDownloading: downloadProvider.isDownloading,
              onDownload: () => _handleDownload(bottomSheetContext),
              onReset: _handleReset,
              downloadStatus: downloadProvider.downloadStatus,
              progress: downloadProvider.progress,
            );
          },
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
                labelText: AppLocalizations.of(context).pastePinterestUrl,
                hintText: 'https://www.pinterest.com/pin/...',
                labelStyle: TextStyle(color: Theme.of(context).colorScheme.onSurface),
                hintStyle: TextStyle(color: Theme.of(context).hintColor),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.primary.withOpacity(0.5),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.primary,
                    width: 2,
                  ),
                ),
                prefixIcon: Icon(Icons.link, color: Theme.of(context).iconTheme.color),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.paste),
                  tooltip: 'Paste from clipboard',
                  color: Theme.of(context).iconTheme.color,
                  onPressed: () async {
                    final clipboardData = await Clipboard.getData('text/plain');
                    if (clipboardData != null && clipboardData.text != null) {
                      _urlController.text = clipboardData.text!;
                    }
                  },
                ),
                filled: true,
                fillColor: Theme.of(context).colorScheme.surface.withOpacity(0.05),
              ),
              keyboardType: TextInputType.url,
              textInputAction: TextInputAction.done,
              style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
            ),

            const SizedBox(height: 16),

            if (!previewProvider.isFetchingPreview)
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: isUrlNotEmpty ? _handleFetchPreview : null,
                  icon: const Icon(Icons.remove_red_eye),
                  label: Text(AppLocalizations.of(context).preview),
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
              child: Text(
                AppLocalizations.of(context).adPlaceholder,
                style: const TextStyle(color: Colors.black54),
              ),
            ),
            // MyBannerAd(),
          ],
        ),
      ),
    );
  }
}
