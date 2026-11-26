import 'package:flutter/material.dart';
import '../../theme/app_motion.dart';

/// Memberikan efek parallax vertikal ringan berbasis Transform tanpa mengubah layout.
class ParallaxImage extends StatelessWidget {
  final ScrollController scrollController;
  final Widget child;
  final double maxFactor;
  final BorderRadius borderRadius;

  const ParallaxImage({
    super.key,
    required this.scrollController,
    required this.child,
    this.maxFactor = AppMotion.parallaxMaxFactor,
    this.borderRadius = BorderRadius.zero,
  });

  @override
  Widget build(BuildContext context) {
    if (MediaQuery.disableAnimationsOf(context)) {
      return ClipRRect(borderRadius: borderRadius, child: child);
    }

    return ClipRRect(
      borderRadius: borderRadius,
      child: RepaintBoundary(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return AnimatedBuilder(
              animation: scrollController,
              child: child,
              builder: (context, innerChild) {
                final renderObject = context.findRenderObject();
                double offsetY = 0;

                if (renderObject is RenderBox && renderObject.hasSize) {
                  final viewportHeight = MediaQuery.sizeOf(context).height;
                  final boxCenterY =
                      renderObject.localToGlobal(Offset.zero).dy +
                      renderObject.size.height / 2;
                  final normalized =
                      ((boxCenterY - viewportHeight / 2) /
                              (viewportHeight / 2))
                          .clamp(-1.0, 1.0);
                  offsetY = -normalized * renderObject.size.height * maxFactor;
                }

                return Transform.scale(
                  scale: 1 + (maxFactor * 2),
                  child: Transform.translate(
                    offset: Offset(0, offsetY),
                    child: innerChild,
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
