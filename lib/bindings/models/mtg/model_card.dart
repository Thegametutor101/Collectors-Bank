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
  final List<String> color_identity;
  final List<String> color_indicator;
  final List<String> colors;
  final String collector_number;
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
  // final RelatedUris related_uris;
  // final String released_at;
  // final bool reprint;
  // final bool reserved;
  // final String rulings_uri;
  // final String scryfall_uri;
  // final String scryfall_set_uri;
  // final String security_stamp;
  final String set;
  // final String set_id;
  final String set_name;
  // final String set_search_uri;
  // final String set_type;
  // final String set_uri;
  // final bool story_spotlight;
  // final int tcgplayer_id;
  // final int tcgplayer_etched_id;
  // final bool textless;
  // final String toughness;
  // final String type_line;
  // final String uri;
  // final bool variation;
  // final String variation_of;
  // final String watermark;

  ModelMtgCard({
    required this.all_parts,
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
    // required this.related_uris,
    // required this.released_at,
    // required this.reprint,
    // required this.reserved,
    // required this.rulings_uri,
    // required this.scryfall_set_uri,
    // required this.scryfall_uri,
    // required this.security_stamp,
    required this.set,
    // required this.set_id,
    required this.set_name,
    // required this.set_search_uri,
    // required this.set_type,
    // required this.set_uri,
    // required this.story_spotlight,
    // required this.tcgplayer_etched_id,
    // required this.tcgplayer_id,
    // required this.textless,
    // required this.toughness,
    // required this.type_line,
    // required this.uri,
    // required this.variation,
    // required this.variation_of,
    // required this.watermark
  });

  static ModelMtgCard fromJson(Map<String, Object?> json) => ModelMtgCard(
        all_parts: _loopRelatedCardObjects(json["all_parts"] as List<dynamic>?),
        arena_id:
            CollectorsBankHelperFunctions.checkIfIntNull(json["arena_id"]),
        artist: CollectorsBankHelperFunctions.checkIfStringNull(json["artist"]),
        artist_ids: CollectorsBankHelperFunctions.addListString(
            json["artist_ids"] as List?),
        attraction_lights: CollectorsBankHelperFunctions.addListInt(
            json["attraction_lights"] as List?),
        booster: json["booster"] as bool,
        border_color: json["border_color"] as String,
        card_back_id: json["card_back_id"] as String,
        card_faces: _loopCardFaces(json["card_faces"] as List<dynamic>?),
        cardmarket_id:
            CollectorsBankHelperFunctions.checkIfIntNull(json["cardmarket_id"]),
        cmc: json["cmc"] as double,
        collector_number: json["collector_number"] as String,
        color_identity: CollectorsBankHelperFunctions.addListString(
            json["color_identity"] as List?),
        color_indicator: CollectorsBankHelperFunctions.addListString(
            json["color_indicator"] as List?),
        colors: CollectorsBankHelperFunctions.addListString(
            json["colors"] as List?),
        content_warning: CollectorsBankHelperFunctions.checkIfBoolNull(
            json["content_warning"]),
        defense:
            CollectorsBankHelperFunctions.checkIfStringNull(json["defense"]),
        digital: json["digital"] as bool,
        edhrec_rank:
            CollectorsBankHelperFunctions.checkIfIntNull(json["edhrec_rank"]),
        finishes: CollectorsBankHelperFunctions.addListString(
            json["finishes"] as List?),
        flavor_name: CollectorsBankHelperFunctions.checkIfStringNull(
            json["flavor_name"]),
        flavor_text: CollectorsBankHelperFunctions.checkIfStringNull(
            json["flavor_text"]),
        foil: CollectorsBankHelperFunctions.checkIfBoolNull(json["foil"]),
        frame: json["frame"] as String,
        frame_effects: CollectorsBankHelperFunctions.addListString(
            json["frame_effects"] as List?),
        full_art: json["full_art"] as bool,
        games:
            CollectorsBankHelperFunctions.addListString(json["games"] as List?),
        hand_modifier: CollectorsBankHelperFunctions.checkIfStringNull(
            json["hand_modifier"]),
        highres_image: json["highres_image"] as bool,
        id: json["id"] as String,
        illustration_id: CollectorsBankHelperFunctions.checkIfStringNull(
            json["illustration_id"]),
        image_status: json["image_status"] as String,
        image_uris: ImageUris.fromJson(json["image_uris"] as dynamic),
        keywords: CollectorsBankHelperFunctions.addListString(
            json["keywords"] as List?),
        lang: json["lang"] as String,
        layout: json["layout"] as String,
        legalities: Legalities.fromJson(json["legalities"] as dynamic),
        life_modifier: CollectorsBankHelperFunctions.checkIfStringNull(
            json["life_modifier"]),
        loyalty:
            CollectorsBankHelperFunctions.checkIfStringNull(json["loyalty"]),
        mana_cost:
            CollectorsBankHelperFunctions.checkIfStringNull(json["mana_cost"]),
        mtgo_foil_id:
            CollectorsBankHelperFunctions.checkIfIntNull(json["mtgo_foil_id"]),
        mtgo_id: CollectorsBankHelperFunctions.checkIfIntNull(json["mtgo_id"]),
        multiverse_ids: CollectorsBankHelperFunctions.addListInt(
            json["multiverse_ids"] as List?),
        name: json["name"] as String,
        nonfoil: CollectorsBankHelperFunctions.checkIfBoolNull(json["nonfoil"]),
        object: json["object"] as String,
        oracle_id:
            CollectorsBankHelperFunctions.checkIfStringNull(json["oracle_id"]),
        oracle_text: CollectorsBankHelperFunctions.checkIfStringNull(
            json["oracle_text"]),
        oversized: json["oversized"] as bool,
        penny_rank:
            CollectorsBankHelperFunctions.checkIfIntNull(json["penny_rank"]),
        power: CollectorsBankHelperFunctions.checkIfStringNull(json["power"]),
        prices: Prices.fromJson(json["prices"] as dynamic),
        printed_name: CollectorsBankHelperFunctions.checkIfStringNull(
            json["printed_name"]),
        printed_text: CollectorsBankHelperFunctions.checkIfStringNull(
            json["printed_text"]),
        printed_type_line: CollectorsBankHelperFunctions.checkIfStringNull(
            json["printed_type_line"]),
        prints_search_uri: json["prints_search_uri"] as String,
        produced_mana: CollectorsBankHelperFunctions.addListString(
            json["produced_mana"] as List?),
        promo: json["promo"] as bool,
        promo_types: CollectorsBankHelperFunctions.addListString(
            json["promo_types"] as List?),
        purchase_uris: PurchaseUris.fromJson(json["purchase_uris"] as dynamic),
        rarity: json["rarity"] as String,
        // related_uris: RelatedUris.fromJson(json["related_uris"] as dynamic),
        // released_at: json["released_at"] as String,
        // reprint: json["reprint"] as bool,
        // reserved: json["reserved"] as bool,
        // rulings_uri:
        //     CollectorsBankHelperFunctions.checkIfStringNull(json["rulings_uri"]),
        // scryfall_set_uri: json["scryfall_set_uri"] as String,
        // scryfall_uri: json["scryfall_uri"] as String,
        // security_stamp: CollectorsBankHelperFunctions.checkIfStringNull(
        //     json["security_stamp"]),
        set: json["set"] as String,
        // set_id: json["set_id"] as String,
        set_name: json["set_name"] as String,
        // set_search_uri: json["set_search_uri"] as String,
        // set_type: json["set_type"] as String,
        // set_uri: json["set_uri"] as String,
        // story_spotlight: json["story_spotlight"] as bool,
        // tcgplayer_etched_id: CollectorsBankHelperFunctions.checkIfIntNull(
        //     json["tcgplayer_etched_id"]),
        // tcgplayer_id:
        //     CollectorsBankHelperFunctions.checkIfIntNull(json["tcgplayer_id"]),
        // textless: json["textless"] as bool,
        // toughness:
        //     CollectorsBankHelperFunctions.checkIfStringNull(json["toughness"]),
        // type_line: json["type_line"] as String,
        // uri: json["uri"] as String,
        // variation: json["variation"] as bool,
        // variation_of:
        //     CollectorsBankHelperFunctions.checkIfStringNull(json["variation_of"]),
        // watermark:
        //     CollectorsBankHelperFunctions.checkIfStringNull(json["watermark"])
      );

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

