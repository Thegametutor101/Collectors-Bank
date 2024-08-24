import 'package:collectors_bank/utils/helpers/helper_functions.dart';

class ModelMtgSet {
  final String object;
  final String id;
  final String code;
  final String name;
  final String uri;
  final String scryfall_uri;
  final String search_uri;
  final String released_at;
  final String set_type;
  final int card_count;
  final String parent_set_code;
  final bool digital;
  final bool nonfoil_only;
  final bool foil_only;
  final String icon_svg_uri;

  ModelMtgSet(
      {required this.object,
      required this.id,
      required this.code,
      required this.name,
      required this.uri,
      required this.scryfall_uri,
      required this.search_uri,
      required this.released_at,
      required this.set_type,
      required this.card_count,
      required this.parent_set_code,
      required this.digital,
      required this.nonfoil_only,
      required this.foil_only,
      required this.icon_svg_uri});

  static ModelMtgSet fromJson(Map<String, Object?> json) => ModelMtgSet(
      object: json["object"] as String,
      id: json["id"] as String,
      code: json["code"] as String,
      name: json["name"] as String,
      uri: json["uri"] as String,
      scryfall_uri: json["scryfall_uri"] as String,
      search_uri: json["search_uri"] as String,
      released_at:
          CollectorsBankHelperFunctions.checkIfStringNull(json["released_at"]),
      set_type: json["set_type"] as String,
      card_count: json["card_count"] as int,
      parent_set_code: CollectorsBankHelperFunctions.checkIfStringNull(
          json["parent_set_code"]),
      digital: json["digital"] as bool,
      nonfoil_only: json["nonfoil_only"] as bool,
      foil_only: json["foil_only"] as bool,
      icon_svg_uri: json["icon_svg_uri"] as String);
}
