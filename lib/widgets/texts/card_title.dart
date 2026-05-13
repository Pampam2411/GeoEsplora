import 'package:flutter/material.dart';
import 'package:geoesplora/theme/app_color.dart';

class CardTitle extends StatelessWidget {
  final String text;
  final Color color;
  final double fontSize;

  const CardTitle({
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
        fontFamily: 'AxiformaBold',
        fontSize: fontSize,
        height: 1.2,
      ),
    );
  }
}
