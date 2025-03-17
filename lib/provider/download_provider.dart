import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class DownloadProvider with ChangeNotifier {
  bool _isDownloading = false;
  String _downloadStatus = '';
  String? _previewImageUrl;
  String? _mediaType;

  bool get isDownloading => _isDownloading;
  String get downloadStatus => _downloadStatus;
  String? get previewImageUrl => _previewImageUrl;
  String? get mediaType => _mediaType;

  final Dio _dio = Dio();

  Future<void> fetchPreview(String url) async {
    _isDownloading = true;
    _downloadStatus = 'Fetching preview...';
    _previewImageUrl = null;
    _mediaType = null;
    notifyListeners();

    try {
      print("*************************************");
      print("*************************************");
      print("*************************************");
      print("i am fetching the preview");
      final response = await _dio.get(
        'https://pinterest-downloader-backend-1.onrender.com/api/v1/pinterest/preview',
        queryParameters: {'url': url},
        options: Options(headers: {'Content-Type': 'application/json'}),
      );

      if (response.statusCode == 200) {
        final data = response.data;
        if (data['success'] == true) {
          _previewImageUrl = data['data']['previewImageUrl'];
          _mediaType = data['data']['mediaType'];
          _downloadStatus = 'Preview fetched successfully!';
        } else {
          _downloadStatus = 'Failed to fetch preview: ${data['message']}';
        }
      } else {
        _downloadStatus = 'Failed to fetch preview: ${response.statusMessage}';
      }
      print("*************************************");
      print("*************************************");
      print("*************************************");
      print("i have fetched the preview url");
      print("media type: $_mediaType, preview url: $_previewImageUrl");
    } on DioException catch (e) {
      _downloadStatus = 'Error: ${e.message}';
    } catch (e) {
      _downloadStatus = 'Unexpected error: $e';
    } finally {
      _isDownloading = false;
      notifyListeners();
    }
  }

  void resetDownload() {
    _isDownloading = false;
    _downloadStatus = '';
    _previewImageUrl = null;
    _mediaType = null;
    notifyListeners();
  }
}
