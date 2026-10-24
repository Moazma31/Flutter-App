import 'package:flutter/material.dart';


class AppColors {
  static const teal = Color(0xFF0F766E);
  static const blue = Color(0xFF2563EB);
  static const amber = Color(0xFFF59E0B);
  static const green = Color(0xFF16A34A);
  static const purple = Color(0xFF7C3AED);
  static const background = Color(0xFFF8FAFC);
  static const textDark = Color(0xFF0F172A);
  static const textGrey = Color(0xFF64748B);

}

class AppTheme {
  static ThemeData get light => ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: AppColors.background,
    colorScheme: ColorScheme.fromSeed(seedColor: AppColors.teal),

  );
}