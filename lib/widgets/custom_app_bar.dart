import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geoesplora/theme/app_color.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showBackButton;
  final List<Widget>? actions;

  const CustomAppBar({
    super.key,
    required this.title,
    this.showBackButton = true,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.background,
      elevation: 0,
      centerTitle: true,
      leading: showBackButton
          ? IconButton(
              icon: const FaIcon(
                FontAwesomeIcons.chevronLeft,
                color: AppColors.textPrimary,
                size: 20,
              ),
              onPressed: () => Navigator.of(context).pop(),
            )
          : null,
      title: Text(
        title,
        style: const TextStyle(
          color: AppColors.textPrimary,
          fontSize: 18,
          fontWeight: FontWeight.bold,
          fontFamily: 'AxiformaBold',
        ),
      ),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
