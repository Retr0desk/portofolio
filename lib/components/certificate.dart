import 'package:flutter/material.dart';
import 'glass.dart';

class CertificatesSection extends StatelessWidget {
  const CertificatesSection({super.key});

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
              'Certificates',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
          ),

          const SizedBox(height: 24),

          Wrap(
            spacing: 20,
            runSpacing: 20,
            children: const [
              CertificateCard(
                title: 'BitHealth X Siloam',
                desc:
                    'Model CNN multiclass dengan Grad-CAM interpretability dan evaluasi lengkap.',
              ),
              CertificateCard(
                title: 'DCSE Summer Course 2024',
                desc:
                    'DCSE Summer Course on AI and Robotics 2024: Smart City Development to Support Sustainable Cities and Communities.',
              ),
              // ProjectCard(
              //   title: 'Flutter Mobile App',
              //   desc: 'Aplikasi modern dengan state management dan UI premium.',
              // ),
            ],
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// Certificate Card (Hover Effect + Buttons)
// ============================================================================
class CertificateCard extends StatefulWidget {
  final String title;
  final String desc;

  const CertificateCard({super.key, required this.title, required this.desc});

  @override
  State<CertificateCard> createState() => _CertificateCardState();
}

class _CertificateCardState extends State<CertificateCard> {
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
            ],
          ),
        ),
      ),
    );
  }
}
