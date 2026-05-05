import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geoesplora/views/dashboard_view.dart';
import 'package:geoesplora/views/geosite_detail_screen.dart';
import 'package:geoesplora/views/home_view.dart';
import 'package:geoesplora/viewmodels/bottom_nav_viewmodel.dart';
import 'package:geoesplora/views/rock_list_view.dart';
import 'package:geoesplora/widgets/custom_bottom_nav.dart';
import 'package:geoesplora/widgets/custom_search_bar.dart';

class MainScreen extends ConsumerWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(bottomNavProvider);

    final List<Widget> pages = [
      const DashboardView(),
      const HomeView(),
      const GeositoDetailScreen(),
      const RockListView(),
      const Center(child: Text('Schermata Profilo')),
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
