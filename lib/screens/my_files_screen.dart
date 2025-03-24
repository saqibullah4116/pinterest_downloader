import 'dart:io';
import 'package:flutter/material.dart';
import 'package:pinterest_downloader/components/VideoThumbnail.dart';
import 'package:share_plus/share_plus.dart';
import 'package:intl/intl.dart';

class MyFilesScreen extends StatefulWidget {
  const MyFilesScreen({super.key});

  @override
  _MyFilesScreenState createState() => _MyFilesScreenState();
}

class _MyFilesScreenState extends State<MyFilesScreen> {
  List<FileSystemEntity> files = [];

  @override
  void initState() {
    super.initState();
    _loadFiles();
  }

  Future<void> _loadFiles() async {
    final galleryDir = Directory('/storage/emulated/0/Pictures');
    if (galleryDir.existsSync()) {
      setState(() {
        files =
            galleryDir
                .listSync()
                .whereType<File>()
                .where((file) => file.existsSync())
                .toList();
      });
    }
  }

  Future<void> _deleteFile(File file) async {
    try {
      if (await file.exists()) {
        await file.delete();
        setState(() {
          files.removeWhere((element) => element.path == file.path);
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("File deleted successfully!")),
        );
      } else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text("File not found!")));
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Failed to delete file: $e")));
    }
  }

  Future<void> _shareFile(File file) async {
    try {
      if (await file.exists()) {
        await Share.shareXFiles([XFile(file.path)], text: "Check this out!");
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("File not found! Cannot share.")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Failed to share file: $e")));
    }
  }

  bool _isVideoFile(String path) {
    final ext = path.toLowerCase().split('.').last;
    return ['mp4', 'mov', 'avi', 'mkv'].contains(ext);
  }

  String _formatFileSize(int bytes) {
    if (bytes <= 0) return "0 KB";
    if (bytes < 1024) return "$bytes B";
    if (bytes < 1048576) return "${(bytes / 1024).toStringAsFixed(1)} KB";
    return "${(bytes / 1048576).toStringAsFixed(1)} MB";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My Files',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        elevation: 0,
      ),
      body:
          files.isEmpty
              ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.folder_open, size: 60, color: Colors.grey[400]),
                    const SizedBox(height: 16),
                    Text(
                      "No files found",
                      style: TextStyle(fontSize: 18, color: Colors.grey[600]),
                    ),
                  ],
                ),
              )
              : GridView.builder(
                padding: const EdgeInsets.all(12),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 0.8,
                ),
                itemCount: files.length,
                itemBuilder: (context, index) {
                  final file = File(files[index].path);
                  final fileName = file.uri.pathSegments.last;
                  final fileExt = fileName.split('.').last.toLowerCase();


                  String fileDate = "Unknown date";
                  try {
                    final lastModified = file.lastModifiedSync();
                    fileDate = DateFormat(
                      'MMM dd • hh:mm a',
                    ).format(lastModified);
                  } catch (e) {
                    debugPrint("Error getting file date: $e");
                  }

                  return Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(12),
                      onTap: () {}, // Add file preview here
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Expanded(
                            child: ClipRRect(
                              borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(12),
                              ),
                              child:
                                  _isVideoFile(file.path)
                                      ? VideoThumbnail(file: file)
                                      : Image.file(
                                        file,
                                        fit: BoxFit.cover,
                                        errorBuilder:
                                            (context, error, stackTrace) =>
                                                Container(
                                                  color: Colors.grey[200],
                                                  child: const Center(
                                                    child: Icon(
                                                      Icons.image,
                                                      size: 40,
                                                      color: Colors.grey,
                                                    ),
                                                  ),
                                                ),
                                      ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  fileName.length > 20
                                      ? '${fileName.substring(0, 15)}...$fileExt'
                                      : fileName,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  maxLines: 1,
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      _formatFileSize(file.lengthSync()),
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                    Text(
                                      fileDate,
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
    );
  }
}
