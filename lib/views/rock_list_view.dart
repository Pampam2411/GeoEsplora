import 'package:flutter/material.dart';
import 'package:geoesplora/models/mock_data.dart';
import 'package:geoesplora/widgets/custom_app_bar.dart';
import 'package:geoesplora/widgets/rock_card.dart';

class RockListView extends StatelessWidget {
  const RockListView({super.key});

  @override
  Widget build(BuildContext context) {
    final rocks = MockData.mockRocks;
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Catalogo Rocce',
        showBackButton: false,
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16.0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16.0,
          mainAxisSpacing: 16.0,
          childAspectRatio: 1.0,
        ),
        itemCount: rocks.length,
        itemBuilder: (context, index) {
          final rock = rocks[index];
          return RockCard(
            imageUrl: rock.imageUrl,
            rockName: rock.name,
            type: rock.type,
            isFavorite: false,
          );
        },
      ),
    );
  }
}
