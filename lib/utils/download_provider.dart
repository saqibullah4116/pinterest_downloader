import 'package:flutter/material.dart';
import 'package:dio/dio.dart'; 

class DownloadProvider with ChangeNotifier {
  bool _isDownloading = false;
  String _downloadStatus = '';

  bool get isDownloading => _isDownloading;
  String get downloadStatus => _downloadStatus;

  final Dio _dio = Dio();

  Future<void> downloadFile(String url) async {
    _isDownloading = true;
    _downloadStatus = 'Downloading...';
    notifyListeners();

    try {
      print("*****************************");
      print("*****************************");
      print("*****************************");
      print("i am in provider");
      print(url);
      final response = await _dio.post(
        'http://localhost:5000/api/download',
        data: {'url': url},
        options: Options(headers: {'Content-Type': 'application/json'}),
      );

      if (response.statusCode == 200) {
        _downloadStatus = 'Download complete!';
      } else {
        _downloadStatus = 'Failed to download: ${response.statusMessage}';
      }
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
    notifyListeners();
  }
}