class RelatedCardObjects {
  final String id;
  final String object;
  final String component; // 'token', 'meld_part', 'meld_result', 'combo_piece'
  final String name;
  final String type_line;
  final String uri;

  RelatedCardObjects(
      {required this.id,
      required this.object,
      required this.component,
      required this.name,
      required this.type_line,
      required this.uri});

  static RelatedCardObjects fromJson(Map<String, Object?> json) =>
      RelatedCardObjects(
          id: CollectorsBankHelperFunctions.checkIfStringNull(json["id"]),
          object:
              CollectorsBankHelperFunctions.checkIfStringNull(json["object"]),
          component: CollectorsBankHelperFunctions.checkIfStringNull(
              json["component"]),
          name: CollectorsBankHelperFunctions.checkIfStringNull(json["name"]),
          type_line: CollectorsBankHelperFunctions.checkIfStringNull(
              json["type_line"]),
          uri: CollectorsBankHelperFunctions.checkIfStringNull(json["uri"]));
}

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
          json["color_indicator"] as List),
      colors:
          CollectorsBankHelperFunctions.addListString(json["colors"] as List),
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

class PurchaseUris {
  final String? tcgplayer;
  final String? cardmarket;
  final String? cardhoarder;

  PurchaseUris(
      {required this.tcgplayer,
      required this.cardmarket,
      required this.cardhoarder});

  static PurchaseUris fromJson(Map<String, Object?> json) => PurchaseUris(
      tcgplayer:
          CollectorsBankHelperFunctions.checkIfStringNull(json["tcgplayer"]),
      cardmarket:
          CollectorsBankHelperFunctions.checkIfStringNull(json["cardmarket"]),
      cardhoarder:
          CollectorsBankHelperFunctions.checkIfStringNull(json["cardhoarder"]));
}

