import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_motion.dart';

/// Garis pemisah tipis yang tergambar dari kiri ke kanan saat memasuki viewport.
class SectionDividerLine extends StatefulWidget {
  final ScrollController scrollController;

  const SectionDividerLine({super.key, required this.scrollController});

  @override
  State<SectionDividerLine> createState() => _SectionDividerLineState();
}

class _SectionDividerLineState extends State<SectionDividerLine>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  bool _hasDrawn = false;
  bool _checkScheduled = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: AppMotion.revealDuration,
    );
    widget.scrollController.addListener(_scheduleCheck);
    WidgetsBinding.instance.addPostFrameCallback((_) => _checkVisibility());
  }

  void _scheduleCheck() {
    if (_hasDrawn || _checkScheduled || !mounted) return;
    _checkScheduled = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkScheduled = false;
      _checkVisibility();
    });
  }

  void _checkVisibility() {
    if (!mounted || _hasDrawn) return;
    if (MediaQuery.disableAnimationsOf(context)) {
      _hasDrawn = true;
      _controller.value = 1.0;
      return;
    }

    final renderObject = context.findRenderObject();
    if (renderObject is! RenderBox || !renderObject.hasSize) return;
    final viewportHeight = MediaQuery.sizeOf(context).height;
    final top = renderObject.localToGlobal(Offset.zero).dy;

    if (top <= viewportHeight * 0.92) {
      _hasDrawn = true;
      widget.scrollController.removeListener(_scheduleCheck);
      _controller.forward();
    }
  }

  @override
  void dispose() {
    widget.scrollController.removeListener(_scheduleCheck);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (MediaQuery.disableAnimationsOf(context)) {
      return Container(height: 1, color: AppColors.borderChampagne);
    }

    return RepaintBoundary(
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, _) {
          final value = AppMotion.easeOut.transform(_controller.value);
          return Transform.scale(
            scaleX: value,
            alignment: Alignment.centerLeft,
            child: Container(height: 1, color: AppColors.borderChampagne),
          );
        },
      ),
    );
  }
}
