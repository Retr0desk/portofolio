import 'package:flutter/material.dart';
import 'package:portfolio/components/AnimationSection.dart';
import 'package:portfolio/components/about.dart';
import 'package:portfolio/components/certificate.dart';
import 'package:portfolio/components/contact.dart';
import 'package:portfolio/components/footer.dart';
import 'package:portfolio/components/hero.dart';
import 'package:portfolio/components/navbar.dart';
import 'package:portfolio/components/projects.dart';
import 'package:portfolio/components/skills.dart';

void main() {
  runApp(const PortfolioApp());
}

class PortfolioApp extends StatelessWidget {
  const PortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Portfolio Wahyu Ajitomo',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF050507),
        textTheme: ThemeData.dark().textTheme,
      ),
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
  double offsetY = 0;

  // === Scroll-To-Section Keys ===
  final aboutKey = GlobalKey();
  final skillsKey = GlobalKey();
  final projectsKey = GlobalKey();
  final certificatesKey = GlobalKey();
  final contactKey = GlobalKey();

  // === SMOOTH SCROLL PREMIUM ===
  final ScrollController smoothScroll = ScrollController();

  Future<void> scrollToKey(GlobalKey key) async {
    final context = key.currentContext;
    if (context == null) return;

    final box = context.findRenderObject() as RenderBox;
    final pos = box.localToGlobal(Offset.zero, ancestor: null).dy;

    final targetOffset = smoothScroll.offset + pos - 120;

    await smoothScroll.animateTo(
      targetOffset,
      duration: const Duration(milliseconds: 900),
      curve: Curves.easeInOutCubic,
    );
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (scroll) {
        setState(() => offsetY = scroll.metrics.pixels);
        return true;
      },
      child: Scaffold(
        body: Stack(
          children: [
            // Background glow
            Positioned.fill(
              child: Image.asset(
                'assets/bg_glow_purple.png',
                fit: BoxFit.cover,
                color: Colors.black.withOpacity(0.4),
                colorBlendMode: BlendMode.darken,
              ),
            ),

            // MAIN CONTENT
            SingleChildScrollView(
              controller: smoothScroll,
              child: Column(
                children: [
                  const SizedBox(height: 40),

                  FancyNavBar(
                    onAbout: () => scrollToKey(aboutKey),
                    onSkills: () => scrollToKey(skillsKey),
                    onProjects: () => scrollToKey(projectsKey),
                    onCertficates: () => scrollToKey(certificatesKey),
                    onContact: () => scrollToKey(contactKey),
                  ),

                  const SizedBox(height: 34),
                  const FancyHero(),
                  const SizedBox(height: 100),

                  AnimatedSection(
                    child: Container(
                      key: aboutKey,
                      child: const AboutSection(),
                    ),
                  ),
                  const SizedBox(height: 80),

                  AnimatedSection(
                    child: Container(
                      key: skillsKey,
                      child: const SkillsSection(),
                    ),
                  ),
                  const SizedBox(height: 80),

                  AnimatedSection(
                    child: Container(
                      key: projectsKey,
                      child: const ProjectsSection(),
                    ),
                  ),
                  const SizedBox(height: 80),

                  AnimatedSection(
                    child: Container(
                      key: certificatesKey,
                      child: const CertificatesSection(),
                    ),
                  ),
                  const SizedBox(height: 80),

                  AnimatedSection(
                    child: Container(
                      key: contactKey,
                      child: const ContactSection(),
                    ),
                  ),
                  const SizedBox(height: 60),

                  const Footer(),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
