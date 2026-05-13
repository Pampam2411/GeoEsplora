import 'package:flutter/material.dart';
import 'package:geoesplora/models/geosite.dart';
import 'package:geoesplora/theme/app_color.dart';
import 'package:geoesplora/views/geosite_detail_screen.dart';
import 'package:geoesplora/widgets/buttons/favorite_button.dart';
import 'package:geoesplora/widgets/sections/geosite_review_sheet.dart';
import 'package:geoesplora/widgets/indicators/review_badge.dart';
import 'package:geoesplora/widgets/texts/card_subtitle.dart';
import 'package:geoesplora/widgets/texts/card_title.dart';

class GeositeCard extends StatelessWidget {
  final Geosite geosite;
  final bool isFavorite;

  const GeositeCard({
    super.key,
    required this.geosite,
    this.isFavorite = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => GeositoDetailScreen(geosite: geosite),
          ),
        );
      },

      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          fit: StackFit.expand,
          children: [
            //IMMAGINE CARD
            Image.network(
              geosite.imageUrl,
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
                left: 35.0,
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
                        CardSubtitle(text: geosite.location, fontSize: 10),

                        CardTitle(text: geosite.name, fontSize: 24),

                        ReviewBadge(
                          reviewCount: geosite.reviewCount,
                          rating: geosite.rating,
                          textColor: AppColors.surface,
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              backgroundColor: Colors.transparent,
                              builder: (context) =>
                                  GeositeReviewsSheet(geosite: geosite),
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
