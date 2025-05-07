import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/theme_provider.dart';

class ThemeDrawer extends StatefulWidget {
  const ThemeDrawer({Key? key}) : super(key: key);

  @override
  State<ThemeDrawer> createState() => _ThemeDrawerState();
}

class _ThemeDrawerState extends State<ThemeDrawer> {
  bool _isThemeExpanded = false;

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final currentTheme = themeProvider.currentTheme;

    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: currentTheme.themeData.colorScheme.primary,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.color_lens, size: 48, color: Colors.white),
                const SizedBox(height: 12),
                const Text(
                  'Theme Options',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Current: ${currentTheme.name}',
                  style: const TextStyle(color: Colors.white, fontSize: 14),
                ),
              ],
            ),
          ),

          // Expandable Theme List
          ExpansionTile(
            title: const Text('Select Theme'),
            leading: const Icon(Icons.palette),
            initiallyExpanded: _isThemeExpanded,
            onExpansionChanged:
                (value) => setState(() {
                  _isThemeExpanded = value;
                }),
            children:
                ThemeProvider.availableThemes.map((theme) {
                  final isSelected = theme.name == currentTheme.name;
                  final isDark = theme.themeData.brightness == Brightness.dark;

                  return ListTile(
                    leading: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.amber,
                          width: 2,
                        ),
                      ),
                      child: CircleAvatar(
                        backgroundColor: theme.themeData.primaryColor,
                        child:
                            isSelected
                                ? Icon(
                                  Icons.check,
                                  color: theme.themeData.colorScheme.onPrimary,
                                )
                                : null,
                      ),
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
                        color: themeProvider.themeData.colorScheme.onSurface
                            .withOpacity(0.6),
                      ),
                    ),
                    selected: isSelected,
                    onTap: () {
                      themeProvider.setTheme(theme);
                      Navigator.pop(context);
                    },
                  );
                }).toList(),
          ),

          const Divider(),

          ListTile(
            leading: const Icon(Icons.article),
            title: const Text('Privacy Policy'),
            onTap: () {
              // Navigate to Privacy Policy
            },
          ),
          ListTile(
            leading: const Icon(Icons.info),
            title: const Text('About Us'),
            onTap: () {
              // Navigate to About Us
            },
          ),

          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Select your preferred theme style',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }
}
