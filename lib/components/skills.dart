import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_motion.dart';
import '../theme/app_radius.dart';
import '../theme/app_spacing.dart';
import '../theme/app_typography.dart';
import '../widgets/editorial/section_header.dart';
import '../widgets/motion/reveal_on_scroll.dart';

/// Bagian Keahlian yang dikelompokkan dalam tiga disiplin utama.
class SkillsSection extends StatelessWidget {
  final ScrollController scrollController;

  const SkillsSection({super.key, required this.scrollController});

  static const List<_SkillGroup> _groups = [
    _SkillGroup(
      category: 'Kecerdasan Buatan & Data',
      items: ['Python', 'TensorFlow', 'Computer Vision', 'MLOps'],
    ),
    _SkillGroup(
      category: 'Backend & Infrastruktur',
      items: [
        'Node.js',
        'Supabase',
        'Docker',
        'REST API',
        'Laravel',
        'PostgreSQL',
      ],
    ),
    _SkillGroup(
      category: 'Aplikasi & Antarmuka',
      items: [
        'JavaScript',
        'React',
        'Next.js',
        'Flutter',
        'Dart',
        'UI/UX Design',
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(
          index: '02',
          title: 'Keahlian',
          scrollController: scrollController,
        ),
        const SizedBox(height: AppSpacing.xl),
        ...List.generate(_groups.length, (index) {
          final group = _groups[index];
          return RevealOnScroll(
            scrollController: scrollController,
            delay: AppMotion.staggerStep * index,
            child: _SkillRow(
              group: group,
              showBottomBorder: index < _groups.length - 1,
            ),
          );
        }),
      ],
    );
  }
}

class _SkillGroup {
  final String category;
  final List<String> items;
  const _SkillGroup({required this.category, required this.items});
}

class _SkillRow extends StatelessWidget {
  final _SkillGroup group;
  final bool showBottomBorder;

  const _SkillRow({required this.group, required this.showBottomBorder});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.lg),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: showBottomBorder
                ? AppColors.borderSubtle
                : Colors.transparent,
          ),
        ),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isCompact = constraints.maxWidth < 700;
          final chips = Wrap(
            spacing: AppSpacing.sm,
            runSpacing: AppSpacing.sm,
            children: group.items.map((item) => _SkillTag(label: item)).toList(),
          );

          if (isCompact) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  group.category,
                  style: AppTypography.metaLabel(color: AppColors.champagne),
                ),
                const SizedBox(height: AppSpacing.md),
                chips,
              ],
            );
          }

          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 240,
                child: Padding(
                  padding: const EdgeInsets.only(top: AppSpacing.xs),
                  child: Text(
                    group.category,
                    style: AppTypography.metaLabel(color: AppColors.champagne),
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.xl),
              Expanded(child: chips),
            ],
          );
        },
      ),
    );
  }
}

class _SkillTag extends StatelessWidget {
  final String label;

  const _SkillTag({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: AppRadius.control,
        border: Border.all(color: AppColors.borderSubtle),
      ),
      child: Text(
        label,
        style: AppTypography.bodyMedium().copyWith(
          color: AppColors.textPrimary,
        ),
      ),
    );
  }
}
