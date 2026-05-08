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
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Row(
        children: [
          //DURATA
          _buildIconText(FontAwesomeIcons.clock, durata, AppColors.textPrimary),
          const SizedBox(width: 25.0),
          //DISTANZA
          _buildIconText(
            FontAwesomeIcons.route,
            distanza,
            AppColors.textPrimary,
          ),

          const SizedBox(width: 25.0),
          //PREZZO
          Text(
            prezzo,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Colors.green,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
          const SizedBox(width: 25.0),

          //ACCESSIBILITÀ
          const FaIcon(
            FontAwesomeIcons.wheelchair,
            color: Colors.red,
            size: 20,
          ),
          const SizedBox(width: 25.0),

          //RECENSIONE
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const FaIcon(
                FontAwesomeIcons.star,
                color: Colors.amber,
                size: 20,
              ),
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
      ),
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
