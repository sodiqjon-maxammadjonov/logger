import 'package:flutter/material.dart';

class AppColors {
  static const seedColor = Color(0xFF2E7D32);
  static const goldAccent = Color(0xFFFFB300);
  static const deepGreen = Color(0xFF1B5E20);

  static const islamicGradient = LinearGradient(
    colors: [
      Color(0xFF2E7D32),
      Color(0xFF388E3C),
      Color(0xFF4CAF50),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    stops: [0.0, 0.5, 1.0],
  );

  static const goldGradient = LinearGradient(
    colors: [
      Color(0xFFFFB300),
      Color(0xFFFFC107),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const goldGradientDark = LinearGradient(
    colors: [
      Color(0xFF8B6B4A),
      Color(0xFF634A2F),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const surface = Color(0xFFFFFBFE);
  static const surfaceDim = Color(0xFFF5F5F5);
  static const surfaceContainer = Color(0xFFE8F5E8);

  static const arabicTextColor = Color(0xFF1B5E20);
  static const translationTextColor = Color(0xFF424242);

  static const overlay10 = Color(0x1A2E7D32);
  static const overlay20 = Color(0x332E7D32);
  static const overlay50 = Color(0x802E7D32);
}