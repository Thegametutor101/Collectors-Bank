import 'package:collectors_bank/features/mtg/mtg_cards/models/model_card_faces.dart';
import 'package:collectors_bank/features/mtg/mtg_cards/models/model_image_uris.dart';
import 'package:collectors_bank/features/mtg/mtg_cards/models/model_legalities.dart';
import 'package:collectors_bank/features/mtg/mtg_cards/models/model_prices.dart';
import 'package:collectors_bank/features/mtg/mtg_cards/models/model_purchase_uris.dart';
import 'package:collectors_bank/features/mtg/mtg_cards/models/model_related_card_objects.dart';
import 'package:collectors_bank/features/mtg/mtg_cards/models/model_related_uris.dart';
import 'package:collectors_bank/utils/helpers/helper_functions.dart';

class ModelMtgCard {
  final List<RelatedCardObjects> all_parts;
  final int arena_id;
  final String artist;
  final List<String> artist_ids;
  final List<int> attraction_lights;
  final bool booster;
  final String border_color;
  final String card_back_id;
  final List<CardFaces> card_faces;
  final int cardmarket_id;
  final double cmc;
  final String collector_number;
  final List<String> color_identity;
  final List<String> color_indicator;
  final List<String> colors;
  final bool content_warning;
  final String defense;
  final bool digital;
  final int edhrec_rank;
  final List<String> finishes;
  final String flavor_name;
  final String flavor_text;
  final bool foil;
  final String frame;
  final List<String> frame_effects;
  final bool full_art;
  final List<String> games;
  final String hand_modifier;
  final bool highres_image;
  final String id;
  final String illustration_id;
  final String image_status; //'missing','placeholder','lowres','highres_scan'
  final ImageUris image_uris;
  final List<String> keywords;
  final String lang;
  final String layout;
  final Legalities legalities; //'legal','not_legal','restricted','banned'
  final String life_modifier;
  final String loyalty;
  final String mana_cost;
  final int mtgo_id;
  final int mtgo_foil_id;
  final List<int> multiverse_ids;
  final String name;
  final bool nonfoil;
  final String object;
  final String oracle_id;
  final String oracle_text;
  final bool oversized;
  final int penny_rank;
  final String power;
  final Prices prices;
  final String printed_name;
  final String printed_text;
  final String printed_type_line;
  final String prints_search_uri;
  final List<String> produced_mana;
  final bool promo;
  final List<String> promo_types;
  final PurchaseUris purchase_uris;
  final String rarity;
  final RelatedUris related_uris;
  final String released_at;
  final bool reprint;
  final bool reserved;
  final String rulings_uri;
  final String scryfall_uri;
  final String scryfall_set_uri;
  final String security_stamp;
  final String set;
  final String set_id;
  final String set_name;
  final String set_search_uri;
  final String set_type;
  final String set_uri;
  final bool story_spotlight;
  final int tcgplayer_id;
  final int tcgplayer_etched_id;
  final bool textless;
  final String toughness;
  final String type_line;
  final String uri;
  final bool variation;
  final String variation_of;
  final String watermark;

  ModelMtgCard(
      {required this.all_parts,
      required this.arena_id,
      required this.artist,
      required this.artist_ids,
      required this.attraction_lights,
      required this.booster,
      required this.border_color,
      required this.card_back_id,
      required this.card_faces,
      required this.cardmarket_id,
      required this.cmc,
      required this.collector_number,
      required this.color_identity,
      required this.color_indicator,
      required this.colors,
      required this.content_warning,
      required this.defense,
      required this.digital,
      required this.edhrec_rank,
      required this.finishes,
      required this.flavor_name,
      required this.flavor_text,
      required this.foil,
      required this.frame,
      required this.frame_effects,
      required this.full_art,
      required this.games,
      required this.hand_modifier,
      required this.highres_image,
      required this.id,
      required this.illustration_id,
      required this.image_status,
      required this.image_uris,
      required this.keywords,
      required this.lang,
      required this.layout,
      required this.legalities,
      required this.life_modifier,
      required this.loyalty,
      required this.mana_cost,
      required this.mtgo_foil_id,
      required this.mtgo_id,
      required this.multiverse_ids,
      required this.name,
      required this.nonfoil,
      required this.object,
      required this.oracle_id,
      required this.oracle_text,
      required this.oversized,
      required this.penny_rank,
      required this.power,
      required this.prices,
      required this.printed_name,
      required this.printed_text,
      required this.printed_type_line,
      required this.prints_search_uri,
      required this.produced_mana,
      required this.promo,
      required this.promo_types,
      required this.purchase_uris,
      required this.rarity,
      required this.related_uris,
      required this.released_at,
      required this.reprint,
      required this.reserved,
      required this.rulings_uri,
      required this.scryfall_set_uri,
      required this.scryfall_uri,
      required this.security_stamp,
      required this.set,
      required this.set_id,
      required this.set_name,
      required this.set_search_uri,
      required this.set_type,
      required this.set_uri,
      required this.story_spotlight,
      required this.tcgplayer_etched_id,
      required this.tcgplayer_id,
      required this.textless,
      required this.toughness,
      required this.type_line,
      required this.uri,
      required this.variation,
      required this.variation_of,
      required this.watermark});

