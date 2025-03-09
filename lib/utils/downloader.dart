import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class Downloader {
  static Future<bool> requestPermission() async {
    // Request storage permission
    final status = await Permission.storage.request();
    return status.isGranted;
  }

  static Future<String?> downloadMedia(String url) async {
    try {
      // Check if permission is granted
      if (!await requestPermission()) {
        return null; // Permission denied
      }

      // Get the directory for saving the file
      final dir = await getExternalStorageDirectory();
      if (dir == null) {
        return null; // Unable to access storage
      }

      // Create a file name from the URL
      final fileName = url.split('/').last;
      final savePath = '${dir.path}/$fileName';

      // Download the file using Dio
      final dio = Dio();
      await dio.download(url, savePath);

      return savePath;
    } catch (e) {
      return null;
    }
  }
}