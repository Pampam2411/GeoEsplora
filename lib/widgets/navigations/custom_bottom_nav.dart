import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geoesplora/theme/app_color.dart';
import 'package:geoesplora/widgets/utils/fade_gradient.dart';

class CustomBottomNav extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    const double navBarHeight = 65.0;
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.bottomCenter,
      children: [
        Positioned(
          bottom: navBarHeight,
          left: 0,
          right: 0,
          child: IgnorePointer(
            child: FadeGradient.single(
              color: AppColors.background.withValues(alpha: 0.6),
              height: 28,
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            ),
          ),
        ),
        Container(
          height: navBarHeight,
          color: Colors.transparent,
          child: SizedBox(
            height: navBarHeight,
            child: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              backgroundColor: AppColors.secondary,
              selectedItemColor: AppColors.surface,
              unselectedItemColor: AppColors.surface,
              showSelectedLabels: false,
              showUnselectedLabels: false,
              currentIndex: currentIndex,
              onTap: onTap,
              items: [
                const BottomNavigationBarItem(
                  label: 'Home',
                  icon: FaIcon(FontAwesomeIcons.house),
                ),
                const BottomNavigationBarItem(
                  label: 'Mappa',
                  icon: FaIcon(FontAwesomeIcons.map),
                ),

                const BottomNavigationBarItem(
                  label: '',
                  icon: SizedBox(width: 40),
                ),

                const BottomNavigationBarItem(
                  label: 'Rocce',
                  icon: FaIcon(FontAwesomeIcons.mountain),
                ),
                const BottomNavigationBarItem(
                  label: 'Profilo',
                  icon: FaIcon(FontAwesomeIcons.user),
                ),
              ],
            ),
          ),
        ),

        Positioned(
          top: -28,
          child: GestureDetector(
            onTap: () => onTap(2),
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppColors.secondary,
                shape: BoxShape.circle,
              ),
              child: Container(
                padding: EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Color(0xFF9F988E),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.3),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),

                child: FaIcon(
                  FontAwesomeIcons.camera,
                  color: AppColors.surface,
                  size: 32,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
