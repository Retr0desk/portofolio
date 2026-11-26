import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../theme/app_colors.dart';
import '../theme/app_radius.dart';
import '../theme/app_spacing.dart';
import '../theme/app_typography.dart';
import '../widgets/editorial/editorial_button.dart';
import '../widgets/editorial/section_header.dart';
import '../widgets/motion/reveal_on_scroll.dart';

/// Bagian Kontak dengan CTA email utama dan tautan kanal profesional.
class ContactSection extends StatelessWidget {
  final ScrollController scrollController;

  const ContactSection({super.key, required this.scrollController});

  Future<void> _openEmail() async {
    final uri = Uri(
      scheme: 'mailto',
      path: 'w.ajitomo@gmail.com',
      query: 'subject=Portfolio%20Inquiry',
    );
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  Future<void> _launchLink(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(
          index: '05',
          title: 'Kontak',
          scrollController: scrollController,
        ),
        const SizedBox(height: AppSpacing.xl),
        RevealOnScroll(
          scrollController: scrollController,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(AppSpacing.xl),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: AppRadius.card,
              border: Border.all(color: AppColors.borderChampagne),
            ),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final isCompact = constraints.maxWidth < 700;

                final intro = Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ConstrainedBox(
                      constraints: const BoxConstraints(
                        maxWidth: AppSpacing.editorialColumnWidth,
                      ),
                      child: Text(
                        'Terbuka untuk diskusi riset, pengembangan sistem backend, '
                        'atau kolaborasi proyek teknologi.',
                        style: AppTypography.bodyLarge(),
                      ),
                    ),
                    const SizedBox(height: AppSpacing.md),
                    Text(
                      'w.ajitomo@gmail.com',
                      style: AppTypography.metaLabel(color: AppColors.champagne),
                    ),
                  ],
                );

                final actions = Wrap(
                  spacing: AppSpacing.sm,
                  runSpacing: AppSpacing.sm,
                  children: [
                    EditorialButton(
                      label: 'Kirim Email',
                      icon: Icons.mail_outline_rounded,
                      isPrimary: true,
                      onPressed: _openEmail,
                    ),
                    EditorialButton(
                      label: 'GitHub',
                      icon: Icons.code_rounded,
                      onPressed: () =>
                          _launchLink('https://github.com/retr0desk'),
                    ),
                    EditorialButton(
                      label: 'LinkedIn',
                      icon: Icons.north_east_rounded,
                      onPressed: () => _launchLink(
                        'https://www.linkedin.com/in/wahyu-ajitomo-03b368137',
                      ),
                    ),
                    EditorialButton(
                      label: 'Instagram',
                      icon: Icons.north_east_rounded,
                      onPressed: () =>
                          _launchLink('https://instagram.com/_whyuaji'),
                    ),
                  ],
                );

                if (isCompact) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      intro,
                      const SizedBox(height: AppSpacing.xl),
                      actions,
                    ],
                  );
                }

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    intro,
                    const SizedBox(height: AppSpacing.xl),
                    actions,
                  ],
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
