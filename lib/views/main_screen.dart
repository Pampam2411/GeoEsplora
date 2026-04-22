import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geoesplora/theme/app_color.dart';
import 'package:geoesplora/viewmodels/bottom_nav_viewmodel.dart';
import 'package:geoesplora/widgets/custom_bottom_nav.dart';

class MainScreen extends ConsumerWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(bottomNavProvider);

    final List<Widget> pages = [
      const Center(
        child: Text('Schermata Home - Qui andrà la mappa dei geositi'),
      ),
      const Center(child: Text('Schermata Mappa - Esplorazione')),
      const Center(child: Text('Scheramata Fotocamera')),
      const Center(child: Text('Schermata Geositi - Lista completa')),
      const Center(child: Text('Schermata Profilo - Impostazioni utente')),
    ];

    return Scaffold(
      body: pages[currentIndex],
      bottomNavigationBar: const CustomBottomNav(),
    );
  }
}
