import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geoesplora/theme/app_color.dart';
import 'package:geoesplora/widgets/favorite_button.dart';

class RockCard extends StatelessWidget {
  final String imageUrl, rockName, type;
  final bool isFavorite;

  const RockCard({
    super.key,
    required this.imageUrl,
    required this.rockName,
    required this.type,
    this.isFavorite = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 114,
      width: 114,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: AppColors.white, width: 1),
        color: AppColors.grey,
      ),

      child: ClipRRect(
        borderRadius: BorderRadius.circular(21),
        child: Stack(
          fit: StackFit.expand,
          children: [
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
                    Colors.black.withValues(
                      alpha: 0.7,
                    ), // Sfumatura leggermente più corta
                  ],
                ),
              ),
            ),

            Padding(
              // Questo padding spinge verso l'interno TUTTO ciò che c'è nello Stack sottostante
              padding: const EdgeInsets.only(
                left: 15.0,
                bottom: 16.0,
                top: 12.0, // Regola questo per allontanare il cuore dal tetto
                right: 12.0, // Regola questo per allontanare il cuore da destra
              ),
              child: Stack(
                children: [
                  // I TESTI (In basso a sinistra)
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          rockName,
                          style: const TextStyle(
                            color: AppColors.white,
                            fontSize: 11,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Text(
                          type,
                          style: const TextStyle(
                            color: AppColors.white,
                            fontSize: 7,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ],
                    ),
                  ),

                  Align(
                    alignment: Alignment.topRight,
                    child: FavoriteButton(isInitiallyFavorite: false, size: 24),
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
