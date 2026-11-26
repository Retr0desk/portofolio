import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';
import '../../theme/app_typography.dart';
import '../motion/line_reveal_text.dart';

/// Header bagian editorial dengan nomor indeks, garis champagne, dan judul serif.
class SectionHeader extends StatelessWidget {
  final String index;
  final String title;
  final String? subtitle;
  final ScrollController scrollController;

  const SectionHeader({
    super.key,
    required this.index,
    required this.title,
    required this.scrollController,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    final isCompact = MediaQuery.sizeOf(context).width < 700;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(index, style: AppTypography.editorialIndex()),
            const SizedBox(width: AppSpacing.sm),
            Container(width: 24, height: 1, color: AppColors.champagneMuted),
          ],
        ),
        const SizedBox(height: AppSpacing.md),
        LineRevealText(
          lines: [title],
          style: AppTypography.sectionTitle(isCompact: isCompact),
          scrollController: scrollController,
        ),
        if (subtitle != null) ...[
          const SizedBox(height: AppSpacing.sm),
          ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: AppSpacing.editorialColumnWidth,
            ),
            child: Text(subtitle!, style: AppTypography.bodyMedium()),
          ),
        ],
      ],
    );
  }
}
