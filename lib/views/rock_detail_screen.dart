import 'package:flutter/material.dart';
import 'package:geoesplora/models/rock.dart';
import 'package:geoesplora/theme/app_color.dart';
import 'package:geoesplora/widgets/buttons/custom_back_button.dart';
import 'package:geoesplora/widgets/navigations/custom_bottom_nav.dart';
import 'package:geoesplora/widgets/buttons/favorite_button.dart';
import 'package:geoesplora/widgets/texts/rock_subtitle.dart';
import 'package:geoesplora/widgets/texts/rock_title.dart';

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

                // Pulsanti Indietro e Preferiti
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 8.0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FittedBox(
                          fit: BoxFit.scaleDown,
                          child: const CustomBackButton(),
                        ),

                        FittedBox(
                          fit: BoxFit.scaleDown,
                          child: const FavoriteButton(
                            isInitiallyFavorite: false,
                            size: 36,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  left: 44,
                  right: 44,
                  top: 80,
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
                          Text(
                            rock.description,
                            style: const TextStyle(
                              fontSize: 13,
                              color: AppColors.rockCardDetail,
                              height: 1.0,
                              fontFamily: 'AxiformaLight',
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            "Riconoscimenti",
                            style: TextStyle(
                              fontFamily: 'AxiformaBold',
                              fontSize: 14,
                              height: 1.0,
                              letterSpacing: 0.2,
                            ),
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
      bottomNavigationBar: CustomBottomNav(),
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
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 32,
                    color: AppColors.rockCardDetail,
                    fontFamily: 'AxiformaBlack',
                  ),
                ),

                const SizedBox(width: 4),
                unit == "g/cm^3"
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            "g",
                            style: TextStyle(
                              fontFamily: 'AxiformaLight',
                              fontSize: 10,
                              color: AppColors.rockCardDetail,
                              height: 1.0,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            "cm³",
                            style: TextStyle(
                              fontFamily: 'AxiformaLight',
                              fontSize: 10,
                              color: AppColors.rockCardDetail,
                              height: 1.0,
                            ),
                          ),
                        ],
                      )
                    : Padding(
                        padding: const EdgeInsets.only(bottom: 4.0),
                        child: Text(
                          unit,
                          style: TextStyle(
                            fontSize: unit == '%' ? 20 : 13,
                            color: AppColors.rockCardDetail,
                            fontFamily: 'AxiformaLight',
                          ),
                        ),
                      ),
              ],
            ),
          ),
          FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.center,
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                color: AppColors.rockCardDetail,
                fontFamily: 'AxiformaBlack',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
