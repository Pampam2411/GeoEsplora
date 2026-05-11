// lib/views/rock_detail_screen.dart

import 'package:flutter/material.dart';
import 'package:geoesplora/models/rock.dart';
import 'package:geoesplora/theme/app_color.dart';
import 'package:geoesplora/widgets/custom_back_button.dart';
import 'package:geoesplora/widgets/favorite_button.dart';

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
                      vertical: 10.0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const CustomBackButton(),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              rock.name,
                              style: Theme.of(context).textTheme.titleMedium
                                  ?.copyWith(
                                    color: AppColors.background,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 48,
                                  ),
                            ),
                            Text(
                              rock.type,
                              style: Theme.of(context).textTheme.titleMedium
                                  ?.copyWith(
                                    color: AppColors.background,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 13,
                                  ),
                            ),
                          ],
                        ),

                        const FavoriteButton(
                          isInitiallyFavorite: false,
                          size: 36,
                        ),
                      ],
                    ),
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
                                  "MPa",
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 38.64),

                          // DESCRIZIONE
                          Text(
                            rock.description,
                            style: const TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w300,
                              color: AppColors.rockCardDetail,
                              height: 1.0,
                              fontFamily: 'Axiforma',
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
    );
  }

  Widget _buildInfo(String title, String value, String unit) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.transparent,

        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: value,
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: AppColors.rockCardDetail,
                    fontFamily: 'Axiforma',
                  ),
                ),

                TextSpan(
                  text: " $unit",
                  style: TextStyle(
                    fontSize: unit == '%' ? 15 : 11,
                    fontWeight: FontWeight.bold,
                    color: AppColors.rockCardDetail,
                    fontFamily: 'Axiforma',
                  ),
                ),
              ],
            ),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.visible,
          ),

          const SizedBox(height: 6),

          FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.center,
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.rockCardDetail,
                fontFamily: 'Axiforma',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
