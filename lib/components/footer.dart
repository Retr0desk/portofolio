import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/app_typography.dart';

/// Footer editorial ringkas dengan garis pemisah tipis.
class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.xl),
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: AppColors.borderSubtle)),
      ),
      child: Wrap(
        alignment: WrapAlignment.spaceBetween,
        runSpacing: AppSpacing.xs,
        children: [
          Text(
            '© 2026 Wahyu Ajitomo',
            style: AppTypography.metaLabel(color: AppColors.textMuted),
          ),
          Text(
            'Dibangun dengan Flutter',
            style: AppTypography.metaLabel(color: AppColors.textMuted),
          ),
        ],
      ),
    );
  }
}
