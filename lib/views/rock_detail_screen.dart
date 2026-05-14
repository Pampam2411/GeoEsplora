import 'package:flutter/material.dart';
import 'package:geoesplora/models/rock.dart';
import 'package:geoesplora/theme/app_color.dart';
import 'package:geoesplora/widgets/navigations/back_favorite_button.dart';
import 'package:geoesplora/widgets/sections/horizontal_image_list.dart';
import 'package:geoesplora/widgets/texts/detail_text.dart';
import 'package:geoesplora/widgets/texts/rock_subtitle.dart';
import 'package:geoesplora/widgets/texts/rock_title.dart';
import 'package:geoesplora/widgets/texts/section_label.dart';

class RockDetailScreen extends StatelessWidget {
  final Rock rock;

  const RockDetailScreen({super.key, required this.rock});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          // 1. IMMAGINE E HEADER IN ALTO
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: screenHeight * 0.45,
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
                      end: Alignment.center,
                      colors: [
                        Colors.black.withValues(alpha: 0.5),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),

                const BackFavoriteButton(),

                Positioned(
                  left: 44,
                  right: 44,
                  top: 90,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        child: RockTitle(text: rock.name.toUpperCase()),
                      ),

                      RockSubtitle(
                        textAlign: TextAlign.center,
                        text: rock.type,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // 2. PANNELLO DETTAGLI BIANCO
          Positioned(
            top: screenHeight * 0.42,
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              decoration: const BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
              ),
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(horizontal: 35.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 20),
                          // RIGA INFO
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Expanded(
                                child: _buildInfo(
                                  "Densitá",
                                  rock.density % 1 == 0
                                      ? rock.density.toInt().toString()
                                      : rock.density.toString(),
                                  "g/cm^3",
                                ),
                              ),
                              Expanded(
                                child: _buildInfo(
                                  "Porositá",
                                  rock.porosity % 1 == 0
                                      ? rock.porosity.toInt().toString()
                                      : rock.porosity.toString(),
                                  "%",
                                ),
                              ),
                              Expanded(
                                child: _buildInfo(
                                  "Resistenza",
                                  rock.resistence % 1 == 0
                                      ? rock.resistence.toInt().toString()
                                      : rock.resistence.toString(),
                                  "MPA",
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 16),

                          // DESCRIZIONE
                          DetailText(
                            text: rock.description,
                            size: 13,
                            color: AppColors.rockCardDetail,
                            lineHeight: 1.0,
                          ),
                          const SizedBox(height: 16),

                          SectionLabel(text: "Riconoscimenti", fontSize: 14),

                          HorizontalImageList(
                            images: rock.recognitionImages ?? [],
                            warningMessage:
                                "Non sono presenti foto per questa roccia",
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfo(String title, String value, String unit) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerLeft,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RockTitle(
                  text: value,
                  fontSize: 32,
                  color: AppColors.rockCardDetail,
                ),

                const SizedBox(width: 4),
                unit == "g/cm^3"
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          DetailText(
                            text: "g",
                            size: 10,
                            color: AppColors.rockCardDetail,
                            lineHeight: 1.0,
                          ),
                          SizedBox(height: 4),
                          DetailText(
                            text: "cm³",
                            size: 10,
                            color: AppColors.rockCardDetail,
                            lineHeight: 1.0,
                          ),
                        ],
                      )
                    : Padding(
                        padding: const EdgeInsets.only(bottom: 4.0),
                        child: DetailText(
                          text: unit,
                          size: unit == '%' ? 20 : 13,
                          color: AppColors.rockCardDetail,
                        ),
                      ),
              ],
            ),
          ),
          FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.center,
            child: RockTitle(
              text: title,
              fontSize: 16,
              color: AppColors.rockCardDetail,
            ),
          ),
        ],
      ),
    );
  }
}
