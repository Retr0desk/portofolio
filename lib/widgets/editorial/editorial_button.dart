import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_motion.dart';
import '../../theme/app_radius.dart';
import '../../theme/app_spacing.dart';
import '../../theme/app_typography.dart';

/// Tombol editorial dengan varian utama (champagne) dan sekunder (garis tipis).
class EditorialButton extends StatefulWidget {
  final String label;
  final IconData? icon;
  final VoidCallback? onPressed;
  final bool isPrimary;

  const EditorialButton({
    super.key,
    required this.label,
    this.icon,
    this.onPressed,
    this.isPrimary = false,
  });

  @override
  State<EditorialButton> createState() => _EditorialButtonState();
}

class _EditorialButtonState extends State<EditorialButton> {
  bool _hovered = false;
  bool _focused = false;

  @override
  Widget build(BuildContext context) {
    final isInteractive = widget.onPressed != null;
    final bgColor = widget.isPrimary
        ? (_hovered ? AppColors.champagneBright : AppColors.champagne)
        : (_hovered ? AppColors.surfaceElevated : Colors.transparent);

    final fgColor = widget.isPrimary
        ? AppColors.onChampagne
        : (_hovered ? AppColors.champagneBright : AppColors.textPrimary);

    final borderColor = widget.isPrimary
        ? Colors.transparent
        : ((_hovered || _focused)
              ? AppColors.borderChampagneStrong
              : AppColors.borderChampagne);

    return Semantics(
      button: true,
      enabled: isInteractive,
      label: widget.label,
      child: MouseRegion(
        cursor: isInteractive
            ? SystemMouseCursors.click
            : SystemMouseCursors.basic,
        onEnter: (_) => setState(() => _hovered = true),
        onExit: (_) => setState(() => _hovered = false),
        child: FocusableActionDetector(
          onShowFocusHighlight: (val) => setState(() => _focused = val),
          child: InkWell(
            onTap: widget.onPressed,
            borderRadius: AppRadius.control,
            child: AnimatedContainer(
              duration: AppMotion.hoverDuration,
              curve: AppMotion.easeOut,
              constraints: const BoxConstraints(
                minHeight: AppSpacing.minTapTarget,
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.lg,
                vertical: AppSpacing.sm,
              ),
              decoration: BoxDecoration(
                color: bgColor,
                borderRadius: AppRadius.control,
                border: Border.all(
                  color: _focused ? AppColors.champagne : borderColor,
                  width: _focused ? 1.5 : 1,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (widget.icon != null) ...[
                    Icon(widget.icon, size: 16, color: fgColor),
                    const SizedBox(width: AppSpacing.xs),
                  ],
                  Text(
                    widget.label,
                    style: AppTypography.buttonLabel(color: fgColor),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
