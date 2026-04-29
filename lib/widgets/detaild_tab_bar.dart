import 'package:flutter/material.dart';
import 'package:geoesplora/theme/app_color.dart';

class DetailTabBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTabChanged;

  const DetailTabBar({
    super.key,
    required this.selectedIndex,
    required this.onTabChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: const BoxDecoration(color: AppColors.background),
      child: Row(
        children: [
          // DETTAGLI
          Expanded(
            child: GestureDetector(
              onTap: () => onTabChanged(0),
              child: Container(
                decoration: BoxDecoration(
                  color: selectedIndex == 0
                      ? AppColors.background
                      : AppColors.secondary,
                  borderRadius: BorderRadius.only(
                    topLeft: const Radius.circular(20),
                    topRight: Radius.circular(selectedIndex == 0 ? 20 : 0),
                    bottomRight: Radius.circular(selectedIndex == 0 ? 0 : 20),
                  ),
                ),
                alignment: Alignment.center,
                child: Text(
                  'Dettagli',
                  style: TextStyle(
                    color: selectedIndex == 0
                        ? AppColors.textPrimary
                        : AppColors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          ),

          // DETTAGLI SCENTIFICI
          Expanded(
            child: GestureDetector(
              onTap: () => onTabChanged(1),
              child: Container(
                decoration: BoxDecoration(
                  color: selectedIndex == 1
                      ? AppColors.background
                      : AppColors.secondary,
                  borderRadius: BorderRadius.only(
                    topRight: const Radius.circular(20),
                    topLeft: Radius.circular(selectedIndex == 1 ? 20 : 0),
                    bottomLeft: Radius.circular(selectedIndex == 1 ? 0 : 20),
                  ),
                ),
                alignment: Alignment.center,
                child: Text(
                  'Dettagli scientifici',
                  style: TextStyle(
                    color: selectedIndex == 1
                        ? AppColors.textPrimary
                        : AppColors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
