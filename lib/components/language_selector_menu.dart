import 'package:flutter/material.dart';
import 'package:pinterest_downloader/provider/language_provider.dart';
import 'package:provider/provider.dart';

class LanguageSelector extends StatelessWidget {
  const LanguageSelector({super.key});

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);
    final langCode = languageProvider.locale.languageCode;

    final flagMap = {
      'en': '🇺🇸',
      'ur': '🇵🇰',
      'fr': '🇫🇷',
      'hi': '🇮🇳',
      'bn': '🇧🇩',
      'es': '🇪🇸',
      'de': '🇩🇪',
      'tr': '🇹🇷',
      'pt': '🇧🇷',
      'id': '🇮🇩',
    };

    final languageOptions = {
      'en': '🇺🇸 English',
      'ur': '🇵🇰 Urdu',
      'fr': '🇫🇷 French',
      'hi': '🇮🇳 Hindi',
      'bn': '🇧🇩 Bangla',
      'es': '🇪🇸 Spanish',
      'de': '🇩🇪 German',
      'tr': '🇹🇷 Turkish',
      'pt': '🇧🇷 Portuguese (Brazil)',
      'id': '🇮🇩 Indonesian',
    };

    return PopupMenuButton<String>(
      icon: Text(
        flagMap[langCode] ?? '🌐',
        style: const TextStyle(fontSize: 24),
      ),
      onSelected: (String code) {
        languageProvider.setLocale(Locale(code));
      },
      itemBuilder: (BuildContext context) {
        return languageOptions.entries.map((entry) {
          return PopupMenuItem<String>(
            value: entry.key,
            child: Text(entry.value),
          );
        }).toList();
      },
    );
  }
}
