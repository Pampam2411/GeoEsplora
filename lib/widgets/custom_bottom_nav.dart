import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geoesplora/theme/app_color.dart';
import 'package:geoesplora/viewmodels/bottom_nav_viewmodel.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomBottomNav extends ConsumerWidget {
  const CustomBottomNav({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(bottomNavProvider);

    return BottomAppBar(
      color: AppColors.secondary,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      height: 70,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildNavItem(0, FontAwesomeIcons.house, currentIndex, ref),
          _buildNavItem(1, FontAwesomeIcons.map, currentIndex, ref),
          _buildNavItem(2, FontAwesomeIcons.camera, currentIndex, ref),
          _buildNavItem(3, FontAwesomeIcons.mountain, currentIndex, ref),
          _buildNavItem(4, FontAwesomeIcons.user, currentIndex, ref),
        ],
      ),
    );
  }

  Widget _buildNavItem(
    int index,
    FaIconData icon,
    int currentIndex,
    WidgetRef ref,
  ) {
    final isSelected = index == currentIndex;

    return IconButton(
      icon: FaIcon(
        icon,
        color: isSelected
            ? AppColors.white
            : AppColors.white.withValues(alpha: 0.5),
        size: isSelected ? 24 : 22,
      ),
      onPressed: () => ref.read(bottomNavProvider.notifier).setIndex(index),
    );
  }
}
