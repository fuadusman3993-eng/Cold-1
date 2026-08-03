import 'package:flutter/material.dart';

class AppColors {
  // Background
  static const Color bgPrimary = Color(0xFF000000); // Pure Black
  static const Color bgSecondary = Color(0xFF111111); // Card Background
  static const Color bgTertiary = Color(0xFF1A1A1A);
  static const Color bgQuaternary = Color(0xFF222222);
  static const Color surfaceOverlay = Color(0x0AFFFFFF);

  // Text
  static const Color textPrimary = Color(0xFFFFFFFF); // White
  static const Color textSecondary = Color(0xFFA0A4AD); // Grey
  static const Color textTertiary = Color(0xFF6B7080);
  static const Color textInverse = Color(0xFF000000);

  // Border
  static const Color borderSubtle = Color(0x1AFFFFFF);
  static const Color borderActive = Color(0x80D4AF37);

  // Gold Accent
  static const Color goldPrimary = Color(0xFFD4AF37);
  static const Color goldLight = Color(0xFFE8D48B);
  static const Color goldDark = Color(0xFFB8960C);
  static const Color goldGradientStart = Color(0xFFD4AF37);
  static const Color goldGradientEnd = Color(0xFFF0D060);
  static const Color goldShimmer = Color(0x26D4AF37);

  // Status
  static const Color success = Color(0xFF34D399); // Green
  static const Color warning = Color(0xFFFBBF24);
  static const Color error = Color(0xFFF87171);
  static const Color info = Color(0xFF60A5FA);

  // Gradients
  static const LinearGradient goldGradient = LinearGradient(
    colors: [goldGradientStart, goldGradientEnd],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  static const LinearGradient bgGradient = LinearGradient(
    colors: [bgPrimary, bgSecondary],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}
