import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:geoesplora/models/geosite.dart';
import 'package:geoesplora/theme/app_color.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class GeositeReviewsSheet extends StatelessWidget {
  final Geosite geosite;

  const GeositeReviewsSheet({super.key, required this.geosite});

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.7,
      minChildSize: 0.4,
      maxChildSize: 0.95,
      expand: false,
      builder: (context, scrollController) {
        return Container(
          decoration: const BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
          ),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(vertical: 12),
                height: 4,
                width: 106,
                decoration: BoxDecoration(
                  color: AppColors.borderLight,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),

              const SizedBox(height: 15),

              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 35.0,
                  vertical: 10,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      geosite.name,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.bold,
                        fontSize: 32,
                        letterSpacing: 0.2,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const FaIcon(
                          FontAwesomeIcons.locationDot,
                          size: 16,
                          color: AppColors.textPrimary,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          geosite.location,
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(
                                color: AppColors.textPrimary,
                                fontFamily: 'Axiforma',
                                fontWeight: FontWeight.w300,
                                fontSize: 24,
                                letterSpacing: 0.2,
                              ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Recensioni",
                          style: Theme.of(context).textTheme.titleSmall
                              ?.copyWith(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.2,
                                color: AppColors.textPrimary,
                              ),
                        ),
                        GestureDetector(
                          onTap: () {
                            debugPrint("Apri filtri recensioni");
                          },
                          child: FaIcon(
                            FontAwesomeIcons.sliders,
                            color: AppColors.textPrimary,
                            size: 14,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Lista delle recensioni
              Expanded(
                child: ListView.builder(
                  controller: scrollController,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemCount: 5, // Numero di recensioni (placeholder)
                  itemBuilder: (context, index) {
                    return _buildReviewItem();
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildReviewItem() {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 32.0,
      ), // Spazio maggiore tra le recensioni
      child: Row(
        crossAxisAlignment:
            CrossAxisAlignment.start, // Allinea l'avatar in alto
        children: [
          // AVATAR UTENTE
          const CircleAvatar(
            radius: 20,
            backgroundColor: Colors.transparent,
            child: FaIcon(
              FontAwesomeIcons.circleUser,

              size: 33,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(width: 16),

          // CONTENUTO RECENSIONE
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque ultrices lorem in nunc maximus semper.",
                  style: TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 11,
                    height: 1.2,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Axiforma',
                  ),
                ),
                const SizedBox(height: 8),

                Row(
                  children: [
                    const Text(
                      "Giuseppe De Marco",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 11,
                        fontFamily: 'Axiforma',
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    const SizedBox(width: 12),
                    FaIcon(FontAwesomeIcons.star, size: 14, color: Colors.grey),
                    const Text(
                      " 4.8",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 12),
                    const Text(
                      "11:36 25/02/2026",
                      style: TextStyle(color: Colors.grey, fontSize: 11),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
