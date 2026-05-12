import 'package:flutter/material.dart';
import 'package:geoesplora/models/mock_data.dart';
import 'package:geoesplora/theme/app_color.dart';
import 'package:geoesplora/widgets/custom_app_bar.dart';
import 'package:geoesplora/widgets/custom_search_bar.dart';
import 'package:geoesplora/widgets/geosite_card.dart';

class GeositeListView extends StatelessWidget {
  const GeositeListView({super.key});

  @override
  Widget build(BuildContext context) {
    final geosites = MockData.mockGeosites;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: CustomAppBar(title: "I tuoi geositi"),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            CustomSearchBar(),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  final geosite = geosites[index];
                  return GeositeCard(geosite: geosite);
                },
                itemCount: geosites.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
