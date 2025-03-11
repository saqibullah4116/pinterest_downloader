import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart' as path;

class Downloader {
  static Future<String?> downloadMedia(
    String url, {
    String mediaType = '',
  }) async {
    try {
      print('Downloading from URL: $url');

      // Download file
      final response = await http.get(Uri.parse(url));
      if (response.statusCode != 200) {
        print('Failed to download: HTTP ${response.statusCode}');
        return null;
      }

      print('Downloaded ${response.bodyBytes.length} bytes');

      // Create a temporary file first
      final tempDir = await getTemporaryDirectory();
      final fileExtension = mediaType.contains('video') ? '.mp4' : '.jpg';
      final fileName =
          'pinterest_${DateTime.now().millisecondsSinceEpoch}$fileExtension';
      final file = File('${tempDir.path}/$fileName');
      await file.writeAsBytes(response.bodyBytes);

      print('Temporary file saved to: ${file.path}');

      try {
        return 'Gallery';
      } catch (e) {
        print('Error with GallerySaver: $e');
      }

      return file.path;
    } catch (e) {
      print('Error in downloadMedia: $e');
      return null;
    }
  }
}
