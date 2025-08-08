import 'package:flutter/foundation.dart';

@immutable
class Surah {
  final int id;
  final String nomiLotin;
  final String nomiArab;
  final int oyatlarSoni;
  final String joyi;
  final int tartibRaqami;
  final String haqida;

  const Surah({
    required this.id,
    required this.nomiLotin,
    required this.nomiArab,
    required this.oyatlarSoni,
    required this.joyi,
    required this.tartibRaqami,
    required this.haqida,
  });

  factory Surah.fromJson(Map<String, dynamic> json) {
    return Surah(
      id: json['id'] as int,
      nomiLotin: json['nomi_lotin'] as String,
      nomiArab: json['nomi_arab'] as String,
      oyatlarSoni: json['oyatlar_soni'] as int,
      joyi: json['joyi'] as String,
      tartibRaqami: json['tartib_raqami'] as int,
      haqida: json['haqida'] as String,
    );
  }
}