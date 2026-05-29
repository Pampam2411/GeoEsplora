import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geoesplora/theme/app_color.dart';
import 'package:geoesplora/viewmodels/map_viewmodel.dart';
import 'package:geoesplora/widgets/sections/geosite_map_preview.dart';
import 'package:geoesplora/widgets/utils/fade_gradient.dart';
import 'package:geoesplora/widgets/inputs/custom_search_bar.dart';
import 'package:latlong2/latlong.dart';

class MapView extends ConsumerStatefulWidget {
  const MapView({super.key});
  @override
  ConsumerState<MapView> createState() => _MapViewState();
}

class _MapViewState extends ConsumerState<MapView> {
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
    ref.listen<LatLng?>(targetMapLocationProvider, (previous, next) {
      if (next != null) {
        _viewModel.mapController.move(next, 16.0);

        ref.read(targetMapLocationProvider.notifier).state = null;
      }
    });
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          FlutterMap(
            mapController: _viewModel.mapController,
            options: MapOptions(
              initialCenter: _viewModel.initialCenter,
              initialZoom: _viewModel.initialZoom,
              interactionOptions: const InteractionOptions(
                flags: InteractiveFlag.all & ~InteractiveFlag.rotate,
              ),
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.example.geoesplora',
              ),
            ],
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
