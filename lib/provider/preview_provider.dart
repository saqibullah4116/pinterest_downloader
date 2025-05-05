import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreviewProvider with ChangeNotifier {
  bool _isFetchingPreview = false;
  String _previewStatus = '';
  String? _previewImageUrl;
  String? _mediaType;
  String? _mediaSize;

  bool get isFetchingPreview => _isFetchingPreview;
  String get previewStatus => _previewStatus;
  String? get previewImageUrl => _previewImageUrl;
  String? get mediaType => _mediaType;
  String? get mediaSize => _mediaSize;

  final Dio _dio = Dio();

  Future<void> fetchPreview(String url) async {
    _isFetchingPreview = true;
    _previewStatus = 'Fetching preview...';
    _previewImageUrl = null;
    _mediaType = null;
    _mediaSize = null;
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
        'https://pin.canvaapk.com/api/pin-search',
        data: formData,
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      if (response.statusCode == 200 && response.data['status'] == 200) {
        
        final data = response.data['data'];
        _previewImageUrl = data['url'];
        _mediaType = data['type'];
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
