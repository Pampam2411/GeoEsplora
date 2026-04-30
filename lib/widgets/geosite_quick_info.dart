import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geoesplora/theme/app_color.dart';

class GeositeQuickInfo extends StatelessWidget {
  final String durata, distanza, prezzo;
  final double rating;

  const GeositeQuickInfo({
    super.key,
    required this.durata,
    required this.distanza,
    required this.prezzo,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 16.0,
      runSpacing: 10.0,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        //DURATA
        _buildIconText(FontAwesomeIcons.clock, durata, AppColors.textPrimary),

        //DISTANZA
        _buildIconText(FontAwesomeIcons.route, distanza, AppColors.textPrimary),

        Text(
          prezzo,
          style: const TextStyle(
            color: Colors.green,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),

        const FaIcon(FontAwesomeIcons.wheelchair, color: Colors.red, size: 20),

        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const FaIcon(FontAwesomeIcons.star, color: Colors.amber, size: 20),
            const SizedBox(width: 4),
            Text(
              rating.toStringAsFixed(1),
              style: const TextStyle(
                color: Colors.amber,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildIconText(FaIconData icon, String text, Color color) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        FaIcon(icon, color: color, size: 18),
        const SizedBox(width: 6),
        Text(
          text,
          style: TextStyle(
            color: color,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}
