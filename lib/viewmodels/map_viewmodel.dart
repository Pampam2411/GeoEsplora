import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapViewModel extends ChangeNotifier {
  final MapController mapController = MapController();
  final PageController pageController = PageController(viewportFraction: 0.85);
  int selectedIndex = 0;

  final LatLng initialCenter = const LatLng(39.3592, 16.2263);
  final double initialZoom = 9.0;

  void onMarkerTapped(int index, LatLng location) {
    if (selectedIndex == index) return;

    selectedIndex = index;
    mapController.move(location, 14.0);
    pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
    notifyListeners();
  }

  void onPageChanged(int index, LatLng location) {
    selectedIndex = index;
    mapController.move(location, 14.0);
    notifyListeners();
  }

  void resetCamera() {
    mapController.move(initialCenter, initialZoom);
  }

  @override
  void dispose() {
    mapController.dispose();
    pageController.dispose();
    super.dispose();
  }
}
