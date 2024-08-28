import 'package:collectors_bank/utils/helpers/helper_functions.dart';

class MtgProfile {
  final MtgProfileSet profileSet;

  MtgProfile({required this.profileSet});

  static MtgProfile fromJson(Map<String, dynamic> json) => MtgProfile(
      profileSet: MtgProfileSet(
          setCode: CollectorsBankHelperFunctions.checkIfStringNull(
              json["profileSets"]["setCode"]),
          collected: CollectorsBankHelperFunctions.checkIfIntNull(
              json["profileSets"]["collected"]),
          cards: json["profileSets"]["profileCards"]
              .map<MtgProfileCard>((json) => _loopCards(json))
              .toList()));

  Map<String, dynamic> toJson() {
    return {
      "profileSets": {
        "setCode": profileSet.setCode,
        "collected": profileSet.collected,
        "profileCards": _loopCardsToJson(profileSet.cards)
      }
    };
  }

  static MtgProfileCard _loopCards(Map<String, dynamic> json) => MtgProfileCard(
      cardCode:
          CollectorsBankHelperFunctions.checkIfStringNull(json["cardCode"]),
      owned: CollectorsBankHelperFunctions.checkIfIntNull(json["owned"]),
      inDecks: CollectorsBankHelperFunctions.checkIfIntNull(json["inDecks"]));

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
  int collected;
  List<MtgProfileCard> cards;

  MtgProfileSet(
      {required this.setCode, required this.collected, required this.cards});
}

class MtgProfileCard {
  final String cardCode;
  int owned;
  int inDecks;

  MtgProfileCard(
      {required this.cardCode, required this.owned, required this.inDecks});

  Map<String, dynamic> toJson() {
    return {"cardCode": cardCode, "owned": owned, "inDecks": inDecks};
  }
}
