import 'dart:io';
import 'package:permission_handler/permission_handler.dart';

Future<bool> requestPermission() async {  // ✅ Made it public (removed `_`)
  if (Platform.isAndroid) {
    final status = await Permission.storage.request();

    if (status.isGranted) {
      return true;
    } else if (status.isDenied) {
      // Ask user to enable permissions manually
      await openAppSettings();
    } else if (status.isPermanentlyDenied) {
      // Show message to user to enable from settings
      print("Permission permanently denied. Please enable it in settings.");
      await openAppSettings();
    }
  } else if (Platform.isIOS) {
    final status = await Permission.photos.request();
    return status.isGranted;
  }
  return false;
}
