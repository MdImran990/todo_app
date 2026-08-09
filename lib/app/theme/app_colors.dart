import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // Primary
  static const Color primary = Color(0xFF4F46E5);
  static const Color primaryLight = Color(0xFF6366F1);
  static const Color primaryDark = Color(0xFF4338CA);
  static const Color secondary = Color(0xFF7C3AED);

  // Background
  static const Color background = Color(0xFFF6F8FC);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color inputBackground = Color(0xFFF7F7FB);

  // Text
  static const Color textPrimary = Color(0xFF17172A);
  static const Color textSecondary = Color(0xFF77778A);
  static const Color textLight = Color(0xFF9A9AAA);

  // Border
  static const Color border = Color(0xFFE9E9F2);

  // Status
  static const Color success = Color(0xFF16A34A);
  static const Color warning = Color(0xFFF59E0B);
  static const Color error = Color(0xFFDC2626);
  static const Color info = Color(0xFF2563EB);

  // Gradient
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      primary,
      primaryLight,
      secondary,
    ],
  );
}