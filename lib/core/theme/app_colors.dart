import 'package:flutter/material.dart';

class AppColors {
  static const seedColor = Color(0xFF6750A4);
  static const customSeed = Color(0xFF00ACC1);

  static const surface = Color(0xFFFFFBFE);
  static const surfaceDim = Color(0xFFE7E0EC);
  static const surfaceBright = Color(0xFFFFFBFE);
  static const surfaceContainer = Color(0xFFF3EDF7);
  static const surfaceContainerHigh = Color(0xFFEDE7F0);

  static const overlay10 = Color(0x1A000000);
  static const overlay20 = Color(0x33000000);
  static const overlay50 = Color(0x80000000);

  static const primaryGradient = LinearGradient(
    colors: [Color(0xFF6750A4), Color(0xFF7C4DFF)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}