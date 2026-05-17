import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geoesplora/models/geosite.dart';
import 'package:geoesplora/theme/app_color.dart';
import 'package:geoesplora/widgets/texts/detail_text.dart';
import 'package:geoesplora/widgets/texts/section_label.dart';

class GeositeAccesibilitySheet extends StatelessWidget {
  final Geosite geosite;

  const GeositeAccesibilitySheet({super.key, required this.geosite});
  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.6,
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
                    const SizedBox(height: 14),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SectionLabel(text: "Accessibilità", fontSize: 14),
                      ],
                    ),

                    const SizedBox(height: 14),

                    _buildInfo('Fondo', geosite.surface),
                    _buildInfo('Percorso', geosite.route),
                    _buildInfo('Pendenza', geosite.slope),
                    _buildInfo('Gradini', geosite.steps),
                    _buildInfo('Carrozzina', geosite.wheelchair),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildInfo(String type, String description) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SectionLabel(text: "$type: ", fontSize: 13, color: AppColors.secondary),
        DetailText(text: description, color: AppColors.secondary),
      ],
    );
  }
}
