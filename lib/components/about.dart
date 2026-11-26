import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/app_typography.dart';
import '../widgets/editorial/section_header.dart';
import '../widgets/motion/reveal_on_scroll.dart';

/// Bagian Tentang dengan kolom narasi rata kiri dan ringkasan fokus kerja.
class AboutSection extends StatelessWidget {
  final ScrollController scrollController;

  const AboutSection({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isCompact = constraints.maxWidth < 800;

        final narrative = RevealOnScroll(
          scrollController: scrollController,
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: AppSpacing.editorialColumnWidth,
            ),
            child: Text(
              'Halo, saya Aji. Saya berfokus di bidang data science, deep learning, '
              'dan pengembangan backend. Beberapa karya yang saya bangun meliputi model '
              'CNN dengan interpretabilitas Grad-CAM, sistem enkripsi hibrida berbasis '
              'AES-256, IPFS, dan smart contract, serta layanan backend.\n\n'
              'Saya mengutamakan arsitektur yang terstruktur, terukur, dan mudah '
              'dikembangkan lebih lanjut sesuai kebutuhan produk.',
              style: AppTypography.bodyLarge(),
            ),
          ),
        );

        final metaRows = RevealOnScroll(
          scrollController: scrollController,
          delay: const Duration(milliseconds: 100),
            child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _MetaItem(
                label: 'Peran Saat Ini',
                value:
                    'Chief Technology Officer — PT. Andara Rejo Makmur (sejak November)',
              ),
              _MetaItem(
                label: 'Fokus Utama',
                value: 'Deep Learning, Computer Vision, Arsitektur Full-Stack & Sistem Aman',
              ),
              _MetaItem(
                label: 'Lokasi',
                value: 'Yogyakarta, Indonesia',
              ),
              _MetaItem(
                label: 'Kolaborasi',
                value: 'Terbuka untuk riset, proyek, dan pengembangan backend',
                showBottomBorder: false,
              ),
            ],
          ),
        );

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SectionHeader(
              index: '01',
              title: 'Tentang',
              scrollController: scrollController,
            ),
            const SizedBox(height: AppSpacing.xl),
            if (isCompact) ...[
              narrative,
              const SizedBox(height: AppSpacing.xl),
              metaRows,
            ] else
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(flex: 7, child: narrative),
                  const SizedBox(width: AppSpacing.xxxl),
                  Expanded(flex: 5, child: metaRows),
                ],
              ),
          ],
        );
      },
    );
  }
}

class _MetaItem extends StatelessWidget {
  final String label;
  final String value;
  final bool showBottomBorder;

  const _MetaItem({
    required this.label,
    required this.value,
    this.showBottomBorder = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: showBottomBorder
                ? AppColors.borderSubtle
                : Colors.transparent,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: AppTypography.metaLabel(color: AppColors.champagne),
          ),
          const SizedBox(height: AppSpacing.xxs),
          Text(
            value,
            style: AppTypography.bodyMedium().copyWith(
              color: AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}
