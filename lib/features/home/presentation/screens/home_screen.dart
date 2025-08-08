import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/utils/responsive/responsive.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
            onPressed: () {
              // Theme toggle qilish
            },
            icon: const Icon(Icons.brightness_6_outlined),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: ResponsivePadding.responsive(context),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Welcome card
            Card(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Xush kelibsiz!',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    ResponsiveSpacing.vSM,
                    Text(
                      'Bu Flutter Clean Architecture 2025 demo ilovasi',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ],
                ),
              ),
            ),

            ResponsiveSpacing.vLG,

            // Feature cards
            Text(
              'Imkoniyatlar',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            ResponsiveSpacing.vMD,

            // Grid layout for features
            if (ResponsiveUtils.isMobile(context))
              _buildMobileLayout(context)
            else
              _buildTabletLayout(context),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return Column(
      children: [
        _buildFeatureCard(context, 'Responsive', Icons.devices),
        ResponsiveSpacing.vMD,
        _buildFeatureCard(context, 'Material 3', Icons.palette),
        ResponsiveSpacing.vMD,
        _buildFeatureCard(context, 'Clean Code', Icons.code),
      ],
    );
  }

  Widget _buildTabletLayout(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      childAspectRatio: 1.5,
      children: [
        _buildFeatureCard(context, 'Responsive', Icons.devices),
        _buildFeatureCard(context, 'Material 3', Icons.palette),
        _buildFeatureCard(context, 'Clean Code', Icons.code),
        _buildFeatureCard(context, 'Riverpod', Icons.layers),
      ],
    );
  }

  Widget _buildFeatureCard(BuildContext context, String title, IconData icon) {
    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 48,
                color: Theme.of(context).colorScheme.primary,
              ),
              ResponsiveSpacing.vSM,
              Text(
                title,
                style: Theme.of(context).textTheme.titleMedium,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}