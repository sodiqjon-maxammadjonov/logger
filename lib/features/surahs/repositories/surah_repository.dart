import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/surah_model.dart';

class SurahRepository {
  Future<List<Surah>> getAllSurahs() async {
    try {
      final jsonString = await rootBundle.loadString('assets/surah/surah.json');

      final List<dynamic> jsonList = json.decode(jsonString);

      return jsonList.map((jsonItem) => Surah.fromJson(jsonItem)).toList();
    } catch (e) {
      throw Exception('Suralarni yuklashda xatolik: $e');
    }
  }
}
