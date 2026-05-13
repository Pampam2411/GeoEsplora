import 'package:flutter/material.dart';
import 'package:geoesplora/theme/app_color.dart';

class SectionLabel extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color color;
  final TextDecoration decoration;

  const SectionLabel({
    super.key,
    required this.text,
    required this.fontSize,
    this.color = AppColors.textPrimary,
    this.decoration = TextDecoration.none,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontFamily: 'AxiformaBold',
        fontSize: fontSize,
        color: color,
        decoration: decoration,
      ),
    );
  }
}
