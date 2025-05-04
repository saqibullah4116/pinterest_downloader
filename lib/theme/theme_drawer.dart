// lib/widgets/theme_drawer.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/theme_provider.dart';
import '../utils/constants.dart';

class ThemeDrawer extends StatelessWidget {
  const ThemeDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final currentTheme = themeProvider.currentTheme;
    
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: themeProvider.themeData.primaryColor,
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.color_lens,
                    size: 48,
                    color: Colors.white,
                  ),
                  SizedBox(height: 12),
                  Text(
                    'Theme Options',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Current: ${currentTheme.name}',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(vertical: 8),
              itemCount: ThemeProvider.availableThemes.length,
              itemBuilder: (context, index) {
                final theme = ThemeProvider.availableThemes[index];
                final isSelected = theme.name == currentTheme.name;
                final isDark = theme.themeData.brightness == Brightness.dark;
                
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: theme.themeData.primaryColor,
                    child: isSelected 
                      ? Icon(Icons.check, color: Colors.white)
                      : null,
                  ),
                  title: Text(
                    theme.name,
                    style: TextStyle(
                      color: themeProvider.themeData.colorScheme.onSurface,
                    ),
                  ),
                  subtitle: Text(
                    isDark ? 'Dark theme' : 'Light theme',
                    style: TextStyle(
                      color: themeProvider.themeData.colorScheme.onSurface.withOpacity(0.7),
                    ),
                  ),
                  selected: isSelected,
                  onTap: () {
                    themeProvider.setTheme(theme);
                    Navigator.pop(context); // Close drawer
                  },
                );
              },
            ),
          ),
          Divider(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Select your preferred theme style',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: themeProvider.themeData.colorScheme.onSurface.withOpacity(0.7),
              ),
            ),
          ),
        ],
      ),
    );
  }
}