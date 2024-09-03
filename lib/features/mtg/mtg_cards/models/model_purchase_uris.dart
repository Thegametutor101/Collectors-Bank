import 'package:collectors_bank/utils/helpers/helper_functions.dart';

class PurchaseUris {
  final String tcgplayer;
  final String cardmarket;
  final String cardhoarder;

  PurchaseUris(
      {required this.tcgplayer,
      required this.cardmarket,
      required this.cardhoarder});

  static PurchaseUris fromJson(Map<String, Object?>? json) => PurchaseUris(
      tcgplayer:
          CollectorsBankHelperFunctions.checkIfStringNull(json?["tcgplayer"]),
      cardmarket:
          CollectorsBankHelperFunctions.checkIfStringNull(json?["cardmarket"]),
      cardhoarder: CollectorsBankHelperFunctions.checkIfStringNull(
          json?["cardhoarder"]));
}
