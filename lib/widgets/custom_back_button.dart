import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geoesplora/theme/app_color.dart';

class CustomBackButton extends StatelessWidget {
  final bool hasBackground;
  final VoidCallback? onPressed;
  final double size;

  const CustomBackButton({
    super.key,
    this.hasBackground = true,
    this.onPressed,
    this.size = 36,
  });

  @override
  Widget build(BuildContext context) {
    Widget icon = FaIcon(
      FontAwesomeIcons.chevronLeft,
      color: AppColors.secondary,
      size: hasBackground ? size * 0.5 : 20,
    );

    if (!hasBackground) {
      return IconButton(
        padding: EdgeInsets.zero,
        onPressed: onPressed ?? () => Navigator.of(context).pop(),
        icon: icon,
      );
    }

    return Container(
      width: size,
      height: size,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.surface,
      ),
      child: IconButton(
        padding: EdgeInsets.zero,
        onPressed: onPressed ?? () => Navigator.of(context).pop(),
        icon: icon,
      ),
    );
  }
}
