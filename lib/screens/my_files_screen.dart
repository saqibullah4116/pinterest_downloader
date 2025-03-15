import 'package:flutter/material.dart';

class MyFilesScreen extends StatelessWidget {
  const MyFilesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My Files',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView(
        children: [
          ListTile(
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(
                8,
              ), 
              child: Image.network(
                'https://i.pinimg.com/736x/f9/d9/2d/f9d92d86b8ece72161dd744d0a21e874.jpg',
                width: 50, // Increased size
                height: 60,
                fit: BoxFit.cover,
              ),
            ),
            title: const Text('pd_20250315142544.jpg'),
            subtitle: const Text('87.40KB'),
            trailing: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(icon: Icon(Icons.share), onPressed: null),
                IconButton(
                  icon: Icon(Icons.delete_forever, color: Colors.red),
                  onPressed: null,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
