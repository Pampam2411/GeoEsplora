import 'package:flutter/material.dart';
import 'package:geoesplora/widgets/buttons/custom_back_button.dart';
import 'package:geoesplora/widgets/buttons/favorite_button.dart';

class BackFavoriteButton extends StatelessWidget {
  const BackFavoriteButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomBackButton(),
            const FavoriteButton(isInitiallyFavorite: false, size: 36),
          ],
        ),
      ),
    );
  }
}
