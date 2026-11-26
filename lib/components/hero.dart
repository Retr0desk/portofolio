import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../theme/app_colors.dart';
import '../theme/app_motion.dart';
import '../theme/app_radius.dart';
import '../theme/app_spacing.dart';
import '../theme/app_typography.dart';
import '../widgets/editorial/editorial_button.dart';
import '../widgets/motion/line_reveal_text.dart';
import '../widgets/motion/parallax_image.dart';

/// Bagian Hero editorial asimetris dengan tipografi display besar dan potret parallax.
class EditorialHero extends StatelessWidget {
  final ScrollController scrollController;
  final VoidCallback onViewProjects;

  const EditorialHero({
    super.key,
    required this.scrollController,
    required this.onViewProjects,
  });

  static final Uri _cvUri = Uri.parse(
    'https://drive.google.com/file/d/1lMWtHGZogna9j2y5ZwuBDorS7LZcr830/view?usp=sharing',
  );

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isCompact = constraints.maxWidth < 840;
        final isNarrow = constraints.maxWidth < 520;

        final textBlock = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 24,
                  height: 1,
                  color: AppColors.champagne,
                ),
                const SizedBox(width: AppSpacing.sm),
                Flexible(
                  child: Text(
                    'Chief Technology Officer · PT. Andara Rejo Makmur',
                    style: AppTypography.metaLabel(color: AppColors.champagne),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.lg),
            LineRevealText(
              lines: isNarrow ? const ['Wahyu', 'Ajitomo'] : const ['Wahyu Ajitomo'],
              style: AppTypography.displayHero(isCompact: isCompact),
              initialDelay: const Duration(milliseconds: 100),
            ),
            const SizedBox(height: AppSpacing.lg),
            ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: AppSpacing.editorialColumnWidth,
              ),
              child: Text(
                'Merancang model pembelajaran mendalam yang dapat diinterpretasikan, '
                'arsitektur enkripsi hibrida, dan layanan backend yang terstruktur.',
                style: AppTypography.bodyLarge(),
              ),
            ),
            const SizedBox(height: AppSpacing.xl),
            Wrap(
              spacing: AppSpacing.md,
              runSpacing: AppSpacing.sm,
              children: [
                EditorialButton(
                  label: 'Unduh CV',
                  icon: Icons.arrow_downward_rounded,
                  isPrimary: true,
                  onPressed: () => launchUrl(_cvUri),
                ),
                EditorialButton(
                  label: 'Lihat Proyek',
                  icon: Icons.south_rounded,
                  onPressed: onViewProjects,
                ),
              ],
            ),
          ],
        );

        final portrait = _EditorialPortrait(scrollController: scrollController);

        return Padding(
          padding: EdgeInsets.symmetric(
            horizontal: isNarrow ? AppSpacing.lg : AppSpacing.xl,
          ),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: AppSpacing.maxContentWidth,
              ),
              child: Padding(
                padding: EdgeInsets.only(
                  top: isCompact ? AppSpacing.xxl : AppSpacing.xxxl,
                  bottom: isCompact ? AppSpacing.xxl : AppSpacing.xxxl,
                ),
                child: isCompact
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          textBlock,
                          const SizedBox(height: AppSpacing.xxl),
                          Center(
                            child: ConstrainedBox(
                              constraints: const BoxConstraints(maxWidth: 360),
                              child: portrait,
                            ),
                          ),
                        ],
                      )
                    : Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(flex: 7, child: textBlock),
                          const SizedBox(width: AppSpacing.xxxl),
                          Expanded(flex: 4, child: portrait),
                        ],
                      ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _EditorialPortrait extends StatefulWidget {
  final ScrollController scrollController;

  const _EditorialPortrait({required this.scrollController});

  @override
  State<_EditorialPortrait> createState() => _EditorialPortraitState();
}

class _EditorialPortraitState extends State<_EditorialPortrait> {
  bool _hovered = false;

  static const ColorFilter _grayscaleFilter = ColorFilter.matrix(<double>[
    0.2126, 0.7152, 0.0722, 0, 0,
    0.2126, 0.7152, 0.0722, 0, 0,
    0.2126, 0.7152, 0.0722, 0, 0,
    0, 0, 0, 1, 0,
  ]);

  @override
  Widget build(BuildContext context) {
    final disableMotion = MediaQuery.disableAnimationsOf(context);

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: Semantics(
        image: true,
        label: 'Foto profil Wahyu Ajitomo',
        child: AnimatedContainer(
          duration: disableMotion ? Duration.zero : AppMotion.hoverDuration,
          decoration: BoxDecoration(
            borderRadius: AppRadius.media,
            border: Border.all(
              color: _hovered
                  ? AppColors.borderChampagneStrong
                  : AppColors.borderChampagne,
            ),
          ),
          child: AspectRatio(
            aspectRatio: 4 / 5,
            child: ParallaxImage(
              scrollController: widget.scrollController,
              borderRadius: AppRadius.media,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(
                    'assets/profile.jpg',
                    fit: BoxFit.cover,
                    alignment: Alignment.topCenter,
                  ),
                  AnimatedOpacity(
                    duration: disableMotion
                        ? Duration.zero
                        : AppMotion.revealDuration,
                    curve: AppMotion.easeOut,
                    opacity: _hovered ? 0.0 : 0.85,
                    child: ColorFiltered(
                      colorFilter: _grayscaleFilter,
                      child: Image.asset(
                        'assets/profile.jpg',
                        fit: BoxFit.cover,
                        alignment: Alignment.topCenter,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
