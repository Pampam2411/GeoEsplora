import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geoesplora/theme/app_color.dart';
import 'package:geoesplora/viewmodels/bottom_nav_viewmodel.dart';
import 'package:geoesplora/widgets/buttons/custom_back_button.dart';
import 'package:geoesplora/widgets/navigations/custom_bottom_nav.dart';
import 'package:geoesplora/widgets/navigations/detaild_tab_bar.dart';
import 'package:geoesplora/widgets/buttons/favorite_button.dart';
import 'package:geoesplora/widgets/sections/geosite_map_preview.dart';
import 'package:geoesplora/widgets/sections/geosite_quick_info.dart';
import 'package:geoesplora/widgets/sections/geosite_review_sheet.dart';
import 'package:geoesplora/widgets/buttons/primary_button.dart';
import 'package:geoesplora/widgets/indicators/review_badge.dart';
import 'package:geoesplora/models/geosite.dart';
import 'package:geoesplora/widgets/texts/card_subtitle.dart';
import 'package:geoesplora/widgets/texts/card_title.dart';
import 'package:geoesplora/widgets/texts/detail_text.dart';
import 'package:geoesplora/widgets/texts/section_label.dart';

class GeositoDetailScreen extends ConsumerStatefulWidget {
  final Geosite geosite;

  const GeositoDetailScreen({super.key, required this.geosite});

  @override
  ConsumerState<GeositoDetailScreen> createState() =>
      _GeositoDetailScreenState();
}

class _GeositoDetailScreenState extends ConsumerState<GeositoDetailScreen> {
  int _selectedTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final currentIndex = ref.watch(bottomNavIndexProvider);
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
                  left: 46,
                  right: 46,
                  bottom: 80,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        child: CardTitle(
                          text: widget.geosite.name,
                          fontSize: 32,
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
                          FittedBox(
                            fit: BoxFit.scaleDown,
                            child: CardSubtitle(
                              text: widget.geosite.location,
                              fontSize: 14,
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
      bottomNavigationBar: CustomBottomNav(
        currentIndex: currentIndex,
        onTap: (index) {
          ref.read(bottomNavIndexProvider.notifier).state = index;
          Navigator.of(context).popUntil((route) => route.isFirst);
        },
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
            const SectionLabel(text: "Dettagli", fontSize: 14),

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

        DetailText(text: widget.geosite.description),

        const SizedBox(height: 10),

        // LINK LEGGI E ACCESSIBILITÀ
        Row(
          children: [
            GestureDetector(
              onTap: () => debugPrint("Espandi testo"),
              child: const SectionLabel(
                text: "Leggi di più",
                color: AppColors.secondary,
                fontSize: 10,
                decoration: TextDecoration.underline,
              ),
            ),
            const SizedBox(width: 20),
            GestureDetector(
              onTap: () => debugPrint("Apri accessibilità"),
              child: const SectionLabel(
                text: "Informazioni sull'accessibilità",
                color: AppColors.secondary,
                fontSize: 10,
                decoration: TextDecoration.underline,
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),

        const SectionLabel(text: "Immagini", fontSize: 14),

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

        const SizedBox(height: 20),
        // Mappa
        const GeositeMapPreview(),

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
          style: TextStyle(fontFamily: 'AxiformaBold', fontSize: 18),
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
