import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/responsive/responsive.dart';

class CustomSearchField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final VoidCallback? onClear;
  final Function(String)? onChanged;
  final bool showFilter;
  final VoidCallback? onFilterTap;

  const CustomSearchField({
    super.key,
    required this.controller,
    this.hintText = 'Qidiruv...',
    this.onClear,
    this.onChanged,
    this.showFilter = false,
    this.onFilterTap,
  });

  @override
  State<CustomSearchField> createState() => _CustomSearchFieldState();
}

class _CustomSearchFieldState extends State<CustomSearchField>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  bool _isFocused = false;
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.02,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
      if (_isFocused) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    });

    widget.controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    _focusNode.dispose();
    super.dispose();
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
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              gradient: _isFocused
                  ? LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  AppColors.deepGreen.withOpacity(0.05),
                  AppColors.deepGreen.withOpacity(0.02),
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
                color: _isFocused
                    ? AppColors.deepGreen.withOpacity(0.3)
                    : theme.colorScheme.outline.withOpacity(0.1),
                width: _isFocused ? 2 : 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: _isFocused
                      ? AppColors.deepGreen.withOpacity(0.1)
                      : (isDark
                      ? Colors.black.withOpacity(0.3)
                      : Colors.grey.withOpacity(0.1)),
                  blurRadius: _isFocused ? 16 : 8,
                  offset: Offset(0, _isFocused ? 4 : 2),
                  spreadRadius: 0,
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
              child: Row(
                children: [
                  // Search Icon
                  _buildSearchIcon(theme),

                  // Text Field
                  Expanded(
                    child: _buildTextField(theme),
                  ),

                  // Clear Button
                  if (widget.controller.text.isNotEmpty)
                    _buildClearButton(theme),

                  // Filter Button
                  if (widget.showFilter)
                    _buildFilterButton(theme),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildSearchIcon(ThemeData theme) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.only(left: 4),
      decoration: BoxDecoration(
        color: _isFocused
            ? AppColors.deepGreen.withOpacity(0.1)
            : theme.colorScheme.surfaceVariant.withOpacity(0.5),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Icon(
        Icons.search_rounded,
        size: 20,
        color: _isFocused
            ? AppColors.deepGreen
            : theme.colorScheme.onSurfaceVariant,
      ),
    );
  }

  Widget _buildTextField(ThemeData theme) {
    return TextField(
      controller: widget.controller,
      focusNode: _focusNode,
      onChanged: widget.onChanged,
      textInputAction: TextInputAction.search,
      onSubmitted: (value) {
        FocusScope.of(context).unfocus();
      },
      style: theme.textTheme.bodyLarge?.copyWith(
        fontSize: ResponsiveUtils.isMobile(context) ? 16 : 18,
        color: theme.colorScheme.onSurface,
      ),
      decoration: InputDecoration(
        fillColor: Colors.transparent,
        hintText: widget.hintText,
        hintStyle: theme.textTheme.bodyLarge?.copyWith(
          fontSize: ResponsiveUtils.isMobile(context) ? 16 : 18,
          color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
        ),
        border: InputBorder.none,
        enabledBorder: InputBorder.none,
        focusedBorder: InputBorder.none,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
      ),
    );
  }

  Widget _buildClearButton(ThemeData theme) {
    return AnimatedScale(
      scale: widget.controller.text.isNotEmpty ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 200),
      child: GestureDetector(
        onTap: () {
          widget.controller.clear();
          FocusScope.of(context).unfocus();
          widget.onClear?.call();
        },
        child: Container(
          padding: const EdgeInsets.all(8),
          margin: const EdgeInsets.only(right: 4),
          decoration: BoxDecoration(
            color: theme.colorScheme.errorContainer.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(
            Icons.close_rounded,
            size: 16,
            color: theme.colorScheme.error,
          ),
        ),
      ),
    );
  }

  Widget _buildFilterButton(ThemeData theme) {
    return GestureDetector(
      onTap: widget.onFilterTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.only(right: 4),
        decoration: BoxDecoration(
          color: theme.colorScheme.secondaryContainer.withOpacity(0.5),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Icon(
          Icons.tune_rounded,
          size: 20,
          color: theme.colorScheme.onSecondaryContainer,
        ),
      ),
    );
  }
}