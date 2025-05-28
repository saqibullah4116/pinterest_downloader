import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider with ChangeNotifier {
  String? _token;

  String? get token => _token;

  Future<void> fetchToken() async {
    final prefs = await SharedPreferences.getInstance();
    _token = prefs.getString('auth_token');

    // if (_token == null) {
      final response = await http.post(
        Uri.parse('https://pinterestvideodownloader.pro/api/auth/token'),
        headers: {'x-api-key': 'JJHKHKHIUIJKNKNKNKNKNUIU4343453453'},
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        _token = data['token'];
        await prefs.setString('auth_token', _token!);
        notifyListeners();
      } else {
        throw Exception('Failed to fetch token');
      }
    // }
  }

  Future<void> clearToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth_token');
    _token = null;
    notifyListeners();
  }
}
