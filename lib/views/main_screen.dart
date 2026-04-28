import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geoesplora/widgets/rock_card.dart';
import 'package:geoesplora/viewmodels/bottom_nav_viewmodel.dart';
import 'package:geoesplora/widgets/custom_bottom_nav.dart';
import 'package:geoesplora/widgets/custom_search_bar.dart';
import 'package:geoesplora/widgets/geosito_card.dart';

class MainScreen extends ConsumerWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(bottomNavProvider);

    final List<Widget> pages = [
      Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            GeositoCard(
              // Mettiamo un'immagine segnaposto a caso da internet per testare il layout
              imageUrl:
                  'https://images.unsplash.com/photo-1464822759023-fed622ff2c3b?q=80&w=1000&auto=format&fit=crop',
              placeholder: 'Placeholder',
              location: 'Cosenza',
              rating: 4.8,
              reviewCount: 143,
            ),
            RockCard(
              imageUrl:
                  'https://images.unsplash.com/photo-1464822759023-fed622ff2c3b?q=80&w=1000&auto=format&fit=crop',
              rockName: 'Marmo',
              type: 'Sedimentaria',
            ),
            const Center(child: Text('Schermata Mappa - Esplorazione')),
            const Center(child: Text('Scheramata Fotocamera')),
            const Center(child: Text('Schermata Geositi - Lista completa')),
            const Center(
              child: Text('Schermata Profilo - Impostazioni utente'),
            ),
          ],
        ),
      ),
    ];

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: CustomSearchBar(),
            ),
            Expanded(child: pages[currentIndex]),
          ],
        ),
      ),
      bottomNavigationBar: const CustomBottomNav(),
    );
  }
}
