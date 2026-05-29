import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapViewModel extends ChangeNotifier {
  final MapController mapController = MapController();

  final LatLng initialCenter = const LatLng(39.3592, 16.2263);
  final double initialZoom = 9.0;

  void resetCamera() {
    mapController.move(initialCenter, initialZoom);
  }

  @override
  void dispose() {
    mapController.dispose();
    super.dispose();
  }
}
