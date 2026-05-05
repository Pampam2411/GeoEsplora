import 'package:flutter/material.dart';
import 'package:geoesplora/theme/app_color.dart';
import 'package:geoesplora/widgets/favorite_button.dart';
import 'package:geoesplora/widgets/review_badge.dart';

class GeositeCard extends StatelessWidget {
  final String imageUrl, placeholder, location;
  final bool isFavorite;
  final double rating;
  final int reviewCount;

  const GeositeCard({
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
        border: Border.all(color: AppColors.surface, width: 1),
        color: AppColors.textSecondary,
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
                child: Icon(
                  Icons.image_not_supported,
                  color: AppColors.textSecondary,
                ),
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
                    Colors.black.withValues(alpha: 0.8),
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
                            color: AppColors.surface,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        ReviewBadge(
                          reviewCount: reviewCount,
                          rating: rating,
                          textColor: AppColors.surface,
                          onTap: () {
                            debugPrint(
                              'premuto recensioni per $placeholder dalla Card',
                            );
                          },
                        ),

                        const SizedBox(height: 6),
                      ],
                    ),
                  ),

                  //PULSANTE PREFERITO
                  Align(
                    alignment: Alignment.topRight,
                    child: FavoriteButton(isInitiallyFavorite: false, size: 36),
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
