import 'package:flutter/material.dart';
import 'package:geoesplora/models/rock.dart';
import 'package:geoesplora/views/rock_detail_screen.dart';
import 'package:geoesplora/widgets/buttons/favorite_button.dart';
import 'package:geoesplora/widgets/texts/card_subtitle.dart';
import 'package:geoesplora/widgets/texts/card_title.dart';

class RockCard extends StatelessWidget {
  final Rock rock;
  final bool isFavorite;

  const RockCard({super.key, required this.rock, this.isFavorite = false});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => RockDetailScreen(rock: rock)),
        );
      },

      child: ClipRRect(
        borderRadius: BorderRadius.circular(22),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.network(
              rock.imageUrl,
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
                    Colors.black.withValues(alpha: 0.7),
                  ],
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(
                left: 13.0,
                bottom: 16.0,
                top: 12.0,
                right: 12.0,
              ),
              child: Stack(
                children: [
                  //TESTI
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CardTitle(text: rock.name, fontSize: 11),
                        CardSubtitle(text: rock.type, fontSize: 4),
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
