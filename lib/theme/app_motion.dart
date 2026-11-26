import 'package:flutter/material.dart';

/// Konfigurasi terpusat untuk seluruh durasi, kurva, dan offset animasi.
abstract final class AppMotion {
  static const Duration revealDuration = Duration(milliseconds: 620);
  static const Duration lineRevealDuration = Duration(milliseconds: 560);
  static const Duration hoverDuration = Duration(milliseconds: 220);
  static const Duration navDuration = Duration(milliseconds: 260);
  static const Duration scrollToDuration = Duration(milliseconds: 850);
  static const Duration staggerStep = Duration(milliseconds: 80);

  static const double revealOffsetY = 30.0;
  static const double parallaxMaxFactor = 0.10;

  static const Curve easeOut = Curves.easeOutCubic;
  static const Curve scrollCurve = Curves.easeInOutCubic;
}
