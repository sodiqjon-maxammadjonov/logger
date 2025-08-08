import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/responsive/responsive.dart';
import '../models/surah_model.dart';
import '../providers/surah_provider.dart';
import '../widgets/surah_card.dart';
import '../widgets/custom_search_field.dart';

class SurahsScreen extends ConsumerStatefulWidget {
  const SurahsScreen({super.key});

  @override
  ConsumerState<SurahsScreen> createState() => _SurahsScreenState();
}

class _SurahsScreenState extends ConsumerState<SurahsScreen>
    with TickerProviderStateMixin {
  final _searchController = TextEditingController();
  late AnimationController _listAnimationController;
  late Animation<double> _listAnimation;

  List<Surah> _allSurahs = [];
  List<Surah> _filteredSurahs = [];
  bool _showFavoritesOnly = false;
  Set<int> _favoriteIds = {}; // Bu yerda favorite sura ID larini saqlaysiz

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_filterSurahs);

    _listAnimationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _listAnimation = CurvedAnimation(
      parent: _listAnimationController,
      curve: Curves.easeOutCubic,
    );
  }

  @override
  void dispose() {
    _searchController.removeListener(_filterSurahs);
    _searchController.dispose();
    _listAnimationController.dispose();
    super.dispose();
  }

  void _filterSurahs() {
    final query = _searchController.text.toLowerCase().trim();
    List<Surah> baseList = _showFavoritesOnly
        ? _allSurahs.where((s) => _favoriteIds.contains(s.id)).toList()
        : _allSurahs;

    if (query.isEmpty) {
      setState(() {
        _filteredSurahs = baseList;
      });
      return;
    }

    setState(() {
      _filteredSurahs = baseList.where((surah) {
        final nomLotin = surah.nomiLotin.toLowerCase();
        final nomArab = surah.nomiArab;
        final id = surah.id.toString();

        return nomLotin.contains(query) ||
            nomArab.contains(query) ||
            id.contains(query);
      }).toList();
    });
  }

  void _toggleFavorite(int surahId) {
    setState(() {
      if (_favoriteIds.contains(surahId)) {
        _favoriteIds.remove(surahId);
      } else {
        _favoriteIds.add(surahId);
      }
    });
    _filterSurahs(); // Filterni qayta ishlatish
  }

  void _toggleFavoritesFilter() {
    setState(() {
      _showFavoritesOnly = !_showFavoritesOnly;
    });
    _filterSurahs();
  }

  @override
  Widget build(BuildContext context) {
    final surahsAsyncValue = ref.watch(surahsProvider);
    final theme = Theme.of(context);

    return GestureDetector(
        onTap: () {
          // Search fieldni unfocus qilish
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          backgroundColor: theme.colorScheme.background,
          body: CustomScrollView(
            slivers: [
              // Custom App Bar
              SliverAppBar(
                expandedHeight: 120,
                floating: true,
                pinned: true,
                backgroundColor: theme.colorScheme.surface,
                elevation: 0,
                flexibleSpace: FlexibleSpaceBar(
                  background: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          AppColors.deepGreen.withOpacity(0.1),
                          theme.colorScheme.surface,
                        ],
                      ),
                    ),
                  ),
                  title: Text(
                    'Barcha Suralar',
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                ),
                leading: IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.surface.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      Icons.arrow_back_ios_rounded,
                      size: 18,
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                ),
                actions: [
                  // Favorites filter button
                  IconButton(
                    onPressed: _toggleFavoritesFilter,
                    icon: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: _showFavoritesOnly
                            ? AppColors.deepGreen.withOpacity(0.2)
                            : theme.colorScheme.surface.withOpacity(0.9),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        _showFavoritesOnly
                            ? Icons.favorite_rounded
                            : Icons.favorite_border_rounded,
                        size: 18,
                        color: _showFavoritesOnly
                            ? AppColors.deepGreen
                            : theme.colorScheme.onSurface,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                ],
              ),

              // Search Field
              SliverToBoxAdapter(
                child: CustomSearchField(
                  controller: _searchController,
                  hintText: 'Sura nomi yoki raqamini yozing...',
                  showFilter: true,
                  onFilterTap: () {
                    // Filter dialog yoki bottom sheet ochish
                    _showFilterBottomSheet(context);
                  },
                  onClear: () {
                    _filterSurahs();
                  },
                ),
              ),

              // Content
              surahsAsyncValue.when(
                loading: () => const SliverFillRemaining(
                  child: Center(child: CircularProgressIndicator()),
                ),
                error: (err, stack) => SliverFillRemaining(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.error_outline_rounded,
                          size: 64,
                          color: theme.colorScheme.error,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Xatolik yuz berdi',
                          style: theme.textTheme.titleLarge,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '$err',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.colorScheme.onSurface.withOpacity(0.6),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
                data: (surahs) {
                  if (_allSurahs.isEmpty) {
                    _allSurahs = surahs;
                    _filteredSurahs = surahs;
                    _listAnimationController.forward();
                  }

                  if (_filteredSurahs.isEmpty && _searchController.text.isNotEmpty) {
                    return SliverFillRemaining(
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.search_off_rounded,
                              size: 64,
                              color: theme.colorScheme.onSurface.withOpacity(0.3),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Hech narsa topilmadi',
                              style: theme.textTheme.titleLarge?.copyWith(
                                color: theme.colorScheme.onSurface.withOpacity(0.6),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Boshqa kalit so\'z bilan qidiring',
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: theme.colorScheme.onSurface.withOpacity(0.4),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }

                  return SliverList(
                    delegate: SliverChildBuilderDelegate(
                          (context, index) {
                        final surah = _filteredSurahs[index];
                        return AnimatedBuilder(
                          animation: _listAnimation,
                          builder: (context, child) {
                            // Har bir item uchun alohida delay qo'shamiz lekin 1.0 dan past tushmasin
                            final itemDelay = (index * 0.05).clamp(0.0, 0.5);
                            final animationValue = Curves.easeOutCubic.transform(
                              (_listAnimation.value - itemDelay).clamp(0.0, 1.0),
                            );

                            return Transform.translate(
                              offset: Offset(0, 30 * (1 - animationValue)),
                              child: Opacity(
                                opacity: animationValue.clamp(0.0, 1.0),
                                child: SurahCard(
                                  surah: surah,
                                  isFavorite: _favoriteIds.contains(surah.id),
                                  onTap: () {
                                    // Navigator.push(context, MaterialPageRoute(
                                    //   builder: (c) => AyatScreen(surah: surah)
                                    // ));
                                  },
                                  onFavoriteToggle: () => _toggleFavorite(surah.id),
                                ),
                              ),
                            );
                          },
                        );
                      },
                      childCount: _filteredSurahs.length,
                    ),
                  );
                },
              ),

              // Bottom padding
              const SliverToBoxAdapter(
                child: SizedBox(height: 32),
              ),
            ],
          ),
        ),
    );
  }

  void _showFilterBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Filtrlash',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              ListTile(
                leading: Icon(
                  _showFavoritesOnly
                      ? Icons.favorite_rounded
                      : Icons.favorite_border_rounded,
                  color: AppColors.deepGreen,
                ),
                title: const Text('Faqat sevimlilar'),
                trailing: Switch(
                  value: _showFavoritesOnly,
                  onChanged: (value) {
                    _toggleFavoritesFilter();
                    Navigator.pop(context);
                  },
                  activeColor: AppColors.deepGreen,
                ),
                onTap: () {
                  _toggleFavoritesFilter();
                  Navigator.pop(context);
                },
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}