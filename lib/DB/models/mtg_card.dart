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
    color_identity,
    image
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
  static const String image = 'image';
}

class MTGCard {
  final String id;
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
  final String image;

  MTGCard(
      {required this.id,
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
      required this.color_identity,
      required this.image});

  static MTGCard fromJson(Map<String, Object?> json) => MTGCard(
      id: json[MTGCardFields.id] as String,
      name: json[MTGCardFields.name] as String,
      set: json[MTGCardFields.set] as String,
      type: json[MTGCardFields.type] as String,
      rarity: json[MTGCardFields.rarity] as String,
      manacost: checkIfNull(json[MTGCardFields.manacost]),
      converted_manacost: checkIfNull(json[MTGCardFields.converted_manacost]),
      power: checkIfNull(json[MTGCardFields.power]),
      toughness: checkIfNull(json[MTGCardFields.toughness]),
      loyalty: checkIfNull(json[MTGCardFields.loyalty]),
      ability: checkIfNull(json[MTGCardFields.ability]),
      flavor: checkIfNull(json[MTGCardFields.flavor]),
      variation: checkIfNull(json[MTGCardFields.variation]),
      artist: checkIfNull(json[MTGCardFields.artist]),
      number: checkIfNull(json[MTGCardFields.number]),
      rating: checkIfNull(json[MTGCardFields.rating]),
      ruling: checkIfNull(json[MTGCardFields.ruling]),
      color: checkIfNull(json[MTGCardFields.color]),
      generated_mana: checkIfNull(json[MTGCardFields.generated_mana]),
      pricing_EUR: checkIfNull(json[MTGCardFields.pricing_EUR]),
      pricing_USD: checkIfNull(json[MTGCardFields.pricing_USD]),
      pricing_TIX: checkIfNull(json[MTGCardFields.pricing_TIX]),
      back_id: checkIfNull(json[MTGCardFields.back_id]),
      watermark: checkIfNull(json[MTGCardFields.watermark]),
      print_number: checkIfNull(json[MTGCardFields.print_number]),
      is_original: checkIfNull(json[MTGCardFields.is_original]),
      color_identity: checkIfNull(json[MTGCardFields.color_identity]),
      image: checkIfNull(json[MTGCardFields.image]));

  static String checkIfNull(Object? item) {
    if (item == null) {
      return '';
    } else {
      return item as String;
    }
  }
}
