import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key});

  // Function to launch URL externally
  void _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Privacy Policy')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '1. Information We Collect',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'We do not collect any personally identifiable information (PII) such as your name, email address, or account credentials when you use our tool. Our site is designed to function without requiring user registration or personal input.\n\n'
              'We may collect limited non-personal data automatically, such as:\n\n'
              '- IP address (anonymized for analytics)\n'
              '- Browser type and version\n'
              '- Operating system\n'
              '- Referring URLs\n'
              '- Time and date of access\n\n'
              'This information is used solely for statistical analysis, site performance improvements, and troubleshooting.',
            ),
            const SizedBox(height: 16),

            const Text(
              '2. Cookies',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'PinterestVideoDownloader.pro uses cookies and similar technologies to enhance user experience and analyze site traffic. You can choose to disable cookies through your browser settings, but this may affect certain functionalities of the website.',
            ),
            const SizedBox(height: 16),

            const Text(
              '3. Third-Party Services',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'We may use trusted third-party analytics tools (e.g., Google Analytics) to gather anonymous usage data. These services may use cookies or similar tracking technologies, but we do not share any personally identifiable information with them.\n\n'
              'We are not responsible for the privacy practices of Pinterest or any other third-party websites linked or mentioned on our site.',
            ),
            const SizedBox(height: 16),

            const Text(
              '4. Use of Download Tool',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'All downloads initiated through PinterestVideoDownloader.pro are processed in real-time and not stored on our servers. The responsibility for any content downloaded lies solely with the user. Ensure that your use complies with Pinterest’s Terms of Service and copyright laws.',
            ),
            const SizedBox(height: 16),

            const Text(
              '5. Children’s Privacy',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'This site is not intended for use by individuals under the age of 13. We do not knowingly collect data from children.',
            ),
            const SizedBox(height: 16),

            const Text(
              '6. Data Security',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'While no website is 100% secure, we implement reasonable technical and organizational safeguards to protect the data we collect from misuse, unauthorized access, or disclosure.',
            ),
            const SizedBox(height: 16),

            const Text(
              '7. Changes to This Policy',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'We reserve the right to modify this Privacy Policy at any time. Updates will be posted on this page with a revised effective date.',
            ),
            const SizedBox(height: 16),

            const Text(
              '8. Contact Us',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'If you have any questions or concerns about this Privacy Policy, please contact us at:\n\n📧 juliepowellofficial@gmail.com',
            ),

            const SizedBox(height: 32),
            const Divider(thickness: 1),
            const SizedBox(height: 16),

            // Link to Privacy Policy
            ListTile(
              leading: const Icon(Icons.privacy_tip),
              title: const Text(
                'Read Full Privacy Policy',
                style: TextStyle(
                  decoration: TextDecoration.underline,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onTap:
                  () => _launchUrl(
                    'https://pinterestvideodownloader.pro/privacy-policy',
                  ),
            ),

            // Link to main tool
            ListTile(
              leading: const Icon(Icons.download_for_offline),
              title: const Text(
                'Go to Our Website',
                style: TextStyle(
                  decoration: TextDecoration.underline,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onTap: () => _launchUrl('https://pinterestvideodownloader.pro/'),
            ),
          ],
        ),
      ),
    );
  }
}
