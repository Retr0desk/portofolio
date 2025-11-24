import 'package:flutter/material.dart';
import 'glass.dart';

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Glass(
        padding: const EdgeInsets.all(26),
        blur: 22,
        opacity: 0.10,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Skills',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 20),

            Wrap(
              spacing: 14,
              runSpacing: 14,
              children: const [
                SkillChip('Flutter'),
                SkillChip('Dart'),
                SkillChip('Python'),
                SkillChip('TensorFlow'),
                SkillChip('Computer Vision'),
                SkillChip('Docker'),
                SkillChip('REST API'),
                SkillChip('Laravel'),
                SkillChip('MLOps'),
                SkillChip('PostgreSQL'),
                SkillChip('UI/UX Design'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================================
// Skill Chip
// ============================================================================
class SkillChip extends StatelessWidget {
  final String label;
  const SkillChip(this.label, {super.key});

  @override
  Widget build(BuildContext context) {
    return Glass(
      blur: 12,
      opacity: 0.06,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Text(
        label,
        style: const TextStyle(fontSize: 14, color: Colors.white70),
      ),
    );
  }
}
