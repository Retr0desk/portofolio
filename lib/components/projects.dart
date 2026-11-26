import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../theme/app_colors.dart';
import '../theme/app_motion.dart';
import '../theme/app_radius.dart';
import '../theme/app_spacing.dart';
import '../theme/app_typography.dart';
import '../widgets/editorial/editorial_button.dart';
import '../widgets/editorial/section_header.dart';
import '../widgets/motion/reveal_on_scroll.dart';

/// Bagian Proyek Pilihan dengan tata letak editorial asimetris.
class ProjectsSection extends StatelessWidget {
  final ScrollController scrollController;

  const ProjectsSection({super.key, required this.scrollController});

  static const List<_ProjectItem> _projects = [
    _ProjectItem(
      number: '01',
      category: 'Computer Vision · Medis',
      title: 'AI X-Ray Classifier',
      description:
          'Model CNN multiclass dengan interpretabilitas Grad-CAM dan evaluasi komprehensif untuk analisis citra radiografi.',
      link: 'http://felyxionspace.github.io/med_intel',
      actionLabel: 'Lihat Proyek',
      stack: ['TensorFlow', 'Grad-CAM', 'CNN'],
      isFeatured: true,
    ),
    _ProjectItem(
      number: '02',
      category: 'Kriptografi · Penyimpanan Terdistribusi',
      title: 'Hybrid Encryption System',
      description:
          'Arsitektur enkripsi hibrida yang memadukan AES-256, IPFS, dan penyimpanan metadata terverifikasi.',
      link: '',
      actionLabel: '',
      stack: ['AES-256', 'IPFS', 'Smart Contract'],
    ),
    _ProjectItem(
      number: '03',
      category: 'Sistem Agen Otonom',
      title: 'Agent-AI-Neural-Grid',
      description:
          'Kerangka kerja AI Agent berbasis LangGraph (State Graph) untuk mengorganisir siklus kognitif model secara otonom.',
      link: 'https://github.com/Retr0desk/Agent-AI-Neural-Grid',
      actionLabel: 'Lihat Repositori',
      stack: ['LangGraph', 'Python', 'State Graph'],
    ),
    _ProjectItem(
      number: '04',
      category: 'Pencarian Semantik · LLM',
      title: 'RAG Research Assistant',
      description:
          'Sistem RAG berbasis LangChain, ChromaDB, dan Zephyr-7B LLM untuk pencarian semantik serta tanya-jawab dokumen lokal.',
      link: 'https://github.com/Retr0desk/RAG-Research-Assistant',
      actionLabel: 'Lihat Repositori',
      stack: ['LangChain', 'ChromaDB', 'Zephyr-7B'],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final featured = _projects.first;
    final secondary = _projects.sublist(1);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(
          index: '03',
          title: 'Proyek Pilihan',
          scrollController: scrollController,
        ),
        const SizedBox(height: AppSpacing.xl),
        RevealOnScroll(
          scrollController: scrollController,
          child: _FeaturedProjectCard(project: featured),
        ),
        const SizedBox(height: AppSpacing.lg),
        LayoutBuilder(
          builder: (context, constraints) {
            final isCompact = constraints.maxWidth < 760;

            if (isCompact) {
              return Column(
                children: List.generate(secondary.length, (index) {
                  return Padding(
                    padding: EdgeInsets.only(
                      bottom: index < secondary.length - 1 ? AppSpacing.lg : 0,
                    ),
                    child: RevealOnScroll(
                      scrollController: scrollController,
                      delay: AppMotion.staggerStep * index,
                      child: _SecondaryProjectCard(project: secondary[index]),
                    ),
                  );
                }),
              );
            }

            return Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 6,
                      child: RevealOnScroll(
                        scrollController: scrollController,
                        delay: AppMotion.staggerStep,
                        child: _SecondaryProjectCard(project: secondary[0]),
                      ),
                    ),
                    const SizedBox(width: AppSpacing.lg),
                    Expanded(
                      flex: 5,
                      child: RevealOnScroll(
                        scrollController: scrollController,
                        delay: AppMotion.staggerStep * 2,
                        child: _SecondaryProjectCard(project: secondary[1]),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.lg),
                RevealOnScroll(
                  scrollController: scrollController,
                  delay: AppMotion.staggerStep * 3,
                  child: _SecondaryProjectCard(project: secondary[2]),
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}

class _ProjectItem {
  final String number;
  final String category;
  final String title;
  final String description;
  final String link;
  final String actionLabel;
  final List<String> stack;
  final bool isFeatured;

  const _ProjectItem({
    required this.number,
    required this.category,
    required this.title,
    required this.description,
    required this.link,
    required this.actionLabel,
    required this.stack,
    this.isFeatured = false,
  });
}

class _FeaturedProjectCard extends StatefulWidget {
  final _ProjectItem project;

  const _FeaturedProjectCard({required this.project});

  @override
  State<_FeaturedProjectCard> createState() => _FeaturedProjectCardState();
}

class _FeaturedProjectCardState extends State<_FeaturedProjectCard> {
  bool _hovered = false;

  Future<void> _openLink() async {
    if (widget.project.link.isEmpty) return;
    final uri = Uri.parse(widget.project.link);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  @override
  Widget build(BuildContext context) {
    final disableMotion = MediaQuery.disableAnimationsOf(context);
    final p = widget.project;

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: disableMotion ? Duration.zero : AppMotion.hoverDuration,
        curve: AppMotion.easeOut,
        padding: const EdgeInsets.all(AppSpacing.xl),
        decoration: BoxDecoration(
          color: _hovered ? AppColors.surfaceElevated : AppColors.surface,
          borderRadius: AppRadius.card,
          border: Border.all(
            color: _hovered
                ? AppColors.borderChampagneStrong
                : AppColors.borderChampagne,
          ),
        ),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isCompact = constraints.maxWidth < 700;

            final mainInfo = Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(p.number, style: AppTypography.editorialIndex()),
                    const SizedBox(width: AppSpacing.md),
                    Flexible(
                      child: Text(
                        p.category,
                        style: AppTypography.metaLabel(
                          color: AppColors.textMuted,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.md),
                Text(p.title, style: AppTypography.cardTitle(isFeatured: true)),
                const SizedBox(height: AppSpacing.sm),
                ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxWidth: AppSpacing.editorialColumnWidth,
                  ),
                  child: Text(p.description, style: AppTypography.bodyLarge()),
                ),
              ],
            );

            final sideMeta = Column(
              crossAxisAlignment: isCompact
                  ? CrossAxisAlignment.start
                  : CrossAxisAlignment.end,
              children: [
                Wrap(
                  spacing: AppSpacing.xs,
                  runSpacing: AppSpacing.xs,
                  alignment: isCompact ? WrapAlignment.start : WrapAlignment.end,
                  children: p.stack
                      .map((tech) => _TechMeta(label: tech))
                      .toList(),
                ),
                const SizedBox(height: AppSpacing.lg),
                if (p.link.isNotEmpty)
                  EditorialButton(
                    label: p.actionLabel,
                    icon: Icons.north_east_rounded,
                    onPressed: _openLink,
                  ),
              ],
            );

            if (isCompact) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  mainInfo,
                  const SizedBox(height: AppSpacing.lg),
                  sideMeta,
                ],
              );
            }

            return Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(flex: 7, child: mainInfo),
                const SizedBox(width: AppSpacing.xxl),
                Expanded(flex: 4, child: sideMeta),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _SecondaryProjectCard extends StatefulWidget {
  final _ProjectItem project;

  const _SecondaryProjectCard({required this.project});

  @override
  State<_SecondaryProjectCard> createState() => _SecondaryProjectCardState();
}

class _SecondaryProjectCardState extends State<_SecondaryProjectCard> {
  bool _hovered = false;

  Future<void> _openLink() async {
    if (widget.project.link.isEmpty) return;
    final uri = Uri.parse(widget.project.link);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  @override
  Widget build(BuildContext context) {
    final disableMotion = MediaQuery.disableAnimationsOf(context);
    final p = widget.project;

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: disableMotion ? Duration.zero : AppMotion.hoverDuration,
        curve: AppMotion.easeOut,
        padding: const EdgeInsets.all(AppSpacing.lg),
        decoration: BoxDecoration(
          color: _hovered ? AppColors.surfaceElevated : AppColors.surface,
          borderRadius: AppRadius.card,
          border: Border.all(
            color: _hovered
                ? AppColors.borderChampagneStrong
                : AppColors.borderSubtle,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(p.number, style: AppTypography.editorialIndex()),
                Flexible(
                  child: Text(
                    p.category,
                    textAlign: TextAlign.right,
                    style: AppTypography.metaLabel(),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            AnimatedContainer(
              duration: disableMotion ? Duration.zero : AppMotion.hoverDuration,
              width: _hovered ? 48 : 24,
              height: 1,
              color: AppColors.champagne,
            ),
            const SizedBox(height: AppSpacing.md),
            Text(p.title, style: AppTypography.cardTitle(isFeatured: false)),
            const SizedBox(height: AppSpacing.sm),
            Text(p.description, style: AppTypography.bodyMedium()),
            const SizedBox(height: AppSpacing.lg),
            Wrap(
              spacing: AppSpacing.xs,
              runSpacing: AppSpacing.xs,
              children: p.stack.map((t) => _TechMeta(label: t)).toList(),
            ),
            const SizedBox(height: AppSpacing.lg),
            if (p.link.isNotEmpty)
              EditorialButton(
                label: p.actionLabel,
                icon: Icons.north_east_rounded,
                onPressed: _openLink,
              )
            else
              Container(
                constraints: const BoxConstraints(
                  minHeight: AppSpacing.minTapTarget,
                ),
                alignment: Alignment.centerLeft,
                child: Text(
                  'Arsip Internal · Tanpa Tautan Publik',
                  style: AppTypography.metaLabel(color: AppColors.textMuted),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _TechMeta extends StatelessWidget {
  final String label;
  const _TechMeta({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.xxs,
      ),
      decoration: BoxDecoration(
        borderRadius: AppRadius.control,
        border: Border.all(color: AppColors.borderSubtle),
      ),
      child: Text(
        label,
        style: AppTypography.metaLabel(color: AppColors.textSecondary),
      ),
    );
  }
}
