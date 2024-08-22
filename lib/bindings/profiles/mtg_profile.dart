import 'package:collectors_bank/utils/helpers/helper_functions.dart';

class MtgProfileFeilds {
  static final List<String> values = [sets];

  static const String sets = 'profileSets';
}

class MtgProfileSetFeilds {
  static final List<String> values = [setCode, collected, cards];

  static const String setCode = 'setCode';
  static const String collected = 'collected';
  static const String cards = 'profileCards';
}

class MtgProfileCardFeilds {
  static final List<String> values = [cardCode, owned, inDecks];

  static const String cardCode = 'cardCode';
  static const String owned = 'owned';
  static const String inDecks = 'inDecks';
}

class MtgProfile {
  final MtgProfileSet profileSet;

  MtgProfile({required this.profileSet});

  static MtgProfile fromJson(Map<String, dynamic> json) => MtgProfile(
      profileSet: MtgProfileSet(
          setCode: CollectorsBankHelperFunctions.checkIfStringNull(
              json[MtgProfileFeilds.sets][MtgProfileSetFeilds.setCode]),
          collected: CollectorsBankHelperFunctions.checkIfStringNull(
              json[MtgProfileFeilds.sets][MtgProfileSetFeilds.collected]),
          cards: json[MtgProfileFeilds.sets][MtgProfileSetFeilds.cards]
              .map<MtgProfileCard>((json) => _loopDataCards(json))
              .toList()));

  Map<String, dynamic> toJson() {
    return {
      'profileSets': {
        "setCode": profileSet.setCode,
        "collected": profileSet.collected,
        "profileCards": _loopDataCardsToJson(profileSet.cards)
      }
    };
  }

  static MtgProfileCard
      _loopDataCards(Map<String, dynamic> json) =>
          MtgProfileCard(
              cardCode: CollectorsBankHelperFunctions.checkIfStringNull(
                  json[MtgProfileCardFeilds.cardCode]),
              owned: CollectorsBankHelperFunctions.checkIfStringNull(
                  json[MtgProfileCardFeilds.owned]),
              inDecks: CollectorsBankHelperFunctions.checkIfStringNull(
                  json[MtgProfileCardFeilds.inDecks]));

  static List<Map<String, dynamic>> _loopDataCardsToJson(
      List<MtgProfileCard> mtgDataCard) {
    List<Map<String, dynamic>> list = List.empty(growable: true);
    for (var card in mtgDataCard) {
      list.add(card.toJson());
    }
    return list;
  }
}

class MtgProfileSet {
  final String setCode;
  String collected;
  List<MtgProfileCard> cards;

  MtgProfileSet(
      {required this.setCode, required this.collected, required this.cards});
}

class MtgProfileCard {
  final String cardCode;
  String owned;
  String inDecks;

  MtgProfileCard(
      {required this.cardCode, required this.owned, required this.inDecks});

  Map<String, dynamic> toJson() {
    return {"cardCode": cardCode, "owned": owned, "inDecks": inDecks};
  }
}
