import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/responsive/responsive.dart';
import 'feature_card.dart';

class MainFeaturesSection extends StatelessWidget {
  const MainFeaturesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Asosiy bo\'limlar',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.deepGreen,
              ),
        ),
        ResponsiveSpacing.vLG,
        if (ResponsiveUtils.isMobile(context))
          _buildMobileLayout(context)
        else
          _buildTabletLayout(context),
      ],
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            const Expanded(
                child: FeatureCard(
                    title: 'Qur\'on',
                    icon: Icons.menu_book,
                    subtitle: 'Al-Fatiha',
                    color: AppColors.deepGreen,)),
            ResponsiveSpacing.hMD,
            const Expanded(
                child: FeatureCard(
                    title: 'Namaz',
                    icon: Icons.access_time,
                    subtitle: 'Vaqtlari',
                    color: Colors.indigo)),
          ],
        ),
        ResponsiveSpacing.vMD,
        Row(
          children: [
            const Expanded(
                child: FeatureCard(
                    title: 'Qibla',
                    icon: Icons.explore,
                    subtitle: 'Yo\'nalish',
                    color: Colors.teal)),
            ResponsiveSpacing.hMD,
            const Expanded(
                child: FeatureCard(
                    title: 'Tasbih',
                    icon: Icons.radio_button_checked,
                    subtitle: 'Zikr',
                    color: Colors.purple)),
          ],
        ),
        ResponsiveSpacing.vMD,
        Row(
          children: [
            const Expanded(
                child: FeatureCard(
                    title: 'Duo',
                    icon: Icons.favorite,
                    subtitle: 'Duolar',
                    color: Colors.pink)),
            ResponsiveSpacing.hMD,
            const Expanded(
                child: FeatureCard(
                    title: 'Hadis',
                    icon: Icons.format_quote,
                    subtitle: 'Rivoyat',
                    color: Colors.orange)),
          ],
        ),
      ],
    );
  }

  Widget _buildTabletLayout(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 3,
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      childAspectRatio: 1.1,
      children: const [
        FeatureCard(
            title: 'Qur\'on',
            icon: Icons.menu_book,
            subtitle: 'Al-Fatiha',
            color: AppColors.deepGreen),
        FeatureCard(
            title: 'Namaz',
            icon: Icons.access_time,
            subtitle: 'Vaqtlari',
            color: Colors.indigo),
        FeatureCard(
            title: 'Qibla',
            icon: Icons.explore,
            subtitle: 'Yo\'nalish',
            color: Colors.teal),
        FeatureCard(
            title: 'Tasbih',
            icon: Icons.radio_button_checked,
            subtitle: 'Zikr',
            color: Colors.purple),
        FeatureCard(
            title: 'Duo',
            icon: Icons.favorite,
            subtitle: 'Duolar',
            color: Colors.pink),
        FeatureCard(
            title: 'Hadis',
            icon: Icons.format_quote,
            subtitle: 'Rivoyat',
            color: Colors.orange),
      ],
    );
  }
}
