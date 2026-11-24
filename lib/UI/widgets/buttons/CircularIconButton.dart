import 'package:flutter/material.dart';

import '../../aspects/AppColors.dart';

class CircularIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onPressed;
  final double size;
  final double iconSize;
  final Color? backgroundColor;
  final Color? iconColor;
  final String? tooltip;

  const CircularIconButton({
    super.key,
    required this.icon,
    required this.onPressed,
    this.size = 50,
    this.iconSize = 22,
    this.backgroundColor,
    this.iconColor,
    this.tooltip,
  });

  @override
  Widget build(BuildContext context) {
    final Color resolvedBackground = backgroundColor ?? AppColors.accentPill;
    final Color resolvedIconColor = iconColor ?? AppColors.slateNavy;

    final Widget button = Material(
      color: resolvedBackground,
      shape: const CircleBorder(),
      elevation: 0,
      child: InkWell(
        onTap: onPressed,
        customBorder: const CircleBorder(),
        child: SizedBox(
          width: size,
          height: size,
          child: Center(
            child: Icon(
              icon,
              size: iconSize,
              color: resolvedIconColor,
            ),
          ),
        ),
      ),
    );

    if (tooltip != null && tooltip!.isNotEmpty) {
      return Tooltip(
        message: tooltip!,
        child: button,
      );
    }

    return button;
  }
}
