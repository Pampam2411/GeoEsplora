import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geoesplora/theme/app_color.dart';
import 'package:geoesplora/viewmodels/map_viewmodel.dart';
import 'package:geoesplora/widgets/cards/geosite_card.dart';
import 'package:geoesplora/widgets/sections/geosite_map_preview.dart';
import 'package:geoesplora/widgets/utils/fade_gradient.dart';
import 'package:geoesplora/widgets/inputs/custom_search_bar.dart';
import 'package:latlong2/latlong.dart';
import 'package:geoesplora/viewmodels/geosite_list_viewmodel.dart';

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
        _viewModel.mapController.move(next, 14.0);

        ref.read(targetMapLocationProvider.notifier).state = null;
      }
    });

    final geosites = ref.watch(geositeListProvider);

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
                keepBuffer: 2,
                panBuffer: 1,
                maxNativeZoom: 19,
                maxZoom: 19,
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.example.geoesplora',
              ),
              MarkerLayer(
                markers: geosites.asMap().entries.map((entry) {
                  final index = entry.key;
                  final geosite = entry.value;
                  final isSelected = _viewModel.selectedIndex == index;
                  return Marker(
                    point: LatLng(geosite.latitude, geosite.longitude),
                    width: isSelected ? 65 : 50,
                    height: isSelected ? 65 : 50,
                    alignment: Alignment.topCenter,
                    child: GestureDetector(
                      onTap: () {
                        _viewModel.onMarkerTapped(
                          index,
                          LatLng(geosite.latitude, geosite.longitude),
                        );
                      },
                      child: const FaIcon(
                        FontAwesomeIcons.locationDot,
                        color: AppColors.primary,
                        size: 36,
                      ),
                    ),
                  );
                }).toList(),
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

          // SEARCH BAR
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

          //LISTA GEOSITECARD
          AnimatedBuilder(
            animation: _viewModel,
            builder: (context, child) {
              return Positioned(
                bottom: 110,
                left: 0,
                right: 0,
                height: 220,
                child: PageView.builder(
                  controller: _viewModel.pageController,
                  itemCount: geosites.length,
                  onPageChanged: (index) {
                    final geosite = geosites[index];
                    _viewModel.onPageChanged(
                      index,
                      LatLng(geosite.latitude, geosite.longitude),
                    );
                  },
                  itemBuilder: (context, index) {
                    final geosite = geosites[index];
                    final isSelected = _viewModel.selectedIndex == index;

                    return AnimatedScale(
                      duration: const Duration(milliseconds: 250),
                      scale: isSelected ? 1.0 : 0.9,
                      child: GeositeCard(geosite: geosite, showShadow: true),
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
