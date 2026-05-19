import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geoesplora/viewmodels/bottom_nav_viewmodel.dart';
import 'package:geoesplora/views/camera_view.dart';
import 'package:geoesplora/views/dashboard_view.dart';
import 'package:geoesplora/views/map_view.dart';
import 'package:geoesplora/views/rock_list_view.dart';
import 'package:geoesplora/widgets/navigations/custom_bottom_nav.dart';

class MainScreen extends ConsumerWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(bottomNavIndexProvider);

    final List<Widget> pages = [
      const DashboardView(),
      const MapView(),
      const CameraView(),
      const RockListView(),
      const Center(child: Text("Profilo")),
    ];

    return Scaffold(
      extendBody: true,
      body: Stack(
        children: [
          SafeArea(
            bottom: false,
            child: IndexedStack(index: currentIndex, children: pages),
          ),
        ],
      ),

      bottomNavigationBar: CustomBottomNav(
        currentIndex: currentIndex,
        onTap: (index) {
          ref.read(bottomNavIndexProvider.notifier).changePage(index);
        },
      ),
    );
  }
}