class RelatedUris {
  final String gatherer;
  final String tcgplayer_infinite_articles;
  final String tcgplayer_infinite_decks;
  final String edhrec;

  RelatedUris(
      {required this.gatherer,
      required this.tcgplayer_infinite_articles,
      required this.tcgplayer_infinite_decks,
      required this.edhrec});

  static RelatedUris fromJson(Map<String, Object?> json) => RelatedUris(
      gatherer:
          CollectorsBankHelperFunctions.checkIfStringNull(json["gatherer"]),
      tcgplayer_infinite_articles:
          CollectorsBankHelperFunctions.checkIfStringNull(
              json["tcgplayer_infinite_articles"]),
      tcgplayer_infinite_decks: CollectorsBankHelperFunctions.checkIfStringNull(
          json["tcgplayer_infinite_decks"]),
      edhrec: CollectorsBankHelperFunctions.checkIfStringNull(json["edhrec"]));
}

class Prices {
  final String usd;
  final String usd_foil;
  final String usd_etched;
  final String eur;
  final String eur_foil;
  final String eur_etched;
  final String tix;

  Prices(
      {required this.usd,
      required this.usd_foil,
      required this.usd_etched,
      required this.eur,
      required this.eur_foil,
      required this.eur_etched,
      required this.tix});

  static Prices fromJson(Map<String, Object?> json) => Prices(
      usd: CollectorsBankHelperFunctions.checkIfStringNull(json["usd"]),
      usd_foil:
          CollectorsBankHelperFunctions.checkIfStringNull(json["usd_foil"]),
      usd_etched:
          CollectorsBankHelperFunctions.checkIfStringNull(json["usd_etched"]),
      eur: CollectorsBankHelperFunctions.checkIfStringNull(json["eur"]),
      eur_foil:
          CollectorsBankHelperFunctions.checkIfStringNull(json["eur_foil"]),
      eur_etched:
          CollectorsBankHelperFunctions.checkIfStringNull(json["eur_etched"]),
      tix: CollectorsBankHelperFunctions.checkIfStringNull(json["tix"]));
}

class Legalities {
  final String standard;
  final String future;
  final String historic;
  final String timeless;
  final String gladiator;
  final String pioneer;
  final String explorer;
  final String modern;
  final String legacy;
  final String pauper;
  final String vintage;
  final String penny;
  final String commander;
  final String oathbreaker;
  final String standardbrawl;
  final String brawl;
  final String alchemy;
  final String paupercommander;
  final String duel;
  final String oldschool;
  final String premodern;
  final String predh;

  Legalities(
      {required this.standard,
      required this.future,
      required this.historic,
      required this.timeless,
      required this.gladiator,
      required this.pioneer,
      required this.explorer,
      required this.modern,
      required this.legacy,
      required this.pauper,
      required this.vintage,
      required this.penny,
      required this.commander,
      required this.oathbreaker,
      required this.standardbrawl,
      required this.brawl,
      required this.alchemy,
      required this.paupercommander,
      required this.duel,
      required this.oldschool,
      required this.premodern,
      required this.predh});

  static Legalities fromJson(Map<String, Object?> json) => Legalities(
      standard: json["standard"] as String,
      future: json["future"] as String,
      historic: json["historic"] as String,
      timeless: json["timeless"] as String,
      gladiator: json["gladiator"] as String,
      pioneer: json["pioneer"] as String,
      explorer: json["explorer"] as String,
      modern: json["modern"] as String,
      legacy: json["legacy"] as String,
      pauper: json["pauper"] as String,
      vintage: json["vintage"] as String,
      penny: json["penny"] as String,
      commander: json["commander"] as String,
      oathbreaker: json["oathbreaker"] as String,
      standardbrawl: json["standardbrawl"] as String,
      brawl: json["brawl"] as String,
      alchemy: json["alchemy"] as String,
      paupercommander: json["paupercommander"] as String,
      duel: json["duel"] as String,
      oldschool: json["oldschool"] as String,
      premodern: json["premodern"] as String,
      predh: json["predh"] as String);
}

class ImageUris {
  final String small;
  final String normal;
  final String large;
  final String png;
  final String art_crop;
  final String border_crop;

  ImageUris(
      {required this.small,
      required this.normal,
      required this.large,
      required this.png,
      required this.art_crop,
      required this.border_crop});

  static ImageUris fromJson(Map<String, Object?> json) => ImageUris(
      small: CollectorsBankHelperFunctions.checkIfStringNull(json["small"]),
      normal: CollectorsBankHelperFunctions.checkIfStringNull(json["normal"]),
      large: CollectorsBankHelperFunctions.checkIfStringNull(json["large"]),
      png: CollectorsBankHelperFunctions.checkIfStringNull(json["png"]),
      art_crop:
          CollectorsBankHelperFunctions.checkIfStringNull(json["art_crop"]),
      border_crop:
          CollectorsBankHelperFunctions.checkIfStringNull(json["border_crop"]));
}
