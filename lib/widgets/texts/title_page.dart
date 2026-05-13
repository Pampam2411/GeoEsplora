import 'package:flutter/material.dart';

class TitlePage extends StatelessWidget {
  final String title;
  final double size;

  const TitlePage({super.key, required this.title, this.size = 20});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        fontFamily: 'AxiformaRegular',
        fontSize: size,
        height: 1.0,
        letterSpacing: 0,
      ),
    );
  }
}
