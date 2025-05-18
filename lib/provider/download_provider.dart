import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';
import 'package:device_info_plus/device_info_plus.dart';

class DownloadProvider with ChangeNotifier {
  bool _isDownloading = false;
  String _downloadStatus = '';
  double _progress = 0;

  bool get isDownloading => _isDownloading;
  String get downloadStatus => _downloadStatus;
  double get progress => _progress;

  final Dio _dio = Dio();
  static const platform = MethodChannel('com.yourapp.mediastore');

  Future<void> downloadFile(
    String url,
    String mediaType,
    String previewUrl,
    String videoDownloadURL,
  ) async {
    _isDownloading = true;
    _progress = 0;
    _downloadStatus = 'Downloading...';
    notifyListeners();

    try {
      if (mediaType == 'image') {
        await _downloadAndSaveImage(previewUrl);
      } else if (mediaType == 'video') {
        await _requestAndSaveVideo(videoDownloadURL);
      } else {
        _downloadStatus = 'Unsupported media type!';
      }
    } catch (e) {
      _downloadStatus = 'Error: $e';
    } finally {
      _isDownloading = false;
      _progress = 0;
      notifyListeners();
    }
  }

  Future<void> _downloadAndSaveImage(String imageUrl) async {
    try {
      bool permissionGranted = await _requestPermission();
      if (!permissionGranted) {
        _downloadStatus = 'Permission Denied!';
        return;
      }

      final tempDir = await getTemporaryDirectory();
      final timestamp = DateTime.now().millisecondsSinceEpoch;
      final tempPath = '${tempDir.path}/image_$timestamp.jpg';

      try {
        await _dio.download(
          imageUrl,
          tempPath,
          options: Options(
            headers: {
              'User-Agent': 'Mozilla/5.0 (compatible; PinterestDownloader/1.0)',
            },
          ),
          onReceiveProgress: (received, total) {
            if (total != -1) {
              _progress = received / total;
              notifyListeners();
            }
          },
        );
      } catch (e) {
        print("❌ Dio download failed: $e");
        _downloadStatus = "Download failed: $e";
        return;
      }

      final tempFile = File(tempPath);
      if (!tempFile.existsSync()) {
        _downloadStatus = "Downloaded file missing!";
        return;
      }

      final targetDir = Directory('/storage/emulated/0/Download/MyAppImages');
      if (!targetDir.existsSync()) {
        targetDir.createSync(recursive: true);
      }

      final savedPath = '${targetDir.path}/image_$timestamp.jpg';
      final savedFile = await tempFile.copy(savedPath);
      await _notifyMediaScanner(savedPath);

      _downloadStatus =
          savedFile.existsSync() ? 'Image saved!' : 'Failed to save image!';
    } catch (e) {
      _downloadStatus = 'Error saving image: $e';
    }
  }

  Future<void> _requestAndSaveVideo(String url) async {
    try {
      bool permissionGranted = await _requestPermission();
      if (!permissionGranted) {
        _downloadStatus = 'Permission Denied!';
        notifyListeners();
        return;
      }

      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('auth_token');
      if (token == null) {
        _downloadStatus = 'No token found!';
        notifyListeners();
        return;
      }

      final timestamp = DateTime.now().millisecondsSinceEpoch;
      final targetDir = Directory('/storage/emulated/0/Download/MyAppVideos');
      if (!targetDir.existsSync()) {
        targetDir.createSync(recursive: true);
      }
      final savePath = '${targetDir.path}/video_$timestamp.mp4';

      // Here, we use dio.download with headers and progress callback
      await _dio.download(
        url,
        savePath,
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
          responseType: ResponseType.bytes, // or ResponseType.stream works too
        ),
        onReceiveProgress: (received, total) {
          if (total != -1) {
            _progress = received / total;
            notifyListeners();
          }
        },
      );

      await _notifyMediaScanner(savePath);

      _downloadStatus = 'Video downloaded!';
      notifyListeners();
    } catch (e) {
      _downloadStatus = 'Download failed: $e';
      notifyListeners();
    }
  }

  Future<bool> _requestPermission() async {
    if (!Platform.isAndroid) return true;

    final deviceInfo = DeviceInfoPlugin();
    final androidInfo = await deviceInfo.androidInfo;
    final sdkInt = androidInfo.version.sdkInt;

    if (sdkInt >= 33) {
      final photos = await Permission.photos.request();
      final videos = await Permission.videos.request();
      return photos.isGranted || videos.isGranted;
    } else if (sdkInt >= 30) {
      final status = await Permission.manageExternalStorage.request();
      return status.isGranted;
    } else {
      final status = await Permission.storage.request();
      return status.isGranted;
    }
  }

  Future<void> _notifyMediaScanner(String path) async {
    try {
      await platform.invokeMethod('scanFile', {'path': path});
    } catch (e) {
      print('Media scan failed: $e');
    }
  }
}
