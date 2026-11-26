import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';

/// Garis tipis champagne di sisi atas layar yang menunjukkan progres scroll.
class ScrollProgressBar extends StatelessWidget {
  final ScrollController scrollController;

  const ScrollProgressBar({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: SizedBox(
        height: 2,
        width: double.infinity,
        child: AnimatedBuilder(
          animation: scrollController,
          builder: (context, _) {
            double progress = 0.0;
            if (scrollController.hasClients &&
                scrollController.position.hasContentDimensions) {
              final maxExtent = scrollController.position.maxScrollExtent;
              if (maxExtent > 0) {
                progress = (scrollController.offset / maxExtent).clamp(
                  0.0,
                  1.0,
                );
              }
            }

            return Align(
              alignment: Alignment.centerLeft,
              child: FractionallySizedBox(
                widthFactor: progress,
                child: Container(height: 2, color: AppColors.champagne),
              ),
            );
          },
        ),
      ),
    );
  }
}
