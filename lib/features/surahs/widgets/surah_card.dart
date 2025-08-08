import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/responsive/responsive.dart';
import '../models/surah_model.dart';

class SurahCard extends StatefulWidget {
  final Surah surah;
  final VoidCallback onTap;
  final bool isFavorite;
  final VoidCallback? onFavoriteToggle;

  const SurahCard({
    super.key,
    required this.surah,
    required this.onTap,
    this.isFavorite = false,
    this.onFavoriteToggle,
  });

  @override
  State<SurahCard> createState() => _SurahCardState();
}

class _SurahCardState extends State<SurahCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  bool _isPressed = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.95,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails details) {
    setState(() => _isPressed = true);
    _animationController.forward();
  }

  void _onTapUp(TapUpDetails details) {
    setState(() => _isPressed = false);
    _animationController.reverse();
    widget.onTap();
  }

  void _onTapCancel() {
    setState(() => _isPressed = false);
    _animationController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return AnimatedBuilder(
      animation: _scaleAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: GestureDetector(
            onTapDown: _onTapDown,
            onTapUp: _onTapUp,
            onTapCancel: _onTapCancel,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                gradient: _isPressed
                    ? LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    AppColors.deepGreen.withOpacity(0.08),
                    AppColors.deepGreen.withOpacity(0.12),
                  ],
                )
                    : LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    theme.colorScheme.surface,
                    theme.colorScheme.surface.withOpacity(0.8),
                  ],
                ),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: _isPressed
                      ? AppColors.deepGreen.withOpacity(0.3)
                      : theme.colorScheme.outline.withOpacity(0.1),
                  width: 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: isDark
                        ? Colors.black.withOpacity(0.3)
                        : Colors.grey.withOpacity(0.1),
                    blurRadius: _isPressed ? 8 : 12,
                    offset: Offset(0, _isPressed ? 2 : 4),
                    spreadRadius: 0,
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: [
                    // Surah raqami - zamonaviy dizayn
                    _buildSurahNumber(theme),

                    const SizedBox(width: 16),

                    // Surah ma'lumotlari
                    Expanded(
                      child: _buildSurahInfo(theme),
                    ),

                    const SizedBox(width: 16),

                    // Arab nomi va favorite tugma
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        // Favorite tugma
                        if (widget.onFavoriteToggle != null)
                          _buildFavoriteButton(),

                        const SizedBox(height: 8),

                        // Arab nomi
                        Text(
                          widget.surah.nomiArab,
                          style: TextStyle(
                            fontFamily: 'Amiri',
                            fontSize: ResponsiveUtils.isMobile(context) ? 18 : 22,
                            color: AppColors.deepGreen,
                            fontWeight: FontWeight.bold,
                            height: 1.2,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildSurahNumber(ThemeData theme) {
    return Container(
      height: 50,
      width: 50,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.deepGreen,
            AppColors.deepGreen.withOpacity(0.8),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.deepGreen.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Center(
        child: Text(
          '${widget.surah.id}',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _buildSurahInfo(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.surah.nomiLotin,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: ResponsiveUtils.isMobile(context) ? 16 : 18,
            color: theme.colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            _buildInfoChip(
              '${widget.surah.oyatlarSoni} oyat',
              Icons.format_list_numbered_rounded,
              theme,
            ),
            const SizedBox(width: 8),
            _buildInfoChip(
              widget.surah.joyi,
              widget.surah.joyi == 'Makka'
                  ? Icons.location_city_rounded
                  : Icons.apartment_rounded,
              theme,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildInfoChip(String text, IconData icon, ThemeData theme) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 12,
            color: theme.colorScheme.onSurfaceVariant,
          ),
          const SizedBox(width: 4),
          Text(
            text,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
              fontSize: 10,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFavoriteButton() {
    return GestureDetector(
      onTap: widget.onFavoriteToggle,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: widget.isFavorite
              ? AppColors.deepGreen.withOpacity(0.1)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 200),
          child: Icon(
            widget.isFavorite
                ? Icons.favorite_rounded
                : Icons.favorite_border_rounded,
            key: ValueKey(widget.isFavorite),
            size: 20,
            color: widget.isFavorite
                ? AppColors.deepGreen
                : Colors.grey.shade400,
          ),
        ),
      ),
    );
  }
}