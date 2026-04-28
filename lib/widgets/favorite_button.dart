import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geoesplora/theme/app_color.dart';

class FavoriteButton extends StatefulWidget {
  final bool isInitiallyFavorite;
  final double size;

  const FavoriteButton({
    super.key,
    this.isInitiallyFavorite = false,
    this.size = 24,
  });

  @override
  State<FavoriteButton> createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  late bool _isFavorite;

  @override
  void initState() {
    super.initState();
    _isFavorite = widget.isInitiallyFavorite;
  }

  void _toggleFavorite() {
    setState(() {
      _isFavorite = !_isFavorite;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.size,
      height: widget.size,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.background,
      ),
      child: IconButton(
        padding: EdgeInsets.zero,
        onPressed: _toggleFavorite,
        icon: FaIcon(
          _isFavorite ? FontAwesomeIcons.solidHeart : FontAwesomeIcons.heart,
          color: _isFavorite ? Colors.red : AppColors.secondary,
          size: widget.size * 0.55,
        ),
      ),
    );
  }
}
