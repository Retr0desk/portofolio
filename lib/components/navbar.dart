import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_colors.dart';
import '../theme/app_motion.dart';
import '../theme/app_spacing.dart';
import '../theme/app_typography.dart';

/// Navbar adaptif: transparan di puncak halaman, solid/blur tipis saat digulir,
/// tersembunyi saat scroll turun, dan muncul kembali saat scroll naik.
class AdaptiveNavBar extends StatefulWidget {
  final ScrollController scrollController;
  final VoidCallback onTop;
  final VoidCallback onAbout;
  final VoidCallback onSkills;
  final VoidCallback onProjects;
  final VoidCallback onCertificates;
  final VoidCallback onContact;

  const AdaptiveNavBar({
    super.key,
    required this.scrollController,
    required this.onTop,
    required this.onAbout,
    required this.onSkills,
    required this.onProjects,
    required this.onCertificates,
    required this.onContact,
  });

  @override
  State<AdaptiveNavBar> createState() => _AdaptiveNavBarState();
}

class _AdaptiveNavBarState extends State<AdaptiveNavBar> {
  bool _isScrolled = false;
  bool _isVisible = true;
  double _lastOffset = 0;

  @override
  void initState() {
    super.initState();
    widget.scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (!widget.scrollController.hasClients) return;
    final offset = widget.scrollController.offset;
    final direction = widget.scrollController.position.userScrollDirection;

    final nextScrolled = offset > 32;
    bool nextVisible = _isVisible;

    if (offset <= 80) {
      nextVisible = true;
    } else if (direction == ScrollDirection.reverse && offset > _lastOffset + 6) {
      nextVisible = false;
    } else if (direction == ScrollDirection.forward && offset < _lastOffset - 6) {
      nextVisible = true;
    }
    _lastOffset = offset;

    if (nextScrolled != _isScrolled || nextVisible != _isVisible) {
      setState(() {
        _isScrolled = nextScrolled;
        _isVisible = nextVisible;
      });
    }
  }

  @override
  void dispose() {
    widget.scrollController.removeListener(_onScroll);
    super.dispose();
  }

  void _openMobileMenu(BuildContext context, List<_NavEntry> entries) {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (sheetContext) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.lg,
              vertical: AppSpacing.xl,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Navigasi',
                  style: AppTypography.metaLabel(color: AppColors.champagne),
                ),
                const SizedBox(height: AppSpacing.md),
                ...entries.map(
                  (entry) => InkWell(
                    onTap: () {
                      Navigator.of(sheetContext).pop();
                      entry.onTap();
                    },
                    child: Container(
                      width: double.infinity,
                      constraints: const BoxConstraints(
                        minHeight: AppSpacing.minTapTarget,
                      ),
                      alignment: Alignment.centerLeft,
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(color: AppColors.borderSubtle),
                        ),
                      ),
                      child: Text(
                        entry.label,
                        style: AppTypography.bodyLarge().copyWith(
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final disableMotion = MediaQuery.disableAnimationsOf(context);
    final entries = [
      _NavEntry('Tentang', widget.onAbout),
      _NavEntry('Keahlian', widget.onSkills),
      _NavEntry('Proyek', widget.onProjects),
      _NavEntry('Sertifikat', widget.onCertificates),
      _NavEntry('Kontak', widget.onContact),
    ];

    final navContent = AnimatedContainer(
      duration: disableMotion ? Duration.zero : AppMotion.navDuration,
      curve: AppMotion.easeOut,
      padding: EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: _isScrolled ? AppSpacing.sm : AppSpacing.md,
      ),
      decoration: BoxDecoration(
        color: _isScrolled ? AppColors.scrim : Colors.transparent,
        border: Border(
          bottom: BorderSide(
            color: _isScrolled ? AppColors.borderSubtle : Colors.transparent,
          ),
        ),
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: AppSpacing.maxContentWidth,
          ),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final isCompact = constraints.maxWidth < 740;

              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Semantics(
                    button: true,
                    label: 'Kembali ke atas halaman',
                    child: InkWell(
                      onTap: widget.onTop,
                      borderRadius: BorderRadius.circular(4),
                      child: Container(
                        constraints: const BoxConstraints(
                          minHeight: AppSpacing.minTapTarget,
                        ),
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.xs,
                        ),
                        child: Text(
                          'Wahyu Ajitomo',
                          style: GoogleFonts.cormorantGaramond(
                            fontSize: 22,
                            fontWeight: FontWeight.w500,
                            letterSpacing: -0.3,
                            color: AppColors.textPrimary,
                          ),
                        ),
                      ),
                    ),
                  ),
                  if (isCompact)
                    Semantics(
                      button: true,
                      label: 'Buka menu navigasi',
                      child: IconButton(
                        onPressed: () => _openMobileMenu(context, entries),
                        icon: const Icon(
                          Icons.menu_rounded,
                          color: AppColors.textPrimary,
                          size: 22,
                        ),
                        constraints: const BoxConstraints(
                          minWidth: AppSpacing.minTapTarget,
                          minHeight: AppSpacing.minTapTarget,
                        ),
                      ),
                    )
                  else
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: entries
                          .map((e) => _NavLink(label: e.label, onTap: e.onTap))
                          .toList(),
                    ),
                ],
              );
            },
          ),
        ),
      ),
    );

    final wrapped = _isScrolled
        ? ClipRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
              child: navContent,
            ),
          )
        : navContent;

    return AnimatedSlide(
      duration: disableMotion ? Duration.zero : AppMotion.navDuration,
      curve: AppMotion.easeOut,
      offset: _isVisible ? Offset.zero : const Offset(0, -1),
      child: AnimatedOpacity(
        duration: disableMotion ? Duration.zero : AppMotion.navDuration,
        opacity: _isVisible ? 1.0 : 0.0,
        child: wrapped,
      ),
    );
  }
}

class _NavEntry {
  final String label;
  final VoidCallback onTap;
  const _NavEntry(this.label, this.onTap);
}

class _NavLink extends StatefulWidget {
  final String label;
  final VoidCallback onTap;

  const _NavLink({required this.label, required this.onTap});

  @override
  State<_NavLink> createState() => _NavLinkState();
}

class _NavLinkState extends State<_NavLink> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: AppSpacing.md),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (_) => setState(() => _hovered = true),
        onExit: (_) => setState(() => _hovered = false),
        child: InkWell(
          onTap: widget.onTap,
          borderRadius: BorderRadius.circular(4),
          child: Container(
            constraints: const BoxConstraints(
              minHeight: AppSpacing.minTapTarget,
            ),
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xs),
            alignment: Alignment.center,
            child: AnimatedDefaultTextStyle(
              duration: AppMotion.hoverDuration,
              style: AppTypography.buttonLabel(
                color: _hovered
                    ? AppColors.champagneBright
                    : AppColors.textSecondary,
              ),
              child: Text(widget.label),
            ),
          ),
        ),
      ),
    );
  }
}
