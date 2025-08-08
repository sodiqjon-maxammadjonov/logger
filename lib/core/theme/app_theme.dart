import 'package:flutter/material.dart';
import 'app_colors.dart';

@immutable
class CustomThemeExtension extends ThemeExtension<CustomThemeExtension> {
  const CustomThemeExtension({
    required this.todayVerseGradient,
  });

  final Gradient? todayVerseGradient;

  @override
  CustomThemeExtension copyWith({Gradient? todayVerseGradient}) {
    return CustomThemeExtension(
      todayVerseGradient: todayVerseGradient ?? this.todayVerseGradient,
    );
  }

  @override
  CustomThemeExtension lerp(CustomThemeExtension? other, double t) {
    if (other is! CustomThemeExtension) {
      return this;
    }
    return CustomThemeExtension(
      todayVerseGradient: Gradient.lerp(todayVerseGradient, other.todayVerseGradient, t),
    );
  }
}



class AppTheme {
  static ThemeData get lightTheme => ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.seedColor,
      brightness: Brightness.light,
    ),

    extensions: const <ThemeExtension<dynamic>>[
      CustomThemeExtension(
        todayVerseGradient: AppColors.goldGradient,
      ),
    ],


    appBarTheme: const AppBarTheme(
      centerTitle: true,
      elevation: 0,
      scrolledUnderElevation: 1,
    ),

    cardTheme: CardThemeData(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      surfaceTintColor: AppColors.surface,
    ),

    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      ),
    ),

    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      filled: true,
      fillColor: AppColors.surfaceContainer,
    ),
  );

  static ThemeData get darkTheme => ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.seedColor,
      brightness: Brightness.dark,
    ),

    extensions: const <ThemeExtension<dynamic>>[
      CustomThemeExtension(
        todayVerseGradient: AppColors.goldGradientDark,
      ),
    ],

    appBarTheme: const AppBarTheme(
      centerTitle: true,
      elevation: 0,
      scrolledUnderElevation: 1,
    ),
  );
}