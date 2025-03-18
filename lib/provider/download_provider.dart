import 'dart:io';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pinterest_downloader/utils/permission_handler.dart';

class DownloadProvider with ChangeNotifier {
  bool _isDownloading = false;
  String _downloadStatus = '';

  bool get isDownloading => _isDownloading;
  String get downloadStatus => _downloadStatus;

  final Dio _dio = Dio();

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
    } finally {
      _isDownloading = false;
      notifyListeners();
    }
  }

  /// Downloads and saves an image
  Future<void> _downloadAndSaveImage(String imageUrl) async {
    try {
      if (await requestPermission()) {
        final tempDir = await getTemporaryDirectory();
        final timestamp = DateTime.now().millisecondsSinceEpoch;
        final filePath = '${tempDir.path}/downloaded_image_$timestamp.jpg';

        await _dio.download(imageUrl, filePath);

        final galleryDir = Directory('/storage/emulated/0/Pictures');
        if (!galleryDir.existsSync()) {
          galleryDir.createSync(recursive: true);
        }

        final savedFile = await File(filePath)
            .copy('${galleryDir.path}/downloaded_image_$timestamp.jpg');

        _downloadStatus = savedFile.existsSync()
            ? 'Image saved to Gallery!'
            : 'Failed to save image!';
      } else {
        _downloadStatus = 'Permission Denied!';
      }
    } catch (e) {
      _downloadStatus = 'Error saving image: $e';
    }
  }

  /// Requests and saves a video
  Future<void> _requestAndSaveVideo(String url) async {
    try {
      if (await requestPermission()) {
        final tempDir = await getTemporaryDirectory();
        final filePath = '${tempDir.path}/downloaded_video.mp4';

        Response<ResponseBody> response = await _dio.post<ResponseBody>(
          'https://pinterest-downloader-backend-1.onrender.com/api/v1/pinterest/download',
          data: {'url': url},
          options: Options(responseType: ResponseType.stream),
        );

        if (response.statusCode == 200) {
          File file = File(filePath);
          IOSink fileSink = file.openWrite();

          await response.data!.stream.forEach((chunk) => fileSink.add(chunk));

          await fileSink.flush();
          await fileSink.close();

          final moviesDir = Directory('/storage/emulated/0/Movies');
          if (!moviesDir.existsSync()) {
            moviesDir.createSync(recursive: true);
          }

          final savedFile = await file.copy(
            '${moviesDir.path}/downloaded_video.mp4',
          );

          _downloadStatus = savedFile.existsSync()
              ? 'Video saved to Gallery!'
              : 'Failed to save video!';
        } else {
          _downloadStatus = 'Failed to download video!';
        }
      } else {
        _downloadStatus = 'Permission Denied!';
      }
    } catch (e) {
      _downloadStatus = 'Error saving video: $e';
    }
  }


}
