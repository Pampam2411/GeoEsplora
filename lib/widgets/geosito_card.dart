import 'package:flutter/material.dart';
import 'package:geoesplora/theme/app_color.dart';

class GeositoCard extends StatelessWidget {
  final String imageUrl, placeholder, location;

  const GeositoCard({
    super.key,
    required this.imageUrl,
    required this.placeholder,
    required this.location,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 165,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.white, width: 1),
        color: Colors.grey,
      ),

      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
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
              padding: EdgeInsets.all(16.0),
              child: Stack(
                children: [
                  Positioned(
                    bottom: 0,
                    left: 0,
                    child: Column(
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
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
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
