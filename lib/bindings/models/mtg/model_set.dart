import 'package:collectors_bank/utils/helpers/helper_functions.dart';

class ModelMtgSetFields {
  static final List<String> values = [
    object,
    id,
    code,
    mtgo_code,
    arena_code,
    tcgplayer_id,
    name,
    uri,
    scryfall_uri,
    search_uri,
    released_at,
    set_type,
    card_count,
    printed_size,
    digital,
    nonfoil_only,
    foil_only,
    block_code,
    block,
    icon_svg_uri
  ];

  static const String object = 'object';
  static const String id = 'id';
  static const String code = 'code';
  static const String mtgo_code = 'mtgo_code';
  static const String arena_code = 'arena_code';
  static const String tcgplayer_id = 'tcgplayer_id';
  static const String name = 'name';
  static const String uri = 'uri';
  static const String scryfall_uri = 'scryfall_uri';
  static const String search_uri = 'search_uri';
  static const String released_at = 'released_at';
  static const String set_type = 'set_type';
  static const String card_count = 'card_count';
  static const String printed_size = 'printed_size';
  static const String parent_set_code = 'parent_set_code';
  static const String digital = 'digital';
  static const String nonfoil_only = 'nonfoil_only';
  static const String foil_only = 'foil_only';
  static const String block_code = 'block_code';
  static const String block = 'block';
  static const String icon_svg_uri = 'icon_svg_uri';
}

class ModelMtgSet {
  final String object;
  final String id;
  final String code;
  // final String mtgo_code;
  // final String arena_code;
  // final int tcgplayer_id;
  final String name;
  final String uri;
  final String scryfall_uri;
  final String search_uri;
  final String released_at;
  final String set_type;
  final int card_count;
  // final int printed_size;
  final String parent_set_code;
  final bool digital;
  final bool nonfoil_only;
  final bool foil_only;
  // final String block_code;
  // final String block;
  final String icon_svg_uri;

  ModelMtgSet(
      {required this.object,
      required this.id,
      required this.code,
      // required this.mtgo_code,
      // required this.arena_code,
      // required this.tcgplayer_id,
      required this.name,
      required this.uri,
      required this.scryfall_uri,
      required this.search_uri,
      required this.released_at,
      required this.set_type,
      required this.card_count,
      // required this.printed_size,
      required this.parent_set_code,
      required this.digital,
      required this.nonfoil_only,
      required this.foil_only,
      // required this.block_code,
      // required this.block,
      required this.icon_svg_uri});

  static ModelMtgSet fromJson(Map<String, Object?> json) => ModelMtgSet(
      object: CollectorsBankHelperFunctions.checkIfStringNull(
          json[ModelMtgSetFields.object]),
      id: CollectorsBankHelperFunctions.checkIfStringNull(
          json[ModelMtgSetFields.id]),
      code: CollectorsBankHelperFunctions.checkIfStringNull(
          json[ModelMtgSetFields.code]),
      // mtgo_code: CollectorsBankHelperFunctions.checkIfStringNull(
      //     json[ModelMtgSetFields.mtgo_code]),
      // arena_code: CollectorsBankHelperFunctions.checkIfStringNull(
      //     json[ModelMtgSetFields.arena_code]),
      // tcgplayer_id: CollectorsBankHelperFunctions.checkIfIntNull(
      //     json[ModelMtgSetFields.tcgplayer_id]),
      name: CollectorsBankHelperFunctions.checkIfStringNull(
          json[ModelMtgSetFields.name]),
      uri: CollectorsBankHelperFunctions.checkIfStringNull(
          json[ModelMtgSetFields.uri]),
      scryfall_uri: CollectorsBankHelperFunctions.checkIfStringNull(
          json[ModelMtgSetFields.scryfall_uri]),
      search_uri: CollectorsBankHelperFunctions.checkIfStringNull(
          json[ModelMtgSetFields.search_uri]),
      released_at: CollectorsBankHelperFunctions.checkIfStringNull(
          json[ModelMtgSetFields.released_at]),
      set_type: CollectorsBankHelperFunctions.checkIfStringNull(
          json[ModelMtgSetFields.set_type]),
      card_count: json[ModelMtgSetFields.card_count] as int,
      // printed_size: CollectorsBankHelperFunctions.checkIfIntNull(
      //     json[ModelMtgSetFields.printed_size]),
      parent_set_code: CollectorsBankHelperFunctions.checkIfStringNull(
          json[ModelMtgSetFields.parent_set_code]),
      digital: json[ModelMtgSetFields.digital] as bool,
      nonfoil_only: json[ModelMtgSetFields.nonfoil_only] as bool,
      foil_only: json[ModelMtgSetFields.foil_only] as bool,
      // block_code: CollectorsBankHelperFunctions.checkIfStringNull(
      //     json[ModelMtgSetFields.block_code]),
      // block: CollectorsBankHelperFunctions.checkIfStringNull(
      //     json[ModelMtgSetFields.block]),
      icon_svg_uri: CollectorsBankHelperFunctions.checkIfStringNull(
          json[ModelMtgSetFields.icon_svg_uri]));
}
