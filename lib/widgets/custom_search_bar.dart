import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geoesplora/theme/app_color.dart';

class CustomSearchBar extends StatefulWidget {
  const CustomSearchBar({super.key});

  @override
  State<CustomSearchBar> createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  bool _isExpanded = false;

  void _toggleFilters() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.only(
      topLeft: const Radius.circular(10),
      topRight: const Radius.circular(10),
      bottomLeft: Radius.circular(_isExpanded ? 22 : 10),
      bottomRight: Radius.circular(_isExpanded ? 22 : 10),
    );

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: borderRadius,
        border: Border.all(color: AppColors.secondary, width: 1),
      ),

      child: ClipRRect(
        borderRadius: borderRadius,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 42,
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Cerca geosito...',
                  hintStyle: TextStyle(color: AppColors.secondary),
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  contentPadding: const EdgeInsets.only(
                    left: 20,
                    right: 8,
                    bottom: 12,
                    top: 12,
                  ),

                  suffixIcon: IconButton(
                    icon: const FaIcon(
                      FontAwesomeIcons.sliders,
                      size: 18,
                      color: AppColors.secondary,
                    ),
                    onPressed: _toggleFilters,
                  ),
                ),
              ),
            ),

            AnimatedSize(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              alignment: Alignment.topCenter,
              child: _isExpanded
                  ? _buildFilterContent()
                  : const SizedBox(width: double.infinity, height: 0),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterContent() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 20),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          const Text('Da completare con le checkbox e gli sliders!'),
          const SizedBox(height: 20),

          Center(
            child: SizedBox(
              width: 89,
              height: 32,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.secondary,
                  foregroundColor: AppColors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 0,
                  padding: EdgeInsets.zero,
                ),
                onPressed: _toggleFilters,
                child: const Text('Cerca'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
