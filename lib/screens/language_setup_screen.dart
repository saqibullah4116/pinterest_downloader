import 'package:flutter/material.dart';
import 'package:pinterest_downloader/main.dart' show MyHomePage;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../provider/language_provider.dart';

class LanguageSetupScreen extends StatefulWidget {
  const LanguageSetupScreen({super.key});

  @override
  State<LanguageSetupScreen> createState() => _LanguageSetupScreenState();
}

class _LanguageSetupScreenState extends State<LanguageSetupScreen> {
  String? selectedLangCode;

  final Map<String, String> languageOptions = {
    'en': '🇺🇸 English',
    'ur': '🇵🇰 Urdu',
    'fr': '🇫🇷 French',
    'hi': '🇮🇳 Hindi',
    'bn': '🇧🇩 Bangla',
    'es': '🇪🇸 Spanish',
    'de': '🇩🇪 German',
    'tr': '🇹🇷 Turkish',
    'pt': '🇧🇷 Portuguese',
    'id': '🇮🇩 Indonesian',
  };

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? Colors.black : Colors.white,
      appBar: AppBar(title: const Text("Select Language"), centerTitle: true),
      body: Column(
        children: [
          const SizedBox(height: 20),
          const Text(
            "Choose your preferred language",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: ListView(
              children:
                  languageOptions.entries.map((entry) {
                    final code = entry.key;
                    final label = entry.value;

                    return RadioListTile<String>(
                      value: code,
                      groupValue: selectedLangCode,
                      title: Text(label, style: const TextStyle(fontSize: 16)),
                      onChanged: (value) {
                        setState(() {
                          selectedLangCode = value;
                        });
                      },
                    );
                  }).toList(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
            child: SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed:
                    selectedLangCode == null
                        ? null
                        : () async {
                          final provider = Provider.of<LanguageProvider>(
                            context,
                            listen: false,
                          );
                          await provider.setLocale(Locale(selectedLangCode!));

                          // ✅ Save onboarding as completed
                          final prefs = await SharedPreferences.getInstance();
                          await prefs.setBool('onboarding_complete', true);

                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const MyHomePage(),
                            ),
                          );
                        },
                child: const Text("Continue", style: TextStyle(fontSize: 16)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
