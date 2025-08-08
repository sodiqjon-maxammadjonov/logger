import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/surah_model.dart';
import '../repositories/surah_repository.dart';

final surahRepositoryProvider = Provider<SurahRepository>(
      (ref) => SurahRepository(),
);

final surahsProvider = FutureProvider<List<Surah>>((ref) {
  final repository = ref.watch(surahRepositoryProvider);
  return repository.getAllSurahs();
});