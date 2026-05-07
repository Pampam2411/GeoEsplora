import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geoesplora/theme/app_color.dart';

class MyRocksBanner extends StatelessWidget {
  final VoidCallback onCameraTap;
  final VoidCallback onMyRockTap;
  const MyRocksBanner({
    super.key,
    required this.onCameraTap,
    required this.onMyRockTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 76,
      decoration: BoxDecoration(
        color: AppColors.primaryDark,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          // PARTE SINISTRA
          Expanded(
            child: GestureDetector(
              onTap: onMyRockTap,
              behavior: HitTestBehavior.opaque,
              child: Container(
                padding: const EdgeInsets.only(left: 35),
                height: 76,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                ),
                child: Row(
                  children: [
                    const FaIcon(
                      FontAwesomeIcons.mountain,
                      color: AppColors.textPrimary,
                      size: 28,
                    ),
                    const SizedBox(width: 15),
                    Text(
                      "Le mie rocce",
                      style: Theme.of(
                        context,
                      ).textTheme.titleMedium?.copyWith(fontSize: 20),
                    ),
                  ],
                ),
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
                  topRight: Radius.circular(16),
                  bottomRight: Radius.circular(16),
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
