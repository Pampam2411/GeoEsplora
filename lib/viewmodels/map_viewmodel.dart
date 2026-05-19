import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapViewModel extends ChangeNotifier {
  GoogleMapController? _mapController;

  final CameraPosition initialCameraPosition = const CameraPosition(
    target: LatLng(39.3592, 16.2263),
    zoom: 9.0,
  );

  bool get isMapReady => _mapController != null;

  void onMapCreated(GoogleMapController controller) {
    _mapController = controller;
    notifyListeners();
  }

  void resetCamera() {
    _mapController?.animateCamera(
      CameraUpdate.newCameraPosition(initialCameraPosition),
    );
  }

  @override
  void dispose() {
    _mapController?.dispose();
    super.dispose();
  }
}
