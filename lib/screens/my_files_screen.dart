import 'dart:io';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pinterest_downloader/components/VideoThumbnail.dart';
import 'package:share_plus/share_plus.dart';
import 'package:pinterest_downloader/l10n/app_localizations.dart';


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
    final imageDir = Directory('/storage/emulated/0/Download/MyAppImages');
    final videoDir = Directory('/storage/emulated/0/Download/MyAppVideos');

    List<FileSystemEntity> allFiles = [];

    if (imageDir.existsSync()) {
      allFiles.addAll(
        imageDir.listSync().whereType<File>().toList(),
      );
    }

    if (videoDir.existsSync()) {
      allFiles.addAll(
        videoDir.listSync().whereType<File>().toList(),
      );
    }

    allFiles.sort(
      (a, b) => b.statSync().modified.compareTo(a.statSync().modified),
    );

    setState(() {
      files = allFiles;
    });
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
        _showManualDeleteSnackBar();
      }
    } catch (e) {
      _showManualDeleteSnackBar();
    }
  }

  void _showManualDeleteSnackBar() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          "File could not be deleted.\nThis is happening because you have deleted our app.\nPlease manually delete it from:\nDownload/MyAppVideos or MyAppImages",
        ),
        duration: Duration(seconds: 6),
      ),
    );
  }

  Future<void> _shareFile(File file) async {
    try {
      if (await file.exists()) {
        await Share.shareXFiles([XFile(file.path)], text: "Check this out!");
      } else {
        _showManualDeleteSnackBar();
      }
    } catch (e) {
      _showManualDeleteSnackBar();
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
      body: Column(
        children: [
          Expanded(
            child: files.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.folder_open,
                            size: 60, color: Colors.grey[400]),
                        const SizedBox(height: 16),
                        Text(
                          AppLocalizations.of(context).no_files_found,
                          style:
                              TextStyle(fontSize: 18, color: Colors.grey[600]),
                        ),
                      ],
                    ),
                  )
                : GridView.builder(
                    padding: const EdgeInsets.all(12),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
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
                        fileDate = DateFormat('MMM dd • hh:mm a')
                            .format(lastModified);
                      } catch (_) {}

                      return Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        clipBehavior: Clip.antiAlias,
                        child: InkWell(
                          onTap: () {},
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Expanded(
                                child: Stack(
                                  children: [
                                    ClipRRect(
                                      borderRadius: const BorderRadius.vertical(
                                          top: Radius.circular(16)),
                                      child: _isVideoFile(file.path)
                                          ? VideoThumbnail(file: file)
                                          : SizedBox.expand(
                                              child: Image.file(
                                                file,
                                                fit: BoxFit.cover,
                                                alignment: Alignment.center,
                                                errorBuilder:
                                                    (context, error,
                                                            stackTrace) =>
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
                                    Positioned(
                                      top: 8,
                                      right: 8,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .surface
                                              .withOpacity(0.8),
                                          shape: BoxShape.circle,
                                        ),
                                        child: PopupMenuButton<String>(
                                          onSelected: (value) {
                                            if (value == 'delete') {
                                              _deleteFile(file);
                                            } else if (value == 'share') {
                                              _shareFile(file);
                                            }
                                          },
                                          itemBuilder: (context) => const [
                                            PopupMenuItem(
                                              value: 'share',
                                              child: Text('Share'),
                                            ),
                                            PopupMenuItem(
                                              value: 'delete',
                                              child: Text('Delete'),
                                            ),
                                          ],
                                          icon: Icon(
                                            Icons.more_vert,
                                            size: 25,
                                            color: Theme.of(context)
                                                .iconTheme
                                                .color,
                                          ),
                                          elevation: 4,
                                        ),
                                      ),
                                    ),
                                  ],
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
          ),
        ],
      ),
    );
  }
}
