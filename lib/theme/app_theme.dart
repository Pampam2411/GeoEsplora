import 'package:flutter/material.dart';
import 'app_color.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: AppColors.background,

      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary,
        primary: AppColors.primary,
        secondary: AppColors.secondary,
        surface: AppColors.white,
        onSurface: AppColors.textPrimary,
        error: Colors.redAccent,
      ),

      textTheme: const TextTheme(
        displayLarge: TextStyle(
          fontFamily: 'Axiforma',
          fontWeight: FontWeight.w900,
          fontSize: 48,
          height: 1.07,
          color: AppColors.textPrimary,
        ),

        titleLarge: TextStyle(
          fontFamily: 'Axiforma',
          fontWeight: FontWeight.w400,
          fontSize: 20,
          height: 1,
          color: AppColors.textPrimary,
        ),

        bodyLarge: TextStyle(
          fontFamily: 'Axiforma',
          fontWeight: FontWeight.w400,
          fontSize: 14,
          height: 1,
          color: AppColors.textPrimary,
        ),

        bodyMedium: TextStyle(
          fontFamily: 'Axiforma',
          fontWeight: FontWeight.w400,
          fontSize: 12,
          height: 1.2,
          color: AppColors.secondary,
        ),
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.secondary,
          foregroundColor: AppColors.white,
          elevation: 0,
          textStyle: const TextStyle(
            fontFamily: 'Axiforma',
            fontWeight: FontWeight.w700,
            fontSize: 16,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        ),
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.white,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.greyLight),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.greyLight),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.primary, width: 2),
        ),
        hintStyle: const TextStyle(
          fontFamily: 'Axiforma',
          fontWeight: FontWeight.w400,
          color: AppColors.greyLight,
        ),
      ),
    );
  }
}
