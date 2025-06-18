import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key});

  void _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch \$url';
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
          children: const [
            Text(
              'Privacy Policy for Pinterest Video Downloader App',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text('Effective Date: June 18, 2025'),
            SizedBox(height: 8),
            Text(
              'Thank you for using the Pinterest Video Downloader App. This Privacy Policy explains how we handle your information when you use our App. We are committed to protecting your privacy and ensuring transparency about our practices.',
            ),
            SizedBox(height: 16),
            Text(
              '1. No Collection of Personal Data',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'We do not collect, store, or process any personal data from users of the App. This includes, but is not limited to, your name, email address, phone number, location, or any other personally identifiable information. The App operates without requiring user accounts, logins, or any form of personal data submission.',
            ),
            SizedBox(height: 16),
            Text(
              '2. User-Provided URLs',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'The App allows you to download videos, images, or GIFs from Pinterest by manually entering a URL (web address) of the content you wish to download. These URLs are processed solely within the App to facilitate the download and are not stored, shared, or transmitted to any servers or third parties. We do not track or retain any information related to the URLs you provide.',
            ),
            SizedBox(height: 16),
            Text(
              '3. User Responsibility',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              "You are solely responsible for the URLs you input into the App and for ensuring that your use of the App complies with Pinterest's Terms of Service and applicable laws. We do not have any affiliation with Pinterest, nor do we monitor, control, or assume responsibility for the content you choose to download. The App acts as a tool to assist you in downloading publicly available content, and you are responsible for obtaining any necessary permissions or rights to download and use such content.",
            ),
            SizedBox(height: 16),
            Text(
              '4. No Third-Party Data Sharing',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Since we do not collect any data from you, there is no data to share with third parties. The App does not integrate with third-party services for analytics, advertising, or any other purpose that would involve data sharing.',
            ),
            SizedBox(height: 16),
            Text(
              '5. No Tracking or Analytics',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'The App does not use cookies, trackers, or analytics tools to monitor your activity. Your interactions with the App remain private.',
            ),
            SizedBox(height: 16),
            Text(
              '6. Security',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'We take reasonable measures to ensure the App is secure and free from vulnerabilities. However, as no system is entirely immune to risks, you use the App at your own discretion. Since no personal data is collected, there is no risk of personal data exposure.',
            ),
            SizedBox(height: 16),
            Text(
              '7. Children\'s Privacy',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'The App is not intended for use by children under the age of 13. We do not knowingly collect any information from children. If you are a parent or guardian and believe a child under 13 has used the App, please contact us, and we will ensure no data is retained (though, as stated, no data is collected).',
            ),
            SizedBox(height: 16),
            Text(
              '8. Changes to This Privacy Policy',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'We may update this Privacy Policy from time to time to reflect changes in our practices or legal requirements. Any updates will be posted within the App, and the effective date will be revised accordingly. We encourage you to review this policy periodically.',
            ),
            SizedBox(height: 16),
            Text(
              '9. Contact Us',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'If you have questions, email us at: juliepowellofficial@gmail.com\nAddress: Pakistan, Islamabad',
            ),
            SizedBox(height: 16),
            Text(
              '10. Compliance with Google Play Store Policies',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'This policy complies with Google Play Store requirements. Using the App means you agree to this policy.',
            ),
            SizedBox(height: 32),
            Divider(thickness: 1),
            SizedBox(height: 16),
          ],
        ),
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
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
    );
  }
}
