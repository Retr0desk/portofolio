import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

/// Tipografi editorial: Cormorant Garamond untuk judul display, Inter untuk teks UI dan isi.
abstract final class AppTypography {
  static TextStyle displayHero({required bool isCompact}) {
    return GoogleFonts.cormorantGaramond(
      fontSize: isCompact ? 46 : 76,
      fontWeight: FontWeight.w500,
      height: 1.02,
      letterSpacing: isCompact ? -0.8 : -1.5,
      color: AppColors.textPrimary,
    );
  }

  static TextStyle sectionTitle({required bool isCompact}) {
    return GoogleFonts.cormorantGaramond(
      fontSize: isCompact ? 34 : 48,
      fontWeight: FontWeight.w500,
      height: 1.1,
      letterSpacing: isCompact ? -0.4 : -0.8,
      color: AppColors.textPrimary,
    );
  }

  static TextStyle cardTitle({required bool isFeatured}) {
    return GoogleFonts.cormorantGaramond(
      fontSize: isFeatured ? 32 : 26,
      fontWeight: FontWeight.w500,
      height: 1.18,
      letterSpacing: -0.3,
      color: AppColors.textPrimary,
    );
  }

  static TextStyle editorialIndex() {
    return GoogleFonts.inter(
      fontSize: 13,
      fontWeight: FontWeight.w500,
      letterSpacing: 1.4,
      color: AppColors.champagne,
      fontFeatures: const [FontFeature.tabularFigures()],
    );
  }

  static TextStyle metaLabel({Color color = AppColors.textMuted}) {
    return GoogleFonts.inter(
      fontSize: 13,
      fontWeight: FontWeight.w500,
      height: 1.4,
      letterSpacing: 0.4,
      color: color,
    );
  }

  static TextStyle bodyLarge() {
    return GoogleFonts.inter(
      fontSize: 17,
      fontWeight: FontWeight.w400,
      height: 1.7,
      color: AppColors.textSecondary,
    );
  }

  static TextStyle bodyMedium() {
    return GoogleFonts.inter(
      fontSize: 15,
      fontWeight: FontWeight.w400,
      height: 1.65,
      color: AppColors.textSecondary,
    );
  }

  static TextStyle buttonLabel({Color color = AppColors.textPrimary}) {
    return GoogleFonts.inter(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.2,
      color: color,
    );
  }

  static TextTheme buildTextTheme() {
    final base = GoogleFonts.interTextTheme(ThemeData.dark().textTheme);
    return base.copyWith(
      displayLarge: displayHero(isCompact: false),
      headlineLarge: sectionTitle(isCompact: false),
      headlineMedium: cardTitle(isFeatured: false),
      bodyLarge: bodyLarge(),
      bodyMedium: bodyMedium(),
      labelLarge: buttonLabel(),
      labelMedium: metaLabel(),
    );
  }
}
