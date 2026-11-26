# Progress Log — Portfolio Wahyu Ajitomo

## 2026-11-26 — Langkah 0: Pemetaan Awal (Baseline)
- **Status:** Selesai
- **File terkait:** `pubspec.yaml`, `lib/main.dart`, `lib/components/*`, `assets/*`
- **Ringkasan kondisi awal:**
  - **Screen / Entry:** Single-page portfolio (`PortfolioHome` di `lib/main.dart`) menggunakan `SingleChildScrollView` + `GlobalKey` untuk scroll-to-section; belum ada routing multi-halaman.
  - **Komponen reusable (`lib/components/`):** `FancyNavBar` (`navbar.dart`), `FancyHero` (`hero.dart`), `AboutSection` (`about.dart`), `SkillsSection` (`skills.dart`), `ProjectsSection` (`projects.dart`), `CertificatesSection` (`certificate.dart`), `ContactSection` (`contact.dart`), `Footer` (`footer.dart`), `Glass` (`glass.dart`), `AnimatedSection` (`AnimationSection.dart`).
  - **State management:** `StatefulWidget` lokal (`isScrolling` + `Timer` di `PortfolioHome`, `hover` boolean di `ProjectCard` dan `CertificateCard`).
  - **Theme & Typography:** `ThemeData.dark()` inline di `lib/main.dart` dengan `scaffoldBackgroundColor: Color(0xFF050507)` dan `GoogleFonts.poppinsTextTheme`; tidak ada design system terpusat; warna/spacing/radius di-hardcode di tiap komponen.
  - **Aset:** `assets/bg_glow_purple.png`, `assets/profile.jpg`, `assets/fonts/SFPRODISPLAYREGULAR.otf`, `assets/fonts/SFPRODISPLAYBOLD.otf`.
  - **Dependency:** `google_fonts: 6.3.2`, `url_launcher: ^6.3.2`, `animations: ^2.1.0`, `cupertino_icons: ^1.0.8`, `responsive_framework: ^1.5.1`.

## 2026-11-26 — Langkah 2 & 3: Design System, Sistem Animasi Scroll, & Refactor Editorial
- **Status:** Selesai
- **File terkait:**
  - Design system: `lib/theme/app_colors.dart`, `lib/theme/app_spacing.dart`, `lib/theme/app_radius.dart`, `lib/theme/app_motion.dart`, `lib/theme/app_typography.dart`, `lib/theme/app_theme.dart`
  - Sistem animasi scroll: `lib/widgets/motion/reveal_on_scroll.dart`, `lib/widgets/motion/line_reveal_text.dart`, `lib/widgets/motion/parallax_image.dart`, `lib/widgets/motion/scroll_progress_bar.dart`, `lib/widgets/motion/section_divider_line.dart`
  - Komponen & utilitas: `lib/widgets/editorial/section_header.dart`, `lib/widgets/editorial/editorial_button.dart`, `lib/utils/url_strategy.dart`, `lib/utils/url_strategy_stub.dart`, `lib/utils/url_strategy_web.dart`
  - Halaman & section: `lib/main.dart`, `lib/components/navbar.dart`, `lib/components/hero.dart`, `lib/components/about.dart`, `lib/components/skills.dart`, `lib/components/projects.dart`, `lib/components/certificate.dart`, `lib/components/contact.dart`, `lib/components/footer.dart`
  - Dihapus: `lib/components/glass.dart`, `lib/components/AnimationSection.dart`
- **Ringkasan perubahan:**
  - Mengganti tema glassmorphism ungu dengan dark editorial (`#0E0E10`–`#1B1B20`) dan aksen champagne (`#D4B98C`), dipadukan tipografi `Cormorant Garamond` + `Inter`.
  - Membangun sistem animasi scroll terpusat berbasis `ScrollController` dan `RepaintBoundary` (reveal satu kali, line-by-line headline reveal, parallax potret 10%, scroll progress bar, garis pemisah animasi, dan navbar adaptif) yang menghormati `MediaQuery.disableAnimations`.
  - Menyeragamkan seluruh copy ke Bahasa Indonesia, memperbaiki layout responsif dengan `LayoutBuilder`, memenuhi target sentuh `48dp` & `Semantics`, serta menonaktifkan tautan kosong pada `Hybrid Encryption System`.

## 2026-11-26 — Langkah 4: Verifikasi & Deployment
- **Status:** Selesai
- **File terkait:** `test/widget_test.dart`
- **Hasil:**
  - `flutter analyze`: 0 issues found.
  - `flutter test`: All tests passed (1/1).
  - `flutter build web --release --base-href "/portofolio/"` dan deployment ke GitHub Pages (`gh-pages`).

## 2026-11-26 — Pembaruan Profil & Keahlian
- **Status:** Selesai
- **File terkait:** `lib/components/skills.dart`, `lib/components/hero.dart`, `lib/components/about.dart`
- **Ringkasan:** Menambahkan keahlian `JavaScript`, `Node.js`, `React`, `Next.js`, `Supabase` serta memperbarui peran saat ini sebagai Chief Technology Officer di PT. Andara Rejo Makmur (sejak November) dan basis di Yogyakarta, Indonesia.
