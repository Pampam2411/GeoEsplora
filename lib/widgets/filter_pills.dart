import 'package:flutter/material.dart';
import 'package:geoesplora/theme/app_color.dart';

class FilterPills extends StatelessWidget {
  final List<String> options;
  final int selectedIndex;
  final ValueChanged<int> onSelected;

  const FilterPills({
    super.key,
    required this.options,
    required this.selectedIndex,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(options.length, (index) {
        final isSelected = index == selectedIndex;
        return GestureDetector(
          onTap: () => onSelected(index),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
            decoration: BoxDecoration(
              color: isSelected ? AppColors.textPrimary : AppColors.surface,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: isSelected
                    ? AppColors.textPrimary
                    : AppColors.borderLight,
              ),
            ),
            child: Text(
              options[index],
              style: TextStyle(
                color: isSelected ? AppColors.surface : AppColors.textPrimary,
                fontWeight: FontWeight.w600,
                fontSize: 13,
              ),
            ),
          ),
        );
      }),
    );
  }
}
