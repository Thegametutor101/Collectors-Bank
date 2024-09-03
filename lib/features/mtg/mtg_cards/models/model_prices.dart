import 'package:collectors_bank/utils/helpers/helper_functions.dart';

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

  static Prices fromJson(Map<String, Object?>? json) => Prices(
      usd: CollectorsBankHelperFunctions.checkIfStringNull(json?["usd"]),
      usd_foil:
          CollectorsBankHelperFunctions.checkIfStringNull(json?["usd_foil"]),
      usd_etched:
          CollectorsBankHelperFunctions.checkIfStringNull(json?["usd_etched"]),
      eur: CollectorsBankHelperFunctions.checkIfStringNull(json?["eur"]),
      eur_foil:
          CollectorsBankHelperFunctions.checkIfStringNull(json?["eur_foil"]),
      eur_etched:
          CollectorsBankHelperFunctions.checkIfStringNull(json?["eur_etched"]),
      tix: CollectorsBankHelperFunctions.checkIfStringNull(json?["tix"]));

  Map<String, dynamic> toJson() {
    return {
      "usd": usd,
      "usd_foil": usd_foil,
      "usd_etched": usd_etched,
      "eur": eur,
      "eur_foil": eur_foil,
      "eur_etched": eur_etched
    };
  }
}
