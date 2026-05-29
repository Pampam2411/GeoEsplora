import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geoesplora/theme/app_color.dart';
import 'package:geoesplora/viewmodels/bottom_nav_viewmodel.dart';
import 'package:geoesplora/widgets/texts/section_label.dart';
import 'package:latlong2/latlong.dart';

final targetMapLocationProvider = StateProvider<LatLng?>((ref) => null);

class GeositeMapPreview extends ConsumerWidget {
  final double latitude;
  final double longitude;

  const GeositeMapPreview({
    super.key,
    required this.latitude,
    required this.longitude,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final LatLng geositeLocation = LatLng(latitude, longitude);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionLabel(text: "Mappa", fontSize: 14),
        const SizedBox(height: 10),
        GestureDetector(
          onTap: () {
            ref.read(targetMapLocationProvider.notifier).state =
                geositeLocation;

            ref.read(bottomNavIndexProvider.notifier).changePage(1);

            Navigator.of(context).popUntil((route) => route.isFirst);
          },
          child: Container(
            height: 160,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.grey.shade200,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: AbsorbPointer(
                child: FlutterMap(
                  options: MapOptions(
                    initialCenter: geositeLocation,
                    initialZoom: 14.0,
                    interactionOptions: const InteractionOptions(
                      flags: InteractiveFlag.none,
                    ),
                  ),
                  children: [
                    TileLayer(
                      urlTemplate:
                          'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                      userAgentPackageName: 'com.example.geoesplora',
                    ),

                    MarkerLayer(
                      markers: [
                        Marker(
                          point: geositeLocation,
                          width: 50,
                          height: 50,
                          alignment: Alignment.topCenter,
                          child: const FaIcon(
                            FontAwesomeIcons.locationDot,
                            color: AppColors.primary,
                            size: 40,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
