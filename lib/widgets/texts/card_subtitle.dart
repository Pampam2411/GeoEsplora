import 'package:flutter/material.dart';
import 'package:geoesplora/theme/app_color.dart';

class CardSubtitle extends StatelessWidget {
  final String text;
  final Color color;
  final double fontSize;

  const CardSubtitle({
    super.key,
    required this.text,
    this.color = AppColors.titlePrimary,
    required this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: color,
        fontSize: fontSize,
        fontFamily: 'AxiformaLight',
        height: 0.5,
      ),
    );
  }
}
