import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'glass.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  Future<void> _openEmail() async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: 'w.ajitomo@gmail.com',
      query: 'subject=Portfolio%20Inquiry',
    );
    if (await canLaunchUrl(emailLaunchUri)) {
      await launchUrl(emailLaunchUri);
    }
  }

  Future<void> _launchLink(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) await launchUrl(uri);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Glass(
        padding: const EdgeInsets.all(26),
        blur: 22,
        opacity: 0.12,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Kontak',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 16),

            const Text(
              'Silakan hubungi saya melalui email atau media sosial di bawah.',
              style: TextStyle(color: Colors.white70),
            ),

            const SizedBox(height: 18),

            Wrap(
              spacing: 14,
              runSpacing: 14,
              children: [
                ElevatedButton.icon(
                  onPressed: _openEmail,
                  icon: const Icon(Icons.mail),
                  label: const Text('Email'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white10,
                  ),
                ),

                OutlinedButton.icon(
                  onPressed: () => _launchLink('https://github.com/retr0desk'),
                  icon: const Icon(Icons.code),
                  label: const Text('GitHub'),
                ),

                OutlinedButton.icon(
                  onPressed: () => _launchLink(
                    'https://www.linkedin.com/in/wahyu-ajitomo-03b368137',
                  ),
                  icon: const Icon(Icons.person),
                  label: const Text('LinkedIn'),
                ),

                OutlinedButton.icon(
                  onPressed: () =>
                      _launchLink('https://instagram.com/_whyuaji'),
                  icon: const Icon(Icons.camera_alt),
                  label: const Text('Instagram'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
