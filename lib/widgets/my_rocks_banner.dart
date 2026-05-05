import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geoesplora/theme/app_color.dart';

class MyRocksBanner extends StatelessWidget {
  final VoidCallback onCameraTap;

  const MyRocksBanner({super.key, required this.onCameraTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 76,
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          // PARTE SINISTRA
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  const FaIcon(
                    FontAwesomeIcons.mountain,
                    color: AppColors.textPrimary,
                    size: 28,
                  ),
                  const SizedBox(width: 15),
                  const Text(
                    "Le mie rocce",
                    style: TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // PARTE FOTOCAMERA
          GestureDetector(
            onTap: onCameraTap,
            behavior: HitTestBehavior.opaque,
            child: Container(
              width: 76,
              height: double.infinity,
              decoration: const BoxDecoration(
                color: AppColors.primaryDark,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              child: const Center(
                child: FaIcon(
                  FontAwesomeIcons.camera,
                  color: AppColors.surface,
                  size: 24,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
