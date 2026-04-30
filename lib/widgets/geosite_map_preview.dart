import 'package:flutter/material.dart';
import 'package:geoesplora/theme/app_color.dart';

class GeositeMapPreview extends StatelessWidget {
  const GeositeMapPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Mappa",
          style: TextStyle(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 10),

        GestureDetector(
          onTap: () {
            debugPrint(
              "Apertura mappa a schermo intero o avvio navigazione...",
            );
          },
          child: Container(
            height: 160, // Altezza fissa per il pezzetto di mappa
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.grey.shade200,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    'https://images.unsplash.com/photo-1524661135-423995f22d0b',
                    fit: BoxFit.cover,
                  ),

                  Container(color: Colors.black.withValues(alpha: 0.2)),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
