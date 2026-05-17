import 'package:flutter/material.dart';
import 'package:geoesplora/theme/app_color.dart';

class RockCardCircle extends StatelessWidget {
  final String image;
  const RockCardCircle({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      width: 110,
      height: 110,
      decoration: BoxDecoration(
        color: AppColors.background,
        shape: BoxShape.circle,
      ),
      padding: const EdgeInsets.all(18),

      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: const BoxDecoration(shape: BoxShape.circle),
        child: image.startsWith('http')
            ? Image.network(
                image,
                fit: BoxFit.scaleDown,
                errorBuilder: (context, error, stackTrace) =>
                    const Icon(Icons.broken_image, color: Colors.grey),
              )
            : Image.asset(image, fit: BoxFit.cover),
      ),
    );
  }
}
