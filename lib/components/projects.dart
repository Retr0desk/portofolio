import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'glass.dart';

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Glass(
            padding: const EdgeInsets.all(22),
            blur: 22,
            opacity: 0.12,
            child: const Text(
              'Projects',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
          ),

          const SizedBox(height: 24),

          Wrap(
            spacing: 20,
            runSpacing: 20,
            children: const [
              ProjectCard(
                title: 'AI X-Ray Classifier',
                desc:
                    'Model CNN multiclass dengan Grad-CAM interpretability dan evaluasi lengkap.',
                link: 'http://felyxionspace.github.io/med_intel',
              ),
              ProjectCard(
                title: 'Hybrid Encryption System',
                desc:
                    'AES-256 + IPFS + Smart Contract Ethereum untuk penyimpanan metadata.',
                link: '',
              ),
              // ProjectCard(
              //   title: 'Flutter Mobile App',
              //   desc: 'Aplikasi modern dengan state management dan UI premium.',
              //   link: 'https://github.com/vangelionsfelix8',
              // ),
            ],
          ),
        ],
      ),
    );
  }
}

class ProjectCard extends StatefulWidget {
  final String title;
  final String desc;
  final String link;

  const ProjectCard({
    super.key,
    required this.title,
    required this.desc,
    required this.link,
  });

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> {
  bool hover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => hover = true),
      onExit: (_) => setState(() => hover = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 260),
        transform: Matrix4.identity()..translate(0, hover ? -6 : 0),
        width: 330,
        child: Glass(
          padding: const EdgeInsets.all(22),
          blur: 20,
          opacity: 0.10,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 10),

              Text(widget.desc, style: const TextStyle(color: Colors.white70)),

              const SizedBox(height: 16),

              Row(
                children: [
                  ElevatedButton.icon(
                    onPressed: () async {
                      final uri = Uri.parse(widget.link);
                      if (await canLaunchUrl(uri)) await launchUrl(uri);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white10,
                    ),
                    icon: const Icon(Icons.code, size: 16),
                    label: const Text('Demo'),
                  ),

                  const SizedBox(width: 12),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
