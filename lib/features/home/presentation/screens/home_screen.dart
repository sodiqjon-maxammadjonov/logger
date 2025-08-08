import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/utils/responsive/responsive.dart';
import '../widgets/home_sliver_appbar.dart';
import '../widgets/main_features_section.dart';
import '../widgets/quick_action_section.dart';
import '../widgets/today_verse_card.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [

          HomeSliverAppBar(),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ResponsiveSpacing.vLG,

                  TodayVerseCard(),

                   ResponsiveSpacing.vXL,

                  MainFeaturesSection(),

                   ResponsiveSpacing.vXL,

                  QuickActionsSection(),

                  ResponsiveSpacing.vXL,
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}