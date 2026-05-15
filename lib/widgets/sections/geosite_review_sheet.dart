import 'package:flutter/material.dart';
import 'package:geoesplora/models/geosite.dart';
import 'package:geoesplora/theme/app_color.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geoesplora/widgets/texts/detail_text.dart';
import 'package:geoesplora/widgets/texts/section_label.dart';

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
                    SectionLabel(text: geosite.name, fontSize: 32),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const FaIcon(
                          FontAwesomeIcons.locationDot,
                          size: 16,
                          color: AppColors.textPrimary,
                        ),
                        const SizedBox(width: 8),
                        DetailText(
                          text: geosite.location,
                          color: AppColors.textPrimary,
                          size: 24,
                          letterSpacing: 0.2,
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SectionLabel(text: "Recensioni", fontSize: 14),
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
                  itemCount: 5,
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
      padding: const EdgeInsets.only(bottom: 32.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
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
                const DetailText(
                  text:
                      "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque ultrices lorem in nunc maximus semper.",

                  color: AppColors.textPrimary,
                  size: 11,
                  lineHeight: 1.2,
                ),
                const SizedBox(height: 8),

                Row(
                  children: [
                    const DetailText(
                      text: "Giuseppe De Marco",

                      color: Colors.grey,
                      size: 11,
                    ),
                    const SizedBox(width: 12),
                    FaIcon(FontAwesomeIcons.star, size: 14, color: Colors.grey),
                    const DetailText(
                      text: " 4.8",

                      color: Colors.grey,
                      size: 11,
                    ),
                    const SizedBox(width: 12),
                    const DetailText(
                      text: "11:36 25/02/2026",

                      color: Colors.grey,
                      size: 11,
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
