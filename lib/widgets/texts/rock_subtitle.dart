import 'package:flutter/material.dart';
import 'package:geoesplora/theme/app_color.dart';

class RockSubtitle extends StatelessWidget {
  final String text;
  final Color color;
  final double fontSize, height, letterSpacing;
  final TextAlign textAlign;

  const RockSubtitle({
    super.key,
    required this.text,
    this.color = AppColors.titlePrimary,
    this.fontSize = 13,
    this.textAlign = TextAlign.center,
    this.height = 1.0,
    this.letterSpacing = 1.2,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      textAlign: textAlign,

      text,
      style: TextStyle(
        color: color,
        fontFamily: 'AxiformaBold',
        height: height,
        letterSpacing: letterSpacing,
        fontSize: fontSize,
      ),
    );
  }
}
