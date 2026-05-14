import 'package:flutter/material.dart';
import 'package:geoesplora/theme/app_color.dart';
import 'package:geoesplora/widgets/texts/detail_text.dart';

class HorizontalImageList extends StatelessWidget {
  final List<String>? images;
  final double height;
  final double imageWidth;
  final String warningMessage;

  const HorizontalImageList({
    super.key,
    this.images,
    this.height = 80,
    this.imageWidth = 130,
    required this.warningMessage,
  });

  @override
  Widget build(BuildContext context) {
    if (images == null || images!.isEmpty) {
      return Center(
        child: Padding(
          padding: EdgeInsets.only(top: 20),
          child: DetailText(
            text: warningMessage,
            color: AppColors.textPrimary,
            size: 10,
          ),
        ),
      );
    }

    return SizedBox(
      height: height,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: images!.length,
        itemBuilder: (context, index) {
          final imagePath = images![index];
          return Container(
            width: imageWidth,
            margin: const EdgeInsets.only(right: 15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.grey.shade300,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: imagePath.startsWith('http')
                  ? Image.network(
                      imagePath,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                          const Icon(Icons.broken_image, color: Colors.grey),
                    )
                  : Image.asset(imagePath, fit: BoxFit.cover),
            ),
          );
        },
      ),
    );
  }
}
