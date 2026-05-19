import 'package:flutter/material.dart';
import 'package:geoesplora/widgets/texts/section_label.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GeositeMapPreview extends StatelessWidget {
  const GeositeMapPreview({super.key});

  static const CameraPosition _initialPosition = CameraPosition(
    target: LatLng(39.3592, 16.2263),
    zoom: 12.0,
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionLabel(text: "Mappa", fontSize: 14),
        const SizedBox(height: 10),

        Container(
          height: 160,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.grey.shade200,
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: AbsorbPointer(
              child: GoogleMap(
                initialCameraPosition: _initialPosition,
                zoomControlsEnabled: false,
                mapToolbarEnabled: false,
                myLocationButtonEnabled: false,
                compassEnabled: false,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
