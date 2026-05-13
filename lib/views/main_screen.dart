import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'; // 1. IMPORTANTE: Aggiunto l'import di Riverpod
import 'package:geoesplora/viewmodels/bottom_nav_viewmodel.dart';
import 'package:geoesplora/views/dashboard_view.dart';
import 'package:geoesplora/views/rock_list_view.dart';
import 'package:geoesplora/widgets/navigations/custom_bottom_nav.dart';

// 2. Trasformato StatefulWidget in ConsumerWidget
class MainScreen extends ConsumerWidget {
  const MainScreen({super.key});

  @override
  // 3. Aggiunto "WidgetRef ref" per permettere a Flutter di leggere i provider
  Widget build(BuildContext context, WidgetRef ref) {
    // Ora ref.watch non darà più errore!
    final currentIndex = ref.watch(bottomNavIndexProvider);

    final List<Widget> pages = [
      const DashboardView(),
      const Center(child: Text("Mappa")),
      const Center(child: Text("Camera View")),
      const RockListView(),
      const Center(child: Text("Profilo")),
    ];

    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: IndexedStack(index: currentIndex, children: pages),
      ),
      bottomNavigationBar: CustomBottomNav(
        currentIndex: currentIndex,
        onTap: (index) {
          ref.read(bottomNavIndexProvider.notifier).state = index;
        },
      ),
    );
  }
}
