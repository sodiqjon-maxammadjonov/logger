// lib/features/home/widgets/quick_actions_section.dart

import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/responsive/responsive.dart';
import 'quick_action_card.dart';

class QuickActionsSection extends StatelessWidget {
  const QuickActionsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Text(
            'Tezkor harakatlar',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.deepGreen,
            ),
          ),
        ),
        ResponsiveSpacing.vLG,
        SizedBox(
          height: 110,
          child: ListView(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            children: [
              const SizedBox(width: 20),
              QuickActionCard(
                title: 'Oxirgi o\'qigan',
                icon: Icons.bookmark_added_rounded,
                color: AppColors.deepGreen,
                onTap: () {},
              ),
              ResponsiveSpacing.hMD,
              QuickActionCard(
                title: 'Sevimlilar',
                icon: Icons.favorite_rounded,
                color: Colors.red,
                onTap: () {},
              ),
              ResponsiveSpacing.hMD,
              QuickActionCard(
                title: 'Eslatma',
                icon: Icons.notifications_active_rounded,
                color: Colors.orange,
                onTap: () {},
              ),
              ResponsiveSpacing.hMD,
              QuickActionCard(
                title: 'Statistika',
                icon: Icons.bar_chart_rounded,
                color: Colors.blue,
                onTap: () {},
              ),
              const SizedBox(width: 20),
            ],
          ),
        ),
        SizedBox(height: 50),
      ],
    );
  }
}