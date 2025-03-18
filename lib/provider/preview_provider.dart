import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class PreviewProvider with ChangeNotifier {
  bool _isFetchingPreview = false; 
  String _previewStatus = '';
  String? _previewImageUrl;
  String? _mediaType;

  bool get isFetchingPreview => _isFetchingPreview;
  String get previewStatus => _previewStatus;
  String? get previewImageUrl => _previewImageUrl;
  String? get mediaType => _mediaType;

  final Dio _dio = Dio();

  Future<void> fetchPreview(String url) async {
    _isFetchingPreview = true;
    _previewStatus = 'Fetching preview...';
    _previewImageUrl = null;
    _mediaType = null;
    notifyListeners();

    try {
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
          _previewStatus = 'Preview fetched successfully!';
        } else {
          _previewStatus = 'Failed to fetch preview: ${data['message']}';
        }
      } else {
        _previewStatus = 'Failed to fetch preview: ${response.statusMessage}';
      }
    } on DioException catch (e) {
      _previewStatus = 'Error: ${e.message}';
    } catch (e) {
      _previewStatus = 'Unexpected error: $e';
    } finally {
      _isFetchingPreview = false;
      notifyListeners();
    }
  }

  void resetPreview() {
    _isFetchingPreview = false;
    _previewStatus = '';
    _previewImageUrl = null;
    _mediaType = null;
    notifyListeners();
  }
}