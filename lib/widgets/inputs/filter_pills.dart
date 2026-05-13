import 'package:flutter/material.dart';
import 'package:geoesplora/theme/app_color.dart';
import 'package:geoesplora/widgets/texts/section_label.dart';

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
            ),
            child: SectionLabel(
              text: options[index],
              color: isSelected ? AppColors.surface : AppColors.secondary,
              fontSize: 10,
            ),
          ),
        );
      }),
    );
  }
}
