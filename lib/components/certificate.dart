import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_motion.dart';
import '../theme/app_spacing.dart';
import '../theme/app_typography.dart';
import '../widgets/editorial/section_header.dart';
import '../widgets/motion/reveal_on_scroll.dart';

/// Bagian Sertifikat dan Partisipasi dengan daftar editorial bernomor.
class CertificatesSection extends StatelessWidget {
  final ScrollController scrollController;

  const CertificatesSection({super.key, required this.scrollController});

  static const List<_CertificateEntry> _entries = [
    _CertificateEntry(
      number: '01',
      title: 'BitHealth X Siloam',
      subtitle: 'Peserta — Program kolaborasi BitHealth & Siloam',
    ),
    _CertificateEntry(
      number: '02',
      title: 'DCSE Summer Course 2024',
      subtitle:
          'DCSE Summer Course on AI and Robotics 2024: Smart City Development to Support Sustainable Cities and Communities',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(
          index: '04',
          title: 'Sertifikat & Partisipasi',
          scrollController: scrollController,
        ),
        const SizedBox(height: AppSpacing.xl),
        ...List.generate(_entries.length, (index) {
          return RevealOnScroll(
            scrollController: scrollController,
            delay: AppMotion.staggerStep * index,
            child: _CertificateRow(
              entry: _entries[index],
              showBottomBorder: index < _entries.length - 1,
            ),
          );
        }),
      ],
    );
  }
}

class _CertificateEntry {
  final String number;
  final String title;
  final String subtitle;

  const _CertificateEntry({
    required this.number,
    required this.title,
    required this.subtitle,
  });
}

class _CertificateRow extends StatelessWidget {
  final _CertificateEntry entry;
  final bool showBottomBorder;

  const _CertificateRow({required this.entry, required this.showBottomBorder});

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
          final isCompact = constraints.maxWidth < 640;

          if (isCompact) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(entry.number, style: AppTypography.editorialIndex()),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  entry.title,
                  style: AppTypography.cardTitle(isFeatured: false),
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(entry.subtitle, style: AppTypography.bodyMedium()),
              ],
            );
          }

          return Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              SizedBox(
                width: 64,
                child: Text(entry.number, style: AppTypography.editorialIndex()),
              ),
              Expanded(
                flex: 4,
                child: Text(
                  entry.title,
                  style: AppTypography.cardTitle(isFeatured: false),
                ),
              ),
              const SizedBox(width: AppSpacing.xl),
              Expanded(
                flex: 6,
                child: Text(entry.subtitle, style: AppTypography.bodyMedium()),
              ),
            ],
          );
        },
      ),
    );
  }
}
