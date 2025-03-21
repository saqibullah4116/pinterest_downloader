import 'dart:io';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

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

  /// Fetches downloaded files
  Future<void> _loadFiles() async {
    final galleryDir = Directory('/storage/emulated/0/Pictures');
    if (galleryDir.existsSync()) {
      setState(() {
        files = galleryDir.listSync().whereType<File>().toList();
      });
    }
  }

  /// Deletes a file from the app and gallery
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

  /// Shares a file using `share_plus`
  Future<void> _shareFile(File file) async {
    try {
      if (await file.exists()) {
        await Share.shareXFiles([
          XFile(file.path),
        ], text: "Check out this file!");
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My Files',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body:
          files.isEmpty
              ? const Center(child: Text("No downloaded files found."))
              : ListView.builder(
                itemCount: files.length,
                itemBuilder: (context, index) {
                  final file = File(files[index].path);

                  // Check if file still exists before displaying
                  if (!file.existsSync()) {
                    return const SizedBox(); // Skip this file
                  }

                  String fileSize = "Unknown";
                  try {
                    fileSize =
                        "${(file.lengthSync() / 1024).toStringAsFixed(2)} KB";
                  } catch (e) {
                    fileSize = "Size unavailable";
                  }

                  return ListTile(
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.file(
                        file,
                        width: 50,
                        height: 60,
                        fit: BoxFit.cover,
                        errorBuilder:
                            (context, error, stackTrace) =>
                                const Icon(Icons.image, size: 50),
                      ),
                    ),
                    title: Text(file.uri.pathSegments.last),
                    subtitle: Text(fileSize),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.share),
                          onPressed: () => _shareFile(file),
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.delete_forever,
                            color: Colors.red,
                          ),
                          onPressed: () => _deleteFile(file),
                        ),
                      ],
                    ),
                  );
                },
              ),
    );
  }
}
