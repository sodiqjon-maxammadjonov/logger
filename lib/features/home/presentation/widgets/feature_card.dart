// lib/features/home/widgets/feature_card.dart

import 'package:flutter/material.dart';
import '../../../../core/utils/responsive/responsive.dart';

class FeatureCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final String subtitle;
  final Color color;

  const FeatureCard({
    super.key,
    required this.title,
    required this.icon,
    required this.subtitle,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('$title bo\'limi tez orada...')),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          // Yorqin rangni yumshoqroq qilish uchun .shade100 dan foydalanamiz
          color: color.withOpacity(0.12),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(
              icon,
              size: ResponsiveUtils.isMobile(context) ? 36 : 44,
              color: color,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: ResponsiveUtils.isMobile(context) ? 16 : 18,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: ResponsiveUtils.isMobile(context) ? 12 : 14,
                    color: Colors.grey[600],
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}