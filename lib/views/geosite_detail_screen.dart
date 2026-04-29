import 'package:flutter/material.dart';
import 'package:geoesplora/theme/app_color.dart';
import 'package:geoesplora/widgets/detaild_tab_bar.dart';

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
            height: screenHeight * 0.45,
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
              ],
            ),
          ),

          Positioned(
            top: screenHeight * 0.28,
            left: 20,
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
                    const Icon(
                      Icons.location_on_outlined,
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

          Positioned(
            top: screenHeight * 0.4,
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
              ),
              child: SingleChildScrollView(
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

                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: _selectedTabIndex == 0
                          ? _buildDettagliNormali()
                          : _buildDettagliScientifici(),
                    ),
                  ],
                ),
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
        const Text("Qui metteremo le icone: 3 ore, 1km, €€€..."),
        const SizedBox(height: 20),
        const Text(
          "Dettagli",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        const SizedBox(height: 10),
        Text(
          "Lorem ipsum dolor sit amet...",
          style: TextStyle(color: Colors.grey.shade600),
        ),
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
          style: TextStyle(color: Colors.grey.shade600),
        ),
      ],
    );
  }
}
