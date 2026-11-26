import 'dart:async';
import 'package:flutter/material.dart';
import '../../theme/app_motion.dart';

/// Menampilkan judul baris per baris dengan efek masking dari bawah.
class LineRevealText extends StatefulWidget {
  final List<String> lines;
  final TextStyle style;
  final ScrollController? scrollController;
  final Duration initialDelay;
  final TextAlign textAlign;

  const LineRevealText({
    super.key,
    required this.lines,
    required this.style,
    this.scrollController,
    this.initialDelay = Duration.zero,
    this.textAlign = TextAlign.left,
  });

  @override
  State<LineRevealText> createState() => _LineRevealTextState();
}

class _LineRevealTextState extends State<LineRevealText>
    with TickerProviderStateMixin {
  late final List<AnimationController> _controllers;
  final List<Timer> _timers = [];
  bool _hasRevealed = false;
  bool _checkScheduled = false;

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(
      widget.lines.length,
      (_) => AnimationController(
        vsync: this,
        duration: AppMotion.lineRevealDuration,
      ),
    );

    widget.scrollController?.addListener(_scheduleCheck);
    WidgetsBinding.instance.addPostFrameCallback((_) => _checkVisibility());
  }

  void _scheduleCheck() {
    if (_hasRevealed || _checkScheduled || !mounted) return;
    _checkScheduled = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkScheduled = false;
      _checkVisibility();
    });
  }

  void _checkVisibility() {
    if (!mounted || _hasRevealed) return;
    if (MediaQuery.disableAnimationsOf(context)) {
      _hasRevealed = true;
      for (final c in _controllers) {
        c.value = 1.0;
      }
      return;
    }

    if (widget.scrollController == null) {
      _triggerReveal();
      return;
    }

    final renderObject = context.findRenderObject();
    if (renderObject is! RenderBox || !renderObject.hasSize) return;

    final viewportHeight = MediaQuery.sizeOf(context).height;
    final top = renderObject.localToGlobal(Offset.zero).dy;
    final bottom = top + renderObject.size.height;

    if (top <= viewportHeight * 0.92 && bottom >= 0) {
      _triggerReveal();
    }
  }

  void _triggerReveal() {
    _hasRevealed = true;
    widget.scrollController?.removeListener(_scheduleCheck);
    for (var i = 0; i < _controllers.length; i++) {
      final delay = widget.initialDelay + (AppMotion.staggerStep * i);
      if (delay == Duration.zero) {
        _controllers[i].forward();
      } else {
        _timers.add(
          Timer(delay, () {
            if (mounted) _controllers[i].forward();
          }),
        );
      }
    }
  }

  @override
  void dispose() {
    widget.scrollController?.removeListener(_scheduleCheck);
    for (final t in _timers) {
      t.cancel();
    }
    for (final c in _controllers) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final disableMotion = MediaQuery.disableAnimationsOf(context);
    final crossAlign = widget.textAlign == TextAlign.center
        ? CrossAxisAlignment.center
        : CrossAxisAlignment.start;

    return RepaintBoundary(
      child: Column(
        crossAxisAlignment: crossAlign,
        mainAxisSize: MainAxisSize.min,
        children: List.generate(widget.lines.length, (index) {
          final text = Text(
            widget.lines[index],
            textAlign: widget.textAlign,
            style: widget.style,
          );
          if (disableMotion) return text;

          final curved = CurvedAnimation(
            parent: _controllers[index],
            curve: AppMotion.easeOut,
          );

          return ClipRect(
            child: SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0, 1.05),
                end: Offset.zero,
              ).animate(curved),
              child: FadeTransition(opacity: curved, child: text),
            ),
          );
        }),
      ),
    );
  }
}
