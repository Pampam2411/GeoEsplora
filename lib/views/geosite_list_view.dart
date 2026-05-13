import 'package:flutter/material.dart';
import 'package:geoesplora/models/mock_data.dart';
import 'package:geoesplora/theme/app_color.dart';
import 'package:geoesplora/widgets/inputs/custom_search_bar.dart';
import 'package:geoesplora/widgets/cards/geosite_card.dart';
import 'package:geoesplora/widgets/texts/title_page.dart';

class GeositeListView extends StatelessWidget {
  const GeositeListView({super.key});

  @override
  Widget build(BuildContext context) {
    final geosites = MockData.mockGeosites;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            TitlePage(title: "I tuoi geositi"),

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
