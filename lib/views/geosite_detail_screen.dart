import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geoesplora/theme/app_color.dart';
import 'package:geoesplora/widgets/custom_back_button.dart';
import 'package:geoesplora/widgets/detaild_tab_bar.dart';
import 'package:geoesplora/widgets/favorite_button.dart';
import 'package:geoesplora/widgets/geosite_map_preview.dart';
import 'package:geoesplora/widgets/geosite_quick_info.dart';
import 'package:geoesplora/widgets/geosite_review_sheet.dart';
import 'package:geoesplora/widgets/primary_button.dart';
import 'package:geoesplora/widgets/review_badge.dart';
import 'package:geoesplora/models/geosite.dart';

class GeositoDetailScreen extends StatefulWidget {
  final Geosite geosite;

  const GeositoDetailScreen({super.key, required this.geosite});

  @override
  State<GeositoDetailScreen> createState() => _GeositoDetailScreenState();
}

class _GeositoDetailScreenState extends State<GeositoDetailScreen> {
  int _selectedTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          // 1. IMMAGINE E HEADER
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: screenHeight * 0.38,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.network(
                  widget.geosite.imageUrl,
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
                        Colors.black.withValues(alpha: 0.4),
                        Colors.transparent,
                        Colors.black.withValues(alpha: 0.8),
                      ],
                      stops: const [0.0, 0.5, 1.0],
                    ),
                  ),
                ),

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
                        const FavoriteButton(
                          isInitiallyFavorite: false,
                          size: 36,
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  left: 20,
                  bottom: 70,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.geosite.name,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          const FaIcon(
                            FontAwesomeIcons.locationDot,
                            color: Colors.white,
                            size: 16,
                          ),
                          const SizedBox(width: 5),
                          Text(
                            widget.geosite.location,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          //TAB BAR E CONTENUTI
          Positioned(
            top: screenHeight * 0.33,
            left: 0,
            right: 0,
            bottom: 0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Le tab arrotondate
                DetailTabBar(
                  selectedIndex: _selectedTabIndex,
                  onTabChanged: (index) {
                    setState(() {
                      _selectedTabIndex = index;
                    });
                  },
                ),
                Expanded(
                  child: Container(
                    color: AppColors.secondary,
                    width: double.infinity,
                    child: Container(
                      decoration: BoxDecoration(color: AppColors.surface),
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.only(
                          top: 22.0,
                          left: 49.0,
                          right: 49.0,
                          bottom: 40.0,
                        ),
                        child: _selectedTabIndex == 0
                            ? _buildDettagliNormali()
                            : _buildDettagliScientifici(),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // DETTAGLI NORMALI
  Widget _buildDettagliNormali() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Badge rapidi (Durata, distanza, ecc.)
        GeositeQuickInfo(
          durata: widget.geosite.duration,
          distanza: widget.geosite.distance,
          prezzo: widget.geosite.price,
          rating: widget.geosite.rating,
        ),
        const SizedBox(height: 10),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Dettagli",
              style: TextStyle(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            ReviewBadge(
              reviewCount: widget.geosite.reviewCount,
              textColor: AppColors.secondary,
              isUnderlined: true,
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  builder: (context) =>
                      GeositeReviewsSheet(geosite: widget.geosite),
                );
              },
            ),
          ],
        ),
        const SizedBox(height: 10),

        Text(
          widget.geosite.description,
          style: const TextStyle(
            color: AppColors.secondary,
            fontWeight: FontWeight.w400,
            fontSize: 13,
          ),
        ),
        const SizedBox(height: 10),

        // LINK LEGGI E ACCESSIBILITÀ
        Row(
          children: [
            GestureDetector(
              onTap: () => debugPrint("Espandi testo"),
              child: const Text(
                "Leggi di più",
                style: TextStyle(
                  color: AppColors.secondary,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
            const SizedBox(width: 20),
            GestureDetector(
              onTap: () => debugPrint("Apri accessibilità"),
              child: const Text(
                "Informazioni sull'accessibilità",
                style: TextStyle(
                  color: AppColors.secondary,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),

        // Mappa
        const GeositeMapPreview(),
        const SizedBox(height: 20),

        const Text(
          "Immagini",
          style: TextStyle(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 100,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 4,
            itemBuilder: (context, index) {
              return Container(
                width: 140,
                margin: const EdgeInsets.only(right: 15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.grey.shade300,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.network(
                    'https://images.unsplash.com/photo-1542224566-6e85f2e6772f',
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 30),

        // Bottone finale
        PrimaryButton(
          text: "Pianifica Visita",
          onPressed: () => debugPrint("Premuto Pianifica Visita"),
          icon: FontAwesomeIcons.locationArrow,
        ),
      ],
    );
  }

  //DETTAGLI SCIENTIFICI
  Widget _buildDettagliScientifici() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Dati Tecnici",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        const SizedBox(height: 10),
        const Text(
          "Qui andranno le ere geologiche, ecc...",
          style: TextStyle(color: AppColors.textSecondary),
        ),
        const SizedBox(height: 30),
        // Bottone finale anche in questa tab
        PrimaryButton(
          text: "Pianifica Visita",
          onPressed: () => debugPrint("Premuto Pianifica Visita"),
          icon: FontAwesomeIcons.locationArrow,
        ),
      ],
    );
  }
}
