import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/utils/responsive/responsive.dart';
import '../models/surah_model.dart';
import '../providers/surah_provider.dart';
import '../widgets/surah_card.dart';

class SurahsScreen extends ConsumerStatefulWidget {
  const SurahsScreen({super.key});

  @override
  ConsumerState<SurahsScreen> createState() => _SurahsScreenState();
}

class _SurahsScreenState extends ConsumerState<SurahsScreen> {
  final _searchController = TextEditingController();
  List<Surah> _allSurahs = [];
  List<Surah> _filteredSurahs = [];

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_filterSurahs);
  }

  @override
  void dispose() {
    _searchController.removeListener(_filterSurahs);
    _searchController.dispose();
    super.dispose();
  }

  void _filterSurahs() {
    final query = _searchController.text.toLowerCase().trim();
    if (query.isEmpty) {
      setState(() {
        _filteredSurahs = _allSurahs;
      });
      return;
    }

    setState(() {
      _filteredSurahs = _allSurahs.where((surah) {
        final nomLotin = surah.nomiLotin.toLowerCase();
        final nomArab = surah.nomiArab;
        final id = surah.id.toString();

        return nomLotin.contains(query) ||
            nomArab.contains(query) ||
            id.contains(query);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final surahsAsyncValue = ref.watch(surahsProvider);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Barcha Suralar'),
        elevation: 0,
      ),
      body: surahsAsyncValue.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Xatolik: $err')),
        data: (surahs) {
          if (_allSurahs.isEmpty) {
            _allSurahs = surahs;
            _filteredSurahs = surahs;
          }

          return Padding(
            padding: ResponsivePadding.responsive(context).copyWith(top: 0),
            child: Column(
              children: [
                // Qidiruv Maydoni
                TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Sura nomi yoki raqamini yozing...',
                    prefixIcon: Icon(
                      Icons.search,
                      color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                    ),
                  ),
                ),
                ResponsiveSpacing.vMD,

                Expanded(
                  child: ListView.separated(
                    itemCount: _filteredSurahs.length,
                    separatorBuilder: (context, index) => ResponsiveSpacing.vSM,
                    itemBuilder: (context, index) {
                      final surah = _filteredSurahs[index];
                      return SurahCard(
                        surah: surah,
                        onTap: () {
                          // Navigator.push(context, MaterialPageRoute(builder: (c) => AyatScreen(surah: surah)));
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}