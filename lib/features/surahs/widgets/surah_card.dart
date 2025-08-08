import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/responsive/responsive.dart';
import '../models/surah_model.dart';


class SurahCard extends StatelessWidget {
  final Surah surah;
  final VoidCallback onTap;

  const SurahCard({
    super.key,
    required this.surah,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Material(
      color: theme.colorScheme.surface,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Transform.rotate(
                    angle: 45 * 3.14159 / 180,
                    child: Container(
                      height: 38,
                      width: 38,
                      decoration: BoxDecoration(
                        color: AppColors.deepGreen.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  Text(
                    '${surah.id}',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                ],
              ),
              ResponsiveSpacing.hMD,

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      surah.nomiLotin,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    ResponsiveSpacing.vXS,
                    Text(
                      '${surah.oyatlarSoni} oyat • ${surah.joyi}',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                      ),
                    ),
                  ],
                ),
              ),

              ResponsiveSpacing.hMD,

              Text(
                surah.nomiArab,
                style: TextStyle(
                  fontFamily: 'Amiri',
                  fontSize: 20,
                  color: AppColors.deepGreen,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}