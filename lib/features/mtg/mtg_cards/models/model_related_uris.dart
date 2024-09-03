import 'package:collectors_bank/utils/helpers/helper_functions.dart';

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

  static RelatedUris fromJson(Map<String, Object?>? json) => RelatedUris(
      gatherer:
          CollectorsBankHelperFunctions.checkIfStringNull(json?["gatherer"]),
      tcgplayer_infinite_articles:
          CollectorsBankHelperFunctions.checkIfStringNull(
              json?["tcgplayer_infinite_articles"]),
      tcgplayer_infinite_decks: CollectorsBankHelperFunctions.checkIfStringNull(
          json?["tcgplayer_infinite_decks"]),
      edhrec: CollectorsBankHelperFunctions.checkIfStringNull(json?["edhrec"]));
}
