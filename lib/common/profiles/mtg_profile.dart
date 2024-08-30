import 'package:collectors_bank/features/mtg/mtg_cards/models/model_card.dart';
import 'package:collectors_bank/utils/helpers/helper_functions.dart';

class MtgProfile {
  final MtgProfileSet profileSet;

  MtgProfile({required this.profileSet});

  static MtgProfile fromJson(Map<String, dynamic> json) => MtgProfile(
      profileSet: MtgProfileSet(
          setCode: CollectorsBankHelperFunctions.checkIfStringNull(
              json["profileSets"]["setCode"]),
          name: CollectorsBankHelperFunctions.checkIfStringNull(
              json["profileSets"]["name"]),
          uri: CollectorsBankHelperFunctions.checkIfStringNull(
              json["profileSets"]["uri"]),
          collected: CollectorsBankHelperFunctions.checkIfIntNull(
              json["profileSets"]["collected"]),
          cards: json["profileSets"]["profileCards"]
              .map<MtgProfileCard>((json) => _loopCards(json))
              .toList()));

  Map<String, dynamic> toJson() {
    return {
      "profileSets": {
        "setCode": profileSet.setCode,
        "name": profileSet.name,
        "uri": profileSet.uri,
        "collected": profileSet.collected,
        "profileCards": _loopCardsToJson(profileSet.cards)
      }
    };
  }

  static MtgProfileCard _loopCards(Map<String, dynamic> json) => MtgProfileCard(
        cardCode:
            CollectorsBankHelperFunctions.checkIfStringNull(json["cardCode"]),
        uri: CollectorsBankHelperFunctions.checkIfStringNull(json["uri"]),
        imageUri:
            CollectorsBankHelperFunctions.checkIfStringNull(json["imageUri"]),
        prices: Prices.fromJson(json["price"] as dynamic),
        finishes:
            _loopMtgProfileCardFinishes(json["finishes"] as List<dynamic>?),
        collectorNumber: CollectorsBankHelperFunctions.checkIfStringNull(
            json["collectorNumber"]),
      );

  static List<MtgProfileCardFinishes> _loopMtgProfileCardFinishes(
      List<dynamic>? json) {
    List<MtgProfileCardFinishes> mtgProfileCardFinishes = [];
    if (json != null) {
      for (var cardFinishes in json) {
        mtgProfileCardFinishes
            .add(MtgProfileCardFinishes.fromJson(cardFinishes));
      }
    }
    return mtgProfileCardFinishes;
  }

  static List<Map<String, dynamic>> _loopCardsToJson(
      List<MtgProfileCard> mtgDataCard) {
    List<Map<String, dynamic>> list = [];
    for (var card in mtgDataCard) {
      list.add(card.toJson());
    }
    return list;
  }
}

class MtgProfileSet {
  final String setCode;
  final String name;
  final String uri;
  int collected;
  List<MtgProfileCard> cards;

  MtgProfileSet(
      {required this.setCode,
      required this.name,
      required this.uri,
      required this.collected,
      required this.cards});
}

class MtgProfileCard {
  final String cardCode;
  final String uri;
  final String imageUri;
  final Prices prices;
  final List<MtgProfileCardFinishes> finishes;
  String collectorNumber;

  MtgProfileCard(
      {required this.cardCode,
      required this.uri,
      required this.imageUri,
      required this.prices,
      required this.finishes,
      required this.collectorNumber});

  Map<String, dynamic> toJson() {
    return {
      "cardCode": cardCode,
      "uri": uri,
      "imageUri": imageUri,
      "price": prices.toJson(),
      "finishes": _loopFinishesToJson(finishes),
      "collectorNumber": collectorNumber,
    };
  }

  static List<Map<String, dynamic>> _loopFinishesToJson(
      List<MtgProfileCardFinishes> finishes) {
    List<Map<String, dynamic>> list = [];
    for (var finish in finishes) {
      list.add(finish.toJson());
    }
    return list;
  }
}

class MtgProfileCardFinishes {
  String finish;
  int owned;
  int inDecks;

  MtgProfileCardFinishes(
      {required this.finish, required this.owned, required this.inDecks});

  static MtgProfileCardFinishes fromJson(Map<String, Object?> json) =>
      MtgProfileCardFinishes(
          finish:
              CollectorsBankHelperFunctions.checkIfStringNull(json["finish"]),
          owned: CollectorsBankHelperFunctions.checkIfIntNull(json["owned"]),
          inDecks:
              CollectorsBankHelperFunctions.checkIfIntNull(json["inDecks"]));

  Map<String, dynamic> toJson() {
    return {"finish": finish, "owned": owned, "inDecks": inDecks};
  }
}
