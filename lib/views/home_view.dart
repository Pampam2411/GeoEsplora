import 'package:flutter/material.dart';
import 'package:geoesplora/models/mock_data.dart';
import 'package:geoesplora/widgets/geosite_card.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final geositi = MockData.mockGeosites;

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      itemCount: geositi.length,
      itemBuilder: (context, index) {
        final geosito = geositi[index];

        return Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: GeositeCard(
            imageUrl: geosito.imageUrl,
            placeholder: geosito.name,
            location: geosito.location,
            rating: geosito.rating,
            reviewCount: geosito.reviewCount,
            isFavorite: false,
          ),
        );
      },
    );
  }
}
