import 'dart:ui';
import 'package:flutter/material.dart';

class Glass extends StatelessWidget {
  final Widget child;
  final double blur;
  final double opacity;
  final EdgeInsets padding;
  final double radius;
  final bool isScrolling; // ⬅ baru ditambahkan

  const Glass({
    super.key,
    required this.child,
    this.blur = 20,
    this.opacity = 0.10,
    this.padding = const EdgeInsets.all(20),
    this.radius = 26,
    this.isScrolling = false, // ⬅ default
  });

  @override
  Widget build(BuildContext context) {
    // Deteksi perangkat low-spec (opsional)
    final isLowSpecDevice = MediaQuery.of(context).size.width < 500;

    // Blur adaptif → low device pakai blur lebih ringan supaya smooth
    final adaptiveBlur = isLowSpecDevice ? blur * 0.35 : blur;

    // Opacity animasi → saat scroll sedikit transparan, berhenti kembali blur
    final animatedOpacity = isScrolling ? opacity * 0.55 : opacity;

    return RepaintBoundary(
      // ⬅ mencegah repaint seluruh UI saat scroll
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeOut,
        opacity: isScrolling ? 0.85 : 1.0,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(radius),
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: adaptiveBlur,
              sigmaY: adaptiveBlur,
            ),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 350),
              curve: Curves.easeOutQuad,
              padding: padding,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(radius),
                border: Border.all(color: Colors.white.withOpacity(0.12)),
                color: Colors.white.withOpacity(animatedOpacity),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(isScrolling ? 0.15 : 0.30),
                    blurRadius: isScrolling ? 10 : 22,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}
