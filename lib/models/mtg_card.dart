import 'package:flutter/material.dart';

const String tableCards = 'cards';

class MTGCardFields {
  static final List<String> values = [
    id,
    name,
    set,
    type,
    rarity,
    manacost,
    converted_manacost,
    power,
    toughness,
    loyalty,
    ability,
    flavor,
    variation,
    artist,
    number,
    rating,
    ruling,
    color,
    generated_mana,
    pricing_EUR,
    pricing_USD,
    pricing_TIX,
    back_id,
    watermark,
    print_number,
    is_original,
    color_identity
  ];

  static const String id = 'Nid';
  static const String name = 'Nname';
  static const String set = 'Nset';
  static const String type = 'Ntype';
  static const String rarity = 'Nrarity';
  static const String manacost = 'Nmanacost';
  static const String converted_manacost = 'Nconverted_manacost';
  static const String power = 'Npower';
  static const String toughness = 'Ntoughness';
  static const String loyalty = 'Nloyalty';
  static const String ability = 'Nability';
  static const String flavor = 'Nflavor';
  static const String variation = 'Nvariation';
  static const String artist = 'Nartist';
  static const String number = 'Nnumber';
  static const String rating = 'Nrating';
  static const String ruling = 'Nruling';
  static const String color = 'Ncolor';
  static const String generated_mana = 'Ngenerated_mana';
  static const String pricing_EUR = 'Npricing_EUR';
  static const String pricing_USD = 'Npricing_USD';
  static const String pricing_TIX = 'Npricing_TIX';
  static const String back_id = 'Nback_id';
  static const String watermark = 'Nwatermark';
  static const String print_number = 'Nprint_number';
  static const String is_original = 'Nis_original';
  static const String color_identity = 'Ncolor_identity';
}

class MTGCard {
  final String? id;
  final String name;
  final String set;
  final String type;
  final String rarity;
  final String manacost;
  final String converted_manacost;
  final String power;
  final String toughness;
  final String loyalty;
  final String ability;
  final String flavor;
  final String variation;
  final String artist;
  final String number;
  final String rating;
  final String ruling;
  final String color;
  final String generated_mana;
  final String pricing_EUR;
  final String pricing_USD;
  final String pricing_TIX;
  final String back_id;
  final String watermark;
  final String print_number;
  final String is_original;
  final String color_identity;

  MTGCard(
      {this.id,
      required this.name,
      required this.set,
      required this.type,
      required this.rarity,
      required this.manacost,
      required this.converted_manacost,
      required this.power,
      required this.toughness,
      required this.loyalty,
      required this.ability,
      required this.flavor,
      required this.variation,
      required this.artist,
      required this.number,
      required this.rating,
      required this.ruling,
      required this.color,
      required this.generated_mana,
      required this.pricing_EUR,
      required this.pricing_USD,
      required this.pricing_TIX,
      required this.back_id,
      required this.watermark,
      required this.print_number,
      required this.is_original,
      required this.color_identity});

  static MTGCard fromJson(Map<String, Object?> json) => MTGCard(
      id: json[MTGCardFields.id] as String,
      name: json[MTGCardFields.name] as String,
      set: json[MTGCardFields.set] as String,
      type: json[MTGCardFields.type] as String,
      rarity: json[MTGCardFields.rarity] as String,
      manacost: json[MTGCardFields.manacost] as String,
      converted_manacost: json[MTGCardFields.converted_manacost] as String,
      power: json[MTGCardFields.power] as String,
      toughness: json[MTGCardFields.toughness] as String,
      loyalty: json[MTGCardFields.loyalty] as String,
      ability: json[MTGCardFields.ability] as String,
      flavor: json[MTGCardFields.flavor] as String,
      variation: json[MTGCardFields.variation] as String,
      artist: json[MTGCardFields.artist] as String,
      number: json[MTGCardFields.number] as String,
      rating: json[MTGCardFields.rating] as String,
      ruling: json[MTGCardFields.ruling] as String,
      color: json[MTGCardFields.color] as String,
      generated_mana: json[MTGCardFields.generated_mana] as String,
      pricing_EUR: json[MTGCardFields.pricing_EUR] as String,
      pricing_USD: json[MTGCardFields.pricing_USD] as String,
      pricing_TIX: json[MTGCardFields.pricing_TIX] as String,
      back_id: json[MTGCardFields.back_id] as String,
      watermark: json[MTGCardFields.watermark] as String,
      print_number: json[MTGCardFields.print_number] as String,
      is_original: json[MTGCardFields.is_original] as String,
      color_identity: json[MTGCardFields.color_identity] as String);
}
