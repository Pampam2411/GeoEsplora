import 'package:flutter/material.dart';
import 'package:geoesplora/theme/app_color.dart';

class RockTitle extends StatelessWidget {
  final String text;
  final Color color;
  final double fontSize;
  final TextAlign textAlign;

  const RockTitle({
    super.key,
    required this.text,
    this.color = AppColors.titlePrimary,
    this.fontSize = 48,
    this.textAlign = TextAlign.center,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      textAlign: textAlign,

      text,
      style: TextStyle(
        color: color,
        fontFamily: 'AxiformaBlack',
        height: 1.0,
        fontSize: fontSize,
      ),
    );
  }
}
