import 'package:flutter/material.dart';
import 'package:geoesplora/theme/app_color.dart';
import 'package:geoesplora/viewmodels/map_viewmodel.dart';
import 'package:geoesplora/widgets/utils/fade_gradient.dart';
import 'package:geoesplora/widgets/inputs/custom_search_bar.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapView extends StatefulWidget {
  const MapView({super.key});
  @override
  State<StatefulWidget> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  late final MapViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = MapViewModel();
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: _viewModel.initialCameraPosition,
            onMapCreated: _viewModel.onMapCreated,
            zoomControlsEnabled: false,
            myLocationButtonEnabled: false,
            compassEnabled: true,
            mapToolbarEnabled: false,
          ),

          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: RepaintBoundary(
              child: FadeGradient.single(
                color: AppColors.background,
                height: 260,
              ),
            ),
          ),

          // Search Bar
          SafeArea(
            bottom: false,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 8.0,
              ),
              child: CustomSearchBar(),
            ),
          ),
        ],
      ),
    );
  }
}
