import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geoesplora/theme/app_color.dart';

class GeositoCard extends StatelessWidget {
  final String imageUrl, placeholder, location;
  final bool isFavorite;
  final double rating;
  final int reviewCount;

  const GeositoCard({
    super.key,
    required this.imageUrl,
    required this.placeholder,
    required this.location,
    this.isFavorite = false,
    required this.rating,
    required this.reviewCount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 165,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.white, width: 1),
        color: Colors.grey,
      ),

      child: ClipRRect(
        borderRadius: BorderRadius.circular(19),
        child: Stack(
          fit: StackFit.expand,
          children: [
            //IMMAGINE CARD
            Image.network(
              imageUrl,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => const Center(
                child: Icon(Icons.image_not_supported, color: Colors.grey),
              ),
            ),

            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withValues(alpha: 0.1),
                    Colors.black.withValues(alpha: 0.8), // Scuro in basso
                  ],
                  stops: const [0.0, 0.5, 1.0],
                ),
              ),
            ),

            Padding(
              padding: EdgeInsets.only(
                left: 30.0,
                bottom: 30.0,
                top: 16,
                right: 16,
              ),
              child: Stack(
                children: [
                  //TESTO PLACEHOLDER E LOCATION
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          location,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                        ),

                        Text(
                          placeholder,
                          style: TextStyle(
                            color: AppColors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 6),

                        GestureDetector(
                          onTap: () {
                            debugPrint('premuto recensioni per $placeholder');
                          },
                          behavior: HitTestBehavior.opaque,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 6,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: AppColors.background,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.star_border,
                                      color: AppColors.white,
                                      size: 12,
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      rating.toStringAsFixed(1),
                                      style: const TextStyle(
                                        color: AppColors.white,
                                        fontSize: 11,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 8),

                              Text(
                                '$reviewCount recensini',
                                style: const TextStyle(
                                  color: AppColors.white,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  //PULSANTE PREFERITO
                  Align(
                    alignment: Alignment.topRight,
                    child: Container(
                      width: 32.8,
                      height: 32.8,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.background,
                      ),

                      child: IconButton(
                        padding: EdgeInsets.zero,
                        onPressed: () {
                          debugPrint('premuto pulsante favorito <3');
                        },
                        icon: const Icon(
                          Icons.favorite_border,
                          color: AppColors.secondary,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
