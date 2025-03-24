import 'dart:io';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:permission_handler/permission_handler.dart';

class VideoThumbnail extends StatefulWidget {
  final File file;
  const VideoThumbnail({super.key, required this.file});

  @override
  _VideoThumbnailState createState() => _VideoThumbnailState();
}

class _VideoThumbnailState extends State<VideoThumbnail> {
  late VideoPlayerController _controller;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    print("********** Video Thumbnail Init **********");
    requestStoragePermission().then((_) {
      initializeVideo();
    });
  }

  /// Request Storage Permission
  Future<void> requestStoragePermission() async {
    print("Requesting storage permission...");
    var status = await Permission.storage.request();
    if (status.isGranted) {
      print("✅ Storage permission granted.");
    } else {
      print("❌ Storage permission denied.");
    }
  }

  /// Initialize Video Player
  void initializeVideo() {
    print("Video File Path: ${widget.file.path}");

    if (!widget.file.existsSync()) {
      print("❌ ERROR: File does not exist!");
      return;
    }

    try {
      _controller = VideoPlayerController.file(widget.file)
        ..initialize().then((_) {
          setState(() {
            _isInitialized = true;
            _controller.setLooping(true);
            _controller.setVolume(0);
            _controller.play();
          });
          print("✅ Video initialized successfully.");
        }).catchError((error) {
          print("❌ ERROR initializing video: $error");
        });
    } catch (e) {
      print("❌ Exception during initialization: $e");
    }
  }

  @override
  void dispose() {
    print("Disposing video player...");
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      height: 100,
      child: _isInitialized
          ? AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              child: VideoPlayer(_controller),
            )
          : const Center(
              child: Icon(Icons.video_library, size: 50, color: Colors.red),
            ),
    );
  }
}
