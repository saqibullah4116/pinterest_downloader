import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:permission_handler/permission_handler.dart';
import '../utils/constants.dart';
import '../utils/url_validator.dart';
import '../utils/downloader.dart';
import '../components/media_preview.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
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
    print('Media URL is empty');
    return;
  }

  setState(() {
    _isDownloading = true;
  });

  print('Checking permissions...');

  bool hasPermission = false;

  if (_mediaType.contains('video')) {
    if (await Permission.videos.isGranted) {
      hasPermission = true;
      print('Videos permission already granted');
    } else {
      print('Requesting videos permission...');
      final status = await Permission.videos.request();
      hasPermission = status.isGranted;
      print('Videos permission status: $status');
    }
  } else {
    if (await Permission.photos.isGranted) {
      hasPermission = true;
      print('Photos permission already granted');
    } else {
      print('Requesting photos permission...');
      final status = await Permission.photos.request();
      hasPermission = status.isGranted;
      print('Photos permission status: $status');
    }
  }

  if (!hasPermission) {
    print('Permission denied. Showing toast...');
    Fluttertoast.showToast(msg: 'Gallery permission required to download media');
    setState(() {
      _isDownloading = false;
    });
    return;
  }

  print('Proceeding with download...');

  // Download the media
  final savePath = await Downloader.downloadMedia(_mediaUrl, mediaType: _mediaType);
  if (savePath != null) {
    print('Media downloaded successfully to: $savePath');
    Fluttertoast.showToast(msg: '${_mediaType.contains('video') ? 'Video' : 'Image'} downloaded successfully to Gallery');
  } else {
    print('Failed to download media');
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