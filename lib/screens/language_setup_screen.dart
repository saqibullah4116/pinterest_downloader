import 'package:flutter/material.dart';
import 'package:pinterest_downloader/main.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../provider/language_provider.dart';
import 'home_screen.dart';

class LanguageSetupScreen extends StatelessWidget {
  const LanguageSetupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Trigger dialog after build
    Future.delayed(Duration.zero, () async {
      await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
          title: const Text("Choose Language"),
          content: SizedBox(
            height: MediaQuery.of(context).size.height * 0.6,
            width: double.maxFinite,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _langOption(context, '🇺🇸 English', 'en'),
                  _langOption(context, '🇵🇰 Urdu', 'ur'),
                  _langOption(context, '🇫🇷 French', 'fr'),
                  _langOption(context, '🇮🇳 Hindi', 'hi'),
                  _langOption(context, '🇧🇩 Bangla', 'bn'),
                  _langOption(context, '🇮🇩 Indonesian', 'id'),
                  _langOption(context, '🇧🇷 Portuguese (Brazil)', 'pt'),
                  _langOption(context, '🇹🇷 Turkish', 'tr'),
                  _langOption(context, '🇩🇪 German', 'de'),
                  _langOption(context, '🇪🇸 Spanish', 'es'),
                ],
              ),
            ),
          ),
        ),
      );
    });

    return const Scaffold(body: SizedBox());
  }

  Widget _langOption(BuildContext context, String label, String code) {
    return ListTile(
      title: Text(label),
      onTap: () async {
        final provider = Provider.of<LanguageProvider>(context, listen: false);
        provider.setLocale(Locale(code));

        final prefs = await SharedPreferences.getInstance();
        await prefs.setBool('is_language_set', true);

        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const MyHomePage()),
        );
      },
    );
  }
}
