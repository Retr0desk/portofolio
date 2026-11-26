import 'package:flutter/material.dart';
import 'package:portofolio/utils/url_strategy.dart';
import 'package:portofolio/components/about.dart';
import 'package:portofolio/components/certificate.dart';
import 'package:portofolio/components/contact.dart';
import 'package:portofolio/components/footer.dart';
import 'package:portofolio/components/hero.dart';
import 'package:portofolio/components/navbar.dart';
import 'package:portofolio/components/projects.dart';
import 'package:portofolio/components/skills.dart';
import 'package:portofolio/theme/app_motion.dart';
import 'package:portofolio/theme/app_spacing.dart';
import 'package:portofolio/theme/app_theme.dart';
import 'package:portofolio/widgets/motion/scroll_progress_bar.dart';
import 'package:portofolio/widgets/motion/section_divider_line.dart';

void main() {
  configureUrlStrategy();
  runApp(const PortfolioApp());
}

class PortfolioApp extends StatelessWidget {
  const PortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Wahyu Ajitomo — Portofolio',
      theme: AppTheme.dark(),
      darkTheme: AppTheme.dark(),
      themeMode: ThemeMode.dark,
      home: const PortfolioHome(),
    );
  }
}

class PortfolioHome extends StatefulWidget {
  const PortfolioHome({super.key});

  @override
  State<PortfolioHome> createState() => _PortfolioHomeState();
}

class _PortfolioHomeState extends State<PortfolioHome> {
  final ScrollController _scrollController = ScrollController();

  final _aboutKey = GlobalKey();
  final _skillsKey = GlobalKey();
  final _projectsKey = GlobalKey();
  final _certificatesKey = GlobalKey();
  final _contactKey = GlobalKey();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _scrollToTop() async {
    final disableMotion = MediaQuery.disableAnimationsOf(context);
    if (disableMotion) {
      _scrollController.jumpTo(0);
      return;
    }
    await _scrollController.animateTo(
      0,
      duration: AppMotion.scrollToDuration,
      curve: AppMotion.scrollCurve,
    );
  }

  Future<void> _scrollToKey(GlobalKey key) async {
    final targetContext = key.currentContext;
    if (targetContext == null) return;

    final disableMotion = MediaQuery.disableAnimationsOf(context);
    final box = targetContext.findRenderObject();
    if (box is! RenderBox) return;

    final pos = box.localToGlobal(Offset.zero).dy;
    final targetOffset = (_scrollController.offset + pos - 96).clamp(
      0.0,
      _scrollController.position.maxScrollExtent,
    );

    if (disableMotion) {
      _scrollController.jumpTo(targetOffset);
      return;
    }

    await _scrollController.animateTo(
      targetOffset,
      duration: AppMotion.scrollToDuration,
      curve: AppMotion.scrollCurve,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            controller: _scrollController,
            child: LayoutBuilder(
              builder: (context, constraints) {
                final isCompact = constraints.maxWidth < 700;
                final horizontalPadding = isCompact
                    ? AppSpacing.lg
                    : AppSpacing.xl;
                final sectionGap = isCompact
                    ? AppSpacing.sectionMobile
                    : AppSpacing.sectionDesktop;

                return Column(
                  children: [
                    const SizedBox(height: AppSpacing.xxxl),
                    EditorialHero(
                      scrollController: _scrollController,
                      onViewProjects: () => _scrollToKey(_projectsKey),
                    ),
                    Center(
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(
                          maxWidth: AppSpacing.maxContentWidth,
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: horizontalPadding,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SectionDividerLine(
                                scrollController: _scrollController,
                              ),
                              SizedBox(height: sectionGap),
                              KeyedSubtree(
                                key: _aboutKey,
                                child: AboutSection(
                                  scrollController: _scrollController,
                                ),
                              ),
                              SizedBox(height: sectionGap),
                              KeyedSubtree(
                                key: _skillsKey,
                                child: SkillsSection(
                                  scrollController: _scrollController,
                                ),
                              ),
                              SizedBox(height: sectionGap),
                              KeyedSubtree(
                                key: _projectsKey,
                                child: ProjectsSection(
                                  scrollController: _scrollController,
                                ),
                              ),
                              SizedBox(height: sectionGap),
                              KeyedSubtree(
                                key: _certificatesKey,
                                child: CertificatesSection(
                                  scrollController: _scrollController,
                                ),
                              ),
                              SizedBox(height: sectionGap),
                              KeyedSubtree(
                                key: _contactKey,
                                child: ContactSection(
                                  scrollController: _scrollController,
                                ),
                              ),
                              SizedBox(height: sectionGap),
                              const Footer(),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SafeArea(
              bottom: false,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ScrollProgressBar(scrollController: _scrollController),
                  AdaptiveNavBar(
                    scrollController: _scrollController,
                    onTop: _scrollToTop,
                    onAbout: () => _scrollToKey(_aboutKey),
                    onSkills: () => _scrollToKey(_skillsKey),
                    onProjects: () => _scrollToKey(_projectsKey),
                    onCertificates: () => _scrollToKey(_certificatesKey),
                    onContact: () => _scrollToKey(_contactKey),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
