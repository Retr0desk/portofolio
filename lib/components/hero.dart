import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'glass.dart';

class FancyHero extends StatelessWidget {
  final VoidCallback? onDownloadCV;
  final VoidCallback? onViewProjects;
  final VoidCallback? onContact;

  const FancyHero({
    super.key,
    this.onDownloadCV,
    this.onViewProjects,
    this.onContact,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < 700;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 900),
          child: Glass(
            blur: 30,
            opacity: 0.14,
            padding: EdgeInsets.symmetric(
              vertical: isMobile ? 36 : 64,
              horizontal: isMobile ? 16 : 48,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const CircleAvatar(
                  radius: 72,
                  backgroundImage: AssetImage('assets/profile.jpg'),
                ),
                const SizedBox(height: 22),
                const Text(
                  'Wahyu Ajitomo',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                const Text(
                  'AI Engineer • Secure Systems Developer • Flutter App Integrator',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white70, fontSize: 16),
                ),
                const SizedBox(height: 20),
                HeroAction(
                  label: 'Download C',
                  icon: Icons.download,
                  onTap: () => launchUrl(
                    Uri.parse(
                      'https://drive.google.com/file/d/1n0dIlJByrA07euQcZapXT6Z-3gzGIyDB/view?usp=sharing',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class HeroAction extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback? onTap;

  const HeroAction({
    super.key,
    required this.label,
    required this.icon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: Glass(
          blur: 12,
          opacity: 0.06,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 16, color: Colors.white70),
              const SizedBox(width: 8),
              Text(label, style: const TextStyle(color: Colors.white70)),
            ],
          ),
        ),
      ),
    );
  }
}
