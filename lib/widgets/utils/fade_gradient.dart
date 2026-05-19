import 'package:flutter/material.dart';

class FadeGradient extends StatelessWidget {
  final List<Color> colors;
  final List<double>? stops;
  final AlignmentGeometry begin;
  final AlignmentGeometry end;
  final double? height;
  final double? width;

  const FadeGradient({
    super.key,
    required this.colors,
    this.stops,
    this.begin = Alignment.topCenter,
    this.end = Alignment.bottomCenter,
    this.height,
    this.width,
  });

  factory FadeGradient.single({
    Key? key,
    required Color color,
    AlignmentGeometry begin = Alignment.topCenter,
    AlignmentGeometry end = Alignment.bottomCenter,
    double? height,
    double? width,
  }) {
    return FadeGradient(
      key: key,
      colors: [
        color,
        color.withValues(alpha: 0.60),
        color.withValues(alpha: 0.0),
      ],
      stops: const [0.0, 0.3, 1.0],
      begin: begin,
      end: end,
      height: height,
      width: width,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: IgnorePointer(
        child: DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: begin,
              end: end,
              colors: colors,
              stops: stops,
            ),
          ),
        ),
      ),
    );
  }
}
