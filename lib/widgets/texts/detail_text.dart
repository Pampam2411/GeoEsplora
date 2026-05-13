import 'package:flutter/material.dart';
import 'package:geoesplora/theme/app_color.dart';

class DetailText extends StatelessWidget {
  final String text;
  final double size;
  final double lineHeight;
  final double letterSpacing;
  final Color color;

  const DetailText({
    super.key,
    required this.text,
    this.size = 13,
    this.letterSpacing = 0.2,
    this.lineHeight = 1.2,
    this.color = AppColors.secondary,
  });

  @override
  Widget build(Object context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: size,
        height: lineHeight,
        letterSpacing: letterSpacing,
        color: color,
        fontFamily: 'AxiformaLight',
      ),
    );
  }
}
