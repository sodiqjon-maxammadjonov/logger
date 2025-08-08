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
  final bool isFavorite;

  const Surah({
    required this.id,
    required this.nomiLotin,
    required this.nomiArab,
    required this.oyatlarSoni,
    required this.joyi,
    required this.tartibRaqami,
    required this.haqida,
    this.isFavorite = false,
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
      isFavorite: json['is_favorite'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nomi_lotin': nomiLotin,
      'nomi_arab': nomiArab,
      'oyatlar_soni': oyatlarSoni,
      'joyi': joyi,
      'tartib_raqami': tartibRaqami,
      'haqida': haqida,
      'is_favorite': isFavorite,
    };
  }

  // CopyWith metodi - favorite holatini o'zgartirish uchun
  Surah copyWith({
    int? id,
    String? nomiLotin,
    String? nomiArab,
    int? oyatlarSoni,
    String? joyi,
    int? tartibRaqami,
    String? haqida,
    bool? isFavorite,
  }) {
    return Surah(
      id: id ?? this.id,
      nomiLotin: nomiLotin ?? this.nomiLotin,
      nomiArab: nomiArab ?? this.nomiArab,
      oyatlarSoni: oyatlarSoni ?? this.oyatlarSoni,
      joyi: joyi ?? this.joyi,
      tartibRaqami: tartibRaqami ?? this.tartibRaqami,
      haqida: haqida ?? this.haqida,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Surah &&
        other.id == id &&
        other.nomiLotin == nomiLotin &&
        other.nomiArab == nomiArab &&
        other.oyatlarSoni == oyatlarSoni &&
        other.joyi == joyi &&
        other.tartibRaqami == tartibRaqami &&
        other.haqida == haqida &&
        other.isFavorite == isFavorite;
  }

  @override
  int get hashCode {
    return Object.hash(
      id,
      nomiLotin,
      nomiArab,
      oyatlarSoni,
      joyi,
      tartibRaqami,
      haqida,
      isFavorite,
    );
  }
}