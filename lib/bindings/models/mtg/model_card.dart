import 'package:collectors_bank/utils/helpers/helper_functions.dart';

const String tableCards = 'cards';

class ModelMtgCardFields {
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

class ModelMtgCard {
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

  ModelMtgCard(
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

  static ModelMtgCard fromJson(Map<String, Object?> json) => ModelMtgCard(
      id: json[ModelMtgCardFields.id] as String,
      name: json[ModelMtgCardFields.name] as String,
      set: json[ModelMtgCardFields.set] as String,
      type: json[ModelMtgCardFields.type] as String,
      rarity: json[ModelMtgCardFields.rarity] as String,
      manacost: CollectorsBankHelperFunctions.checkIfStringNull(
          json[ModelMtgCardFields.manacost]),
      converted_manacost: CollectorsBankHelperFunctions.checkIfStringNull(
          json[ModelMtgCardFields.converted_manacost]),
      power: CollectorsBankHelperFunctions.checkIfStringNull(
          json[ModelMtgCardFields.power]),
      toughness: CollectorsBankHelperFunctions.checkIfStringNull(
          json[ModelMtgCardFields.toughness]),
      loyalty: CollectorsBankHelperFunctions.checkIfStringNull(
          json[ModelMtgCardFields.loyalty]),
      ability: CollectorsBankHelperFunctions.checkIfStringNull(
          json[ModelMtgCardFields.ability]),
      flavor: CollectorsBankHelperFunctions.checkIfStringNull(
          json[ModelMtgCardFields.flavor]),
      variation: CollectorsBankHelperFunctions.checkIfStringNull(
          json[ModelMtgCardFields.variation]),
      artist: CollectorsBankHelperFunctions.checkIfStringNull(json[ModelMtgCardFields.artist]),
      number: CollectorsBankHelperFunctions.checkIfStringNull(json[ModelMtgCardFields.number]),
      rating: CollectorsBankHelperFunctions.checkIfStringNull(json[ModelMtgCardFields.rating]),
      ruling: CollectorsBankHelperFunctions.checkIfStringNull(json[ModelMtgCardFields.ruling]),
      color: CollectorsBankHelperFunctions.checkIfStringNull(json[ModelMtgCardFields.color]),
      generated_mana: CollectorsBankHelperFunctions.checkIfStringNull(json[ModelMtgCardFields.generated_mana]),
      pricing_EUR: CollectorsBankHelperFunctions.checkIfStringNull(json[ModelMtgCardFields.pricing_EUR]),
      pricing_USD: CollectorsBankHelperFunctions.checkIfStringNull(json[ModelMtgCardFields.pricing_USD]),
      pricing_TIX: CollectorsBankHelperFunctions.checkIfStringNull(json[ModelMtgCardFields.pricing_TIX]),
      back_id: CollectorsBankHelperFunctions.checkIfStringNull(json[ModelMtgCardFields.back_id]),
      watermark: CollectorsBankHelperFunctions.checkIfStringNull(json[ModelMtgCardFields.watermark]),
      print_number: CollectorsBankHelperFunctions.checkIfStringNull(json[ModelMtgCardFields.print_number]),
      is_original: CollectorsBankHelperFunctions.checkIfStringNull(json[ModelMtgCardFields.is_original]),
      color_identity: CollectorsBankHelperFunctions.checkIfStringNull(json[ModelMtgCardFields.color_identity]),
      image: CollectorsBankHelperFunctions.checkIfStringNull(json[ModelMtgCardFields.image]));
}
