import 'package:flutter/material.dart';

const String tableSets = 'sets';

class MTGSetFields {
  static final List<String> values = [name, code, date, is_promo];

  static const String name = 'Nname';
  static const String code = 'Ncode';
  static const String date = 'Ndate';
  static const String is_promo = 'Nis_promo';
}

class MTGSet {
  final String name;
  final String code;
  final String date;
  final String is_promo;

  MTGSet(
      {required this.name,
      required this.code,
      required this.date,
      required this.is_promo});

  static MTGSet fromJson(Map<String, Object?> json) => MTGSet(
      name: json[MTGSetFields.name] as String,
      code: json[MTGSetFields.code] as String,
      date: json[MTGSetFields.date] as String,
      is_promo: json[MTGSetFields.is_promo] as String);
}
