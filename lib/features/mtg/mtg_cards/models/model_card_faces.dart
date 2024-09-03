import 'package:collectors_bank/features/mtg/mtg_cards/models/model_image_uris.dart';
import 'package:collectors_bank/utils/helpers/helper_functions.dart';

class CardFaces {
  final String artist;
  final String artist_id;
  final double cmc;
  final List<String> color_indicator;
  final List<String> colors;
  final String defense;
  final String flavor_text;
  final String illustration_id;
  final ImageUris image_uris;
  final String layout;
  final String loyalty;
  final String mana_cost;
  final String name;
  final String object;
  final String oracle_id;
  final String oracle_text;
  final String power;
  final String printed_name;
  final String printed_text;
  final String printed_type_line;
  final String toughness;
  final String type_line;
  final String watermark;

  CardFaces(
      {required this.artist,
      required this.artist_id,
      required this.cmc,
      required this.color_indicator,
      required this.colors,
      required this.defense,
      required this.flavor_text,
      required this.illustration_id,
      required this.image_uris,
      required this.layout,
      required this.loyalty,
      required this.mana_cost,
      required this.name,
      required this.object,
      required this.oracle_id,
      required this.oracle_text,
      required this.power,
      required this.printed_name,
      required this.printed_text,
      required this.printed_type_line,
      required this.toughness,
      required this.type_line,
      required this.watermark});

  static CardFaces fromJson(Map<String, Object?> json) => CardFaces(
      artist: CollectorsBankHelperFunctions.checkIfStringNull(json["artist"]),
      artist_id:
          CollectorsBankHelperFunctions.checkIfStringNull(json["artist_id"]),
      cmc: CollectorsBankHelperFunctions.checkIfDoubleNull(json["cmc"]),
      color_indicator: CollectorsBankHelperFunctions.addListString(
          json["color_indicator"] as List?),
      colors:
          CollectorsBankHelperFunctions.addListString(json["colors"] as List?),
      defense: CollectorsBankHelperFunctions.checkIfStringNull(json["defense"]),
      flavor_text:
          CollectorsBankHelperFunctions.checkIfStringNull(json["flavor_text"]),
      illustration_id: CollectorsBankHelperFunctions.checkIfStringNull(
          json["illustration_id"]),
      image_uris: ImageUris.fromJson(json["image_uris"] as dynamic),
      layout: CollectorsBankHelperFunctions.checkIfStringNull(json["layout"]),
      loyalty: CollectorsBankHelperFunctions.checkIfStringNull(json["loyalty"]),
      mana_cost:
          CollectorsBankHelperFunctions.checkIfStringNull(json["mana_cost"]),
      name: CollectorsBankHelperFunctions.checkIfStringNull(json["name"]),
      object: CollectorsBankHelperFunctions.checkIfStringNull(json["object"]),
      oracle_id:
          CollectorsBankHelperFunctions.checkIfStringNull(json["oracle_id"]),
      oracle_text:
          CollectorsBankHelperFunctions.checkIfStringNull(json["oracle_text"]),
      power: CollectorsBankHelperFunctions.checkIfStringNull(json["power"]),
      printed_name:
          CollectorsBankHelperFunctions.checkIfStringNull(json["printed_name"]),
      printed_text:
          CollectorsBankHelperFunctions.checkIfStringNull(json["printed_text"]),
      printed_type_line: CollectorsBankHelperFunctions.checkIfStringNull(
          json["printed_type_line"]),
      toughness:
          CollectorsBankHelperFunctions.checkIfStringNull(json["toughness"]),
      type_line:
          CollectorsBankHelperFunctions.checkIfStringNull(json["type_line"]),
      watermark:
          CollectorsBankHelperFunctions.checkIfStringNull(json["watermark"]));
}
