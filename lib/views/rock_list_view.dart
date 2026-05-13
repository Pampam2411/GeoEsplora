import 'package:flutter/material.dart';
import 'package:geoesplora/models/mock_data.dart';
import 'package:geoesplora/widgets/inputs/custom_search_bar.dart';
import 'package:geoesplora/widgets/cards/rock_card.dart';
import 'package:geoesplora/widgets/texts/title_page.dart';

class RockListView extends StatelessWidget {
  const RockListView({super.key});

  @override
  Widget build(BuildContext context) {
    final rocks = MockData.mockRocks;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        children: [
          TitlePage(title: "Le tue rocce"),
          const SizedBox(height: 20),

          CustomSearchBar(),
          const SizedBox(height: 20),

          Expanded(
            child: GridView.builder(
              shrinkWrap: true,
              padding: const EdgeInsets.all(16.0),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 16.0,
                mainAxisSpacing: 16.0,
                childAspectRatio: 1.0,
              ),
              itemCount: rocks.length,
              itemBuilder: (context, index) {
                final rock = rocks[index];
                return RockCard(rock: rock, isFavorite: false);
              },
            ),
          ),
        ],
      ),
    );
  }
}
