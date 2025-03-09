import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/services.dart'; // For MethodChannel
import 'dart:io'; // For Directory

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
        print('Permission denied'); // Debug log
        return null; // Permission denied
      }

      // Get the external storage directory
      final directory = await getExternalStorageDirectory();
      if (directory == null) {
        print('Unable to access storage directory'); // Debug log
        return null; // Unable to access storage
      }

      // Create a subdirectory named "Pinterest Downloads"
      final saveDir = '${directory.path}/Pinterest Downloads';
      final dir = Directory(saveDir);
      if (!await dir.exists()) {
        await dir.create(recursive: true); // Create the directory if it doesn't exist
      }

      // Create a file name from the URL
      final fileName = url.split('/').last;
      final savePath = '$saveDir/$fileName';

      print('Downloading media from URL: $url'); // Debug log
      print('Saving media to: $savePath'); // Debug log

      // Download the file using Dio
      final dio = Dio();
      await dio.download(url, savePath);

      // Notify the Media Scanner about the new file
      await _notifyMediaScanner(savePath);

      print('Media downloaded successfully'); // Debug log
      return savePath;
    } catch (e) {
      print('Error downloading media: $e'); // Debug log
      return null;
    }
  }

  static Future<void> _notifyMediaScanner(String filePath) async {
    try {
      // Notify the Media Scanner about the new file
      const channel = MethodChannel('flutter.io/mediaScanner');
      await channel.invokeMethod('scanFile', {'path': filePath});
      print('Media Scanner notified about the new file'); // Debug log
    } catch (e) {
      print('Error notifying Media Scanner: $e'); // Debug log
    }
  }
}