import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreviewProvider with ChangeNotifier {
  bool _isFetchingPreview = false;
  String _previewStatus = '';
  String? _previewImageUrl;
  String? _mediaType;
  String? _mediaSize;
  String? _videoDownloadURL;

  bool get isFetchingPreview => _isFetchingPreview;
  String get previewStatus => _previewStatus;
  String? get previewImageUrl => _previewImageUrl;
  String? get mediaType => _mediaType;
  String? get mediaSize => _mediaSize;
  String? get videoDownloadURL => _videoDownloadURL;

  final Dio _dio = Dio();

  Future<void> fetchPreview(String url) async {
    _isFetchingPreview = true;
    _previewStatus = 'Fetching preview...';
    _previewImageUrl = null;
    _mediaType = null;
    _mediaSize = null;
    _videoDownloadURL = null;
    notifyListeners();

    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('auth_token');

      if (token == null) {
        _previewStatus = 'No token found!';
        _isFetchingPreview = false;
        notifyListeners();
        return;
      }

      final formData = FormData.fromMap({'url': url});

      final response = await _dio.post(
        'https://pinterestvideodownloader.pro/api/pin-search',
        data: formData,
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      if (response.statusCode == 200 && response.data['status'] == 200) {
        final data = response.data['data'];
        _mediaType = data['type'];

        _previewImageUrl =
            _mediaType == "video" ? data['thumbnail'] : data['url'];
        if (_mediaType == "video") {
          _videoDownloadURL = data['url'];
        }
        _mediaSize = data['size'];
        _previewStatus = 'Preview fetched successfully!';
      } else {
        _previewStatus = 'Failed to fetch preview.';
      }
    } catch (e) {
      _previewStatus = 'Error: $e';
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
    _mediaSize = null;
    notifyListeners();
  }
}