  static ModelMtgCard fromJson(Map<String, Object?> json) => ModelMtgCard(
      all_parts: _loopRelatedCardObjects(json["all_parts"] as List<dynamic>?),
      arena_id: CollectorsBankHelperFunctions.checkIfIntNull(json["arena_id"]),
      artist: CollectorsBankHelperFunctions.checkIfStringNull(json["artist"]),
      artist_ids: CollectorsBankHelperFunctions.addListString(
          json["artist_ids"] as List?),
      attraction_lights: CollectorsBankHelperFunctions.addListInt(
          json["attraction_lights"] as List?),
      booster: CollectorsBankHelperFunctions.checkIfBoolNull(json["booster"]),
      border_color:
          CollectorsBankHelperFunctions.checkIfStringNull(json["border_color"]),
      card_back_id:
          CollectorsBankHelperFunctions.checkIfStringNull(json["card_back_id"]),
      card_faces: _loopCardFaces(json["card_faces"] as List<dynamic>?),
      cardmarket_id:
          CollectorsBankHelperFunctions.checkIfIntNull(json["cardmarket_id"]),
      cmc: CollectorsBankHelperFunctions.checkIfDoubleNull(json["cmc"]),
      collector_number: CollectorsBankHelperFunctions.checkIfStringNull(
          json["collector_number"]),
      color_identity: CollectorsBankHelperFunctions.addListString(
          json["color_identity"] as List?),
      color_indicator: CollectorsBankHelperFunctions.addListString(
          json["color_indicator"] as List?),
      colors:
          CollectorsBankHelperFunctions.addListString(json["colors"] as List?),
      content_warning: CollectorsBankHelperFunctions.checkIfBoolNull(
          json["content_warning"]),
      defense: CollectorsBankHelperFunctions.checkIfStringNull(json["defense"]),
      digital: CollectorsBankHelperFunctions.checkIfBoolNull(json["digital"]),
      edhrec_rank:
          CollectorsBankHelperFunctions.checkIfIntNull(json["edhrec_rank"]),
      finishes: CollectorsBankHelperFunctions.addListString(
          json["finishes"] as List?),
      flavor_name:
          CollectorsBankHelperFunctions.checkIfStringNull(json["flavor_name"]),
      flavor_text: CollectorsBankHelperFunctions.checkIfStringNull(json["flavor_text"]),
      foil: CollectorsBankHelperFunctions.checkIfBoolNull(json["foil"]),
      frame: CollectorsBankHelperFunctions.checkIfStringNull(json["frame"]),
      frame_effects: CollectorsBankHelperFunctions.addListString(json["frame_effects"] as List?),
      full_art: CollectorsBankHelperFunctions.checkIfBoolNull(json["full_art"]),
      games: CollectorsBankHelperFunctions.addListString(json["games"] as List?),
      hand_modifier: CollectorsBankHelperFunctions.checkIfStringNull(json["hand_modifier"]),
      highres_image: CollectorsBankHelperFunctions.checkIfBoolNull(json["highres_image"]),
      id: CollectorsBankHelperFunctions.checkIfStringNull(json["id"]),
      illustration_id: CollectorsBankHelperFunctions.checkIfStringNull(json["illustration_id"]),
      image_status: CollectorsBankHelperFunctions.checkIfStringNull(json["image_status"]),
      image_uris: ImageUris.fromJson(json["image_uris"] as dynamic),
      keywords: CollectorsBankHelperFunctions.addListString(json["keywords"] as List?),
      lang: CollectorsBankHelperFunctions.checkIfStringNull(json["lang"]),
      layout: CollectorsBankHelperFunctions.checkIfStringNull(json["layout"]),
      legalities: Legalities.fromJson(json["legalities"] as dynamic),
      life_modifier: CollectorsBankHelperFunctions.checkIfStringNull(json["life_modifier"]),
      loyalty: CollectorsBankHelperFunctions.checkIfStringNull(json["loyalty"]),
      mana_cost: CollectorsBankHelperFunctions.checkIfStringNull(json["mana_cost"]),
      mtgo_foil_id: CollectorsBankHelperFunctions.checkIfIntNull(json["mtgo_foil_id"]),
      mtgo_id: CollectorsBankHelperFunctions.checkIfIntNull(json["mtgo_id"]),
      multiverse_ids: CollectorsBankHelperFunctions.addListInt(json["multiverse_ids"] as List?),
      name: CollectorsBankHelperFunctions.checkIfStringNull(json["name"]),
      nonfoil: CollectorsBankHelperFunctions.checkIfBoolNull(json["nonfoil"]),
      object: CollectorsBankHelperFunctions.checkIfStringNull(json["object"]),
      oracle_id: CollectorsBankHelperFunctions.checkIfStringNull(json["oracle_id"]),
      oracle_text: CollectorsBankHelperFunctions.checkIfStringNull(json["oracle_text"]),
      oversized: CollectorsBankHelperFunctions.checkIfBoolNull(json["oversized"]),
      penny_rank: CollectorsBankHelperFunctions.checkIfIntNull(json["penny_rank"]),
      power: CollectorsBankHelperFunctions.checkIfStringNull(json["power"]),
      prices: Prices.fromJson(json["prices"] as dynamic),
      printed_name: CollectorsBankHelperFunctions.checkIfStringNull(json["printed_name"]),
      printed_text: CollectorsBankHelperFunctions.checkIfStringNull(json["printed_text"]),
      printed_type_line: CollectorsBankHelperFunctions.checkIfStringNull(json["printed_type_line"]),
      prints_search_uri: CollectorsBankHelperFunctions.checkIfStringNull(json["prints_search_uri"]),
      produced_mana: CollectorsBankHelperFunctions.addListString(json["produced_mana"] as List?),
      promo: CollectorsBankHelperFunctions.checkIfBoolNull(json["promo"]),
      promo_types: CollectorsBankHelperFunctions.addListString(json["promo_types"] as List?),
      purchase_uris: PurchaseUris.fromJson(json["purchase_uris"] as dynamic),
      rarity: CollectorsBankHelperFunctions.checkIfStringNull(json["rarity"]),
      related_uris: RelatedUris.fromJson(json["related_uris"] as dynamic),
      released_at: CollectorsBankHelperFunctions.checkIfStringNull(json["released_at"]),
      reprint: CollectorsBankHelperFunctions.checkIfBoolNull(json["reprint"]),
      reserved: CollectorsBankHelperFunctions.checkIfBoolNull(json["reserved"]),
      rulings_uri: CollectorsBankHelperFunctions.checkIfStringNull(json["rulings_uri"]),
      scryfall_set_uri: CollectorsBankHelperFunctions.checkIfStringNull(json["scryfall_set_uri"]),
      scryfall_uri: CollectorsBankHelperFunctions.checkIfStringNull(json["scryfall_uri"]),
      security_stamp: CollectorsBankHelperFunctions.checkIfStringNull(json["security_stamp"]),
      set: CollectorsBankHelperFunctions.checkIfStringNull(json["set"]),
      set_id: CollectorsBankHelperFunctions.checkIfStringNull(json["set_id"]),
      set_name: CollectorsBankHelperFunctions.checkIfStringNull(json["set_name"]),
      set_search_uri: CollectorsBankHelperFunctions.checkIfStringNull(json["set_search_uri"]),
      set_type: CollectorsBankHelperFunctions.checkIfStringNull(json["set_type"]),
      set_uri: CollectorsBankHelperFunctions.checkIfStringNull(json["set_uri"]),
      story_spotlight: CollectorsBankHelperFunctions.checkIfBoolNull(json["story_spotlight"]),
      tcgplayer_etched_id: CollectorsBankHelperFunctions.checkIfIntNull(json["tcgplayer_etched_id"]),
      tcgplayer_id: CollectorsBankHelperFunctions.checkIfIntNull(json["tcgplayer_id"]),
      textless: CollectorsBankHelperFunctions.checkIfBoolNull(json["textless"]),
      toughness: CollectorsBankHelperFunctions.checkIfStringNull(json["toughness"]),
      type_line: CollectorsBankHelperFunctions.checkIfStringNull(json["type_line"]),
      uri: CollectorsBankHelperFunctions.checkIfStringNull(json["uri"]),
      variation: CollectorsBankHelperFunctions.checkIfBoolNull(json["variation"]),
      variation_of: CollectorsBankHelperFunctions.checkIfStringNull(json["variation_of"]),
      watermark: CollectorsBankHelperFunctions.checkIfStringNull(json["watermark"]));

  static List<RelatedCardObjects> _loopRelatedCardObjects(List<dynamic>? json) {
    List<RelatedCardObjects> relatedCardObjects = [];
    if (json != null) {
      for (var relatedCard in json) {
        relatedCardObjects.add(RelatedCardObjects.fromJson(relatedCard));
      }
    }
    return relatedCardObjects;
  }

  static List<CardFaces> _loopCardFaces(List<dynamic>? json) {
    List<CardFaces> cardFaces = [];
    if (json != null) {
      for (var cardFace in json) {
        cardFaces.add(CardFaces.fromJson(cardFace));
      }
    }
    return cardFaces;
  }
}
