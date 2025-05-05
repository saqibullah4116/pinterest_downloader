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
  ) async {
    _isDownloading = true;
    _downloadStatus = 'Downloading...';
    notifyListeners();

    try {
      if (mediaType == 'image') {
        await _downloadAndSaveImage(previewUrl);
      } else if (mediaType == 'video') {
        await _requestAndSaveVideo(url);
      } else {
        _downloadStatus = 'Unsupported media type!';
      }
    } catch (e) {
      _downloadStatus = 'Error: $e';
      print("❌ Global exception: $e");
    } finally {
      _isDownloading = false;
      notifyListeners();
    }
  }

  Future<void> _downloadAndSaveImage(String imageUrl) async {
    try {
      print("🔄 Starting download of image from: $imageUrl");

      bool permissionGranted = await _requestPermission();
      print("📛 Permission granted: $permissionGranted");

      if (!permissionGranted) {
        _downloadStatus = 'Permission Denied!';
        print("❌ Permission denied.");
        return;
      }

      final tempDir = await getTemporaryDirectory();
      final timestamp = DateTime.now().millisecondsSinceEpoch;
      final tempPath = '${tempDir.path}/image_$timestamp.jpg';
      print("📁 Temp path: $tempPath");

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
              print(
                "⬇️ Download progress: ${(received / total * 100).toStringAsFixed(0)}%",
              );
            }
          },
        );
      } catch (e) {
        print("❌ Dio download failed: $e");
        _downloadStatus = "Download failed: $e";
        return;
      }

      print("✅ Download completed!");

      final tempFile = File(tempPath);
      if (!tempFile.existsSync()) {
        _downloadStatus = "Downloaded file missing!";
        print("❌ Downloaded temp file missing!");
        return;
      }

      final targetDir = Directory('/storage/emulated/0/Download/MyAppImages');
      if (!targetDir.existsSync()) {
        print("📂 Creating target directory: ${targetDir.path}");
        targetDir.createSync(recursive: true);
      }

      final savedPath = '${targetDir.path}/image_$timestamp.jpg';
      final savedFile = await tempFile.copy(savedPath);
      print("✅ Image copied to: $savedPath");

      await _notifyMediaScanner(savedPath);
      print("📸 Media scanner notified.");

      _downloadStatus =
          savedFile.existsSync() ? 'Image saved!' : 'Failed to save image!';
    } catch (e) {
      _downloadStatus = 'Error saving image: $e';
      print("❌ Exception during image saving: $e");
    }
  }

  Future<void> _requestAndSaveVideo(String url) async {
    try {
      print("🔄 Starting download of video from: $url");

      bool permissionGranted = await _requestPermission();
      print("📛 Permission granted: $permissionGranted");

      if (!permissionGranted) {
        _downloadStatus = 'Permission Denied!';
        print("❌ Permission denied.");
        return;
      }

      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('auth_token');
      if (token == null) {
        _downloadStatus = 'No token found!';
        print("❌ Missing token.");
        return;
      }

      final tempDir = await getTemporaryDirectory();
      final timestamp = DateTime.now().millisecondsSinceEpoch;
      final tempPath = '${tempDir.path}/video_$timestamp.mp4';
      print("📁 Temp path: $tempPath");

      final formData = FormData.fromMap({'url': url});
      late Response<ResponseBody> response;

      try {
        response = await _dio.post<ResponseBody>(
          'https://pin.canvaapk.com/api/pin-download',
          data: formData,
          options: Options(
            headers: {'Authorization': 'Bearer $token'},
            responseType: ResponseType.stream,
          ),
        );
      } catch (e) {
        print("❌ Dio video request failed: $e");
        _downloadStatus = "Download failed: $e";
        return;
      }

      if (response.statusCode == 200) {
        File file = File(tempPath);
        IOSink sink = file.openWrite();
        await response.data!.stream.forEach((chunk) => sink.add(chunk));
        await sink.flush();
        await sink.close();
        print("✅ Video file written.");

        final targetDir = Directory('/storage/emulated/0/Download/MyAppVideos');
        if (!targetDir.existsSync()) {
          targetDir.createSync(recursive: true);
          print("📂 Created target video dir: ${targetDir.path}");
        }

        final savedFile = await file.copy(
          '${targetDir.path}/video_$timestamp.mp4',
        );
        print("✅ Video copied to: ${savedFile.path}");

        await _notifyMediaScanner(savedFile.path);
        print("📸 Media scanner notified for video.");

        _downloadStatus =
            savedFile.existsSync()
                ? 'Video saved to gallery!'
                : 'Failed to save video!';
      } else {
        _downloadStatus = 'Download failed. Status: ${response.statusCode}';
        print("❌ Server returned error: ${response.statusCode}");
      }
    } catch (e) {
      _downloadStatus = 'Error saving video: $e';
      print("❌ Exception during video saving: $e");
    }
  }

  Future<bool> _requestPermission() async {
    if (!Platform.isAndroid) return true;

    final deviceInfo = DeviceInfoPlugin();
    final androidInfo = await deviceInfo.androidInfo;
    final sdkInt = androidInfo.version.sdkInt;

    print("🔧 Android SDK version: $sdkInt");

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
