import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:permission_handler/permission_handler.dart';
import '../utils/constants.dart';
import '../utils/url_validator.dart';
import '../utils/downloader.dart';
import '../components/media_preview.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _urlController = TextEditingController();
  String _mediaUrl = '';
  String _mediaType = '';
  bool _isDownloading = false;

  void _validateAndPreview() async {
    final url = _urlController.text.trim();
    if (UrlValidator.isPinterestUrl(url)) {
      final mediaUrl = await UrlValidator.getMediaUrl(url);
      if (mediaUrl != null) {
        setState(() {
          _mediaUrl = mediaUrl;
          _mediaType = UrlValidator.getMediaType(mediaUrl);
        });
      } else {
        Fluttertoast.showToast(msg: 'Failed to extract media URL');
      }
    } else {
      Fluttertoast.showToast(msg: AppStrings.invalidUrlError);
    }
  }

 void _downloadMedia() async {
  if (_mediaUrl.isEmpty) {
    print('Media URL is empty'); // Debug log
    return;
  }

  setState(() {
    _isDownloading = true;
  });

  // Debug log: Requesting storage permission
  print('Requesting storage permission...');
  final status = await Permission.storage.request();

  // Debug log: Permission status
  print('Permission status: $status');

  if (!status.isGranted) {
    // Debug log: Permission denied
    print('Permission denied. Redirecting to app settings...');
    Fluttertoast.showToast(msg: 'Storage permission denied. Please enable it in app settings.');
    await openAppSettings(); // Redirect to app settings
    setState(() {
      _isDownloading = false;
    });
    return;
  }

  // Debug log: Permission granted
  print('Permission granted. Downloading media...');

  // Download the media
  final savePath = await Downloader.downloadMedia(_mediaUrl);
  if (savePath != null) {
    print('Media downloaded successfully to: $savePath'); // Debug log
    Fluttertoast.showToast(msg: 'Downloaded successfully to $savePath');
  } else {
    print('Failed to download media'); // Debug log
    Fluttertoast.showToast(msg: 'Failed to download');
  }

  setState(() {
    _isDownloading = false;
  });
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.appName),
        backgroundColor: AppColors.pinterestRed,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _urlController,
              decoration: InputDecoration(
                hintText: AppStrings.enterUrlHint,
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _validateAndPreview,
              child: Text('Preview Media'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.pinterestRed,
              ),
            ),
            SizedBox(height: 20),
            if (_mediaUrl.isNotEmpty)
              MediaPreview(mediaUrl: _mediaUrl, mediaType: _mediaType),
            SizedBox(height: 20),
            if (_mediaUrl.isNotEmpty)
              ElevatedButton(
                onPressed: _isDownloading ? null : _downloadMedia,
                child: _isDownloading
                    ? CircularProgressIndicator(color: AppColors.pinterestWhite)
                    : Text(AppStrings.downloadButton),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.pinterestRed,
                ),
              ),
          ],
        ),
      ),
    );
  }
}