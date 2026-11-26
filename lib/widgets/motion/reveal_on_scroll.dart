import 'dart:async';
import 'package:flutter/material.dart';
import '../../theme/app_motion.dart';

/// Memunculkan child sekali saat memasuki viewport dengan fade dan geser naik.
class RevealOnScroll extends StatefulWidget {
  final ScrollController scrollController;
  final Widget child;
  final Duration delay;
  final Duration duration;
  final double offsetY;
  final double triggerFraction;

  const RevealOnScroll({
    super.key,
    required this.scrollController,
    required this.child,
    this.delay = Duration.zero,
    this.duration = AppMotion.revealDuration,
    this.offsetY = AppMotion.revealOffsetY,
    this.triggerFraction = 0.90,
  });

  @override
  State<RevealOnScroll> createState() => _RevealOnScrollState();
}

class _RevealOnScrollState extends State<RevealOnScroll>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _opacity;
  late final Animation<double> _translateY;
  Timer? _delayTimer;
  bool _hasRevealed = false;
  bool _checkScheduled = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration);
    final curved = CurvedAnimation(
      parent: _controller,
      curve: AppMotion.easeOut,
    );
    _opacity = Tween<double>(begin: 0.0, end: 1.0).animate(curved);
    _translateY = Tween<double>(begin: widget.offsetY, end: 0.0).animate(curved);

    widget.scrollController.addListener(_scheduleCheck);
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
      _controller.value = 1.0;
      return;
    }

    final renderObject = context.findRenderObject();
    if (renderObject is! RenderBox || !renderObject.hasSize) return;

    final viewportHeight = MediaQuery.sizeOf(context).height;
    final top = renderObject.localToGlobal(Offset.zero).dy;
    final bottom = top + renderObject.size.height;

    if (top <= viewportHeight * widget.triggerFraction && bottom >= 0) {
      _hasRevealed = true;
      widget.scrollController.removeListener(_scheduleCheck);
      if (widget.delay == Duration.zero) {
        _controller.forward();
      } else {
        _delayTimer = Timer(widget.delay, () {
          if (mounted) _controller.forward();
        });
      }
    }
  }

  @override
  void dispose() {
    widget.scrollController.removeListener(_scheduleCheck);
    _delayTimer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (MediaQuery.disableAnimationsOf(context)) {
      return widget.child;
    }

    return RepaintBoundary(
      child: AnimatedBuilder(
        animation: _controller,
        child: widget.child,
        builder: (context, child) {
          return Opacity(
            opacity: _opacity.value,
            child: Transform.translate(
              offset: Offset(0, _translateY.value),
              child: child,
            ),
          );
        },
      ),
    );
  }
}
