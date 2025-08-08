import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/responsive/responsive.dart';

class TodayVerseCard extends StatelessWidget {
  const TodayVerseCard({super.key});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: AppColors.goldGradient,
        borderRadius: BorderRadius.circular(24),
        border:
            Border.all(color: Colors.white.withValues(alpha: 0.2), width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        child: Column(
          children: [
            // 1. Sarlavha qismi
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.auto_awesome_rounded,
                    color: Colors.white, size: 20),
                ResponsiveSpacing.hSM,
                Text(
                  'Bugungi oyat',
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.8),
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),

            ResponsiveSpacing.vLG,
            const Text(
              'وَمَا تَوْفِيقِي إِلَّا بِاللَّهِ ۚ عَلَيْهِ تَوَكَّلْتُ وَإِلَيْهِ أُنِيبُ',
              style: TextStyle(
                fontFamily: 'Amiri',
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
                height: 1.9,
              ),
              textAlign: TextAlign.center,
              textDirection: TextDirection.rtl,
            ),

            ResponsiveSpacing.vMD,

            Text(
              '“Mening muvaffaqiyatim faqat Allohning yordami bilangadir. Ungagina tavakkal qildim va Ungagina murojaat qilurman”',
              // Tirnoqlar bilan
              style: TextStyle(
                color: Colors.white.withOpacity(0.95),
                fontSize: 14,
                fontStyle: FontStyle.italic,
                height: 1.6,
              ),
              textAlign: TextAlign.center,
            ),

            ResponsiveSpacing.vSM,

            Text(
              'Hud surasi, 88-oyat',
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.7),
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
