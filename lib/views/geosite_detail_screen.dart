import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geoesplora/theme/app_color.dart';
import 'package:geoesplora/widgets/detaild_tab_bar.dart';
import 'package:geoesplora/widgets/favorite_button.dart';
import 'package:geoesplora/widgets/geosite_map_preview.dart';
import 'package:geoesplora/widgets/geosite_quick_info.dart';
import 'package:geoesplora/widgets/primary_button.dart';
import 'package:geoesplora/widgets/review_badge.dart';

class GeositoDetailScreen extends StatefulWidget {
  const GeositoDetailScreen({super.key});

  @override
  State<GeositoDetailScreen> createState() => _GeositoDetailScreenState();
}

class _GeositoDetailScreenState extends State<GeositoDetailScreen> {
  int _selectedTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppColors.white,
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: screenHeight * 0.35,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.network(
                  'https://images.unsplash.com/photo-1464822759023-fed622ff2c3b', // Placeholder
                  fit: BoxFit.cover,
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
                Padding(
                  padding: EdgeInsets.only(
                    left: 30.0,
                    bottom: 30.0,
                    top: 16,
                    right: 16,
                  ),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: FavoriteButton(isInitiallyFavorite: false, size: 36),
                  ),
                ),

                Positioned(
                  left: 20,
                  bottom: 60,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Placeholder',
                        style: TextStyle(
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
                          const Text(
                            'Cosenza, Calabria',
                            style: TextStyle(
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

          Positioned(
            top: screenHeight * 0.32,
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DetailTabBar(
                    selectedIndex: _selectedTabIndex,
                    onTabChanged: (index) {
                      setState(() {
                        _selectedTabIndex = index;
                      });
                    },
                  ),

                  Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.only(
                          top: 20.0,
                          left: 20.0,
                          right: 20.0,
                          bottom: 40.0,
                        ),
                        child: _selectedTabIndex == 0
                            ? _buildDettagliNormali()
                            : _buildDettagliScientifici(),
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

  Widget _buildDettagliNormali() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const GeositeQuickInfo(
          durata: '3 ore',
          distanza: '1km',
          prezzo: '€€€',
          rating: 4.8,
        ),

        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
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
              reviewCount: 143,
              textColor: AppColors.secondary,
              isUnderlined: true,
              onTap: () {
                debugPrint("Apri modale recensioni dalla Pagina Dettaglio");
              },
            ),
          ],
        ),

        const SizedBox(height: 10),

        Text(
          "Lorem ipsum dolor sit ....",
          style: TextStyle(
            color: AppColors.secondary,
            fontWeight: FontWeight.w400,
            fontSize: 13,
          ),
        ),

        const SizedBox(height: 10),
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
        const SizedBox(height: 10),

        const GeositeMapPreview(),

        const SizedBox(height: 10),

        //IMMAGINI
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

        const SizedBox(height: 10),
        //PULSANTE PIANIFICA VISITA
        PrimaryButton(text: "Pianifica Visita", onPressed: _pulsantePianifica),
      ],
    );
  }

  Widget _buildDettagliScientifici() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Dati Tecnici",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        const SizedBox(height: 10),
        Text(
          "Qui andranno le ere geologiche, tipo di roccia,ecc...",
          style: TextStyle(color: AppColors.grey),
        ),
      ],
    );
  }

  void _pulsantePianifica() {
    debugPrint("Premuto pulsante pianifica visita");
  }
}
