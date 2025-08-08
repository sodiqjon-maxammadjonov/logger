import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/responsive/responsive.dart';
import '../widgets/today_verse_card.dart';
import '../widgets/feature_card.dart';
import '../widgets/quick_action_card.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _buildAppBar(),
          SliverToBoxAdapter(
            child: Padding(
              padding: ResponsivePadding.responsive(context),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ResponsiveSpacing.vLG,
                  const TodayVerseCard(),
                  ResponsiveSpacing.vXL,
                  _buildMainFeatures(context),
                  ResponsiveSpacing.vXL,
                  _buildQuickActions(),
                  const SizedBox(height: 800),

                  Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          '© 2025 Qur\'oni Karim ilovasi',
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Barcha huquqlar himoyalangan',
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Versiya: 1.0.0',
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                      ],
                    )

                  ),

                  ResponsiveSpacing.vXL,

                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  SliverAppBar _buildAppBar() {
    return SliverAppBar(
      expandedHeight: 200,
      floating: false,
      pinned: true,
      elevation: 0,
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          decoration: const BoxDecoration(
            gradient: AppColors.islamicGradient,
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Text(
                    'Assalomu alaykum',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Qur\'oni Karim',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
      actions: [
        IconButton(
          onPressed: () {
            // Theme toggle qilish
          },
          icon: const Icon(Icons.brightness_6_outlined, color: Colors.white),
        ),
        IconButton(
          onPressed: () {
            // Settings
          },
          icon: const Icon(Icons.settings_outlined, color: Colors.white),
        ),
      ],
    );

  }

  Widget _buildMainFeatures(BuildContext context) {
    final features = [
      ('Qur\'on', 'Al-Fatiha', Icons.menu_book, AppColors.deepGreen),
      ('Namaz', 'Vaqtlari', Icons.access_time, Colors.indigo),
      ('Qibla', 'Yo\'nalish', Icons.explore, Colors.teal),
      ('Tasbih', 'Zikr', Icons.radio_button_checked, Colors.purple),
      ('Duo', 'Duolar', Icons.favorite, Colors.pink),
      ('Hadis', 'Rivoyat', Icons.format_quote, Colors.orange),
    ];

    if (ResponsiveUtils.isMobile(context)) {
      return Column(
        children: [
          for (int i = 0; i < features.length; i += 2)
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Row(
                children: [
                  Expanded(
                    child: FeatureCard(
                      title: features[i].$1,
                      subtitle: features[i].$2,
                      icon: features[i].$3,
                      color: features[i].$4,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: FeatureCard(
                      title: features[i + 1].$1,
                      subtitle: features[i + 1].$2,
                      icon: features[i + 1].$3,
                      color: features[i + 1].$4,
                    ),
                  ),
                ],
              ),
            ),
        ],
      );
    } else {
      return GridView.count(
        shrinkWrap: true,
        crossAxisCount: 3,
        childAspectRatio: 1.1,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        children: [
          for (var f in features)
            FeatureCard(
              title: f.$1,
              subtitle: f.$2,
              icon: f.$3,
              color: f.$4,
            ),
        ],
      );
    }
  }

  Widget _buildQuickActions() {
    final actions = [
      ('Oxirgi o\'qigan', Icons.bookmark, AppColors.deepGreen),
      ('Sevimlilar', Icons.favorite_outline, Colors.red),
      ('Eslatma', Icons.notifications_outlined, Colors.orange),
      ('Statistika', Icons.bar_chart, Colors.blue),
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          for (var a in actions) ...[
            QuickActionCard(title: a.$1, icon: a.$2, color: a.$3),
            const SizedBox(width: 12),
          ]
        ],
      ),
    );
  }
}
