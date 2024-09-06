import 'package:collectors_bank/utils/helpers/helper_functions.dart';

class ModelSymbols {
  final bool appears_in_mana_costs;
  final List<String> colors;
  final String english;
  final bool funny;
  final List<String> gatherer_alternates;
  final bool hybrid;
  final String loose_variant;
  final double mana_value;
  final String object;
  final bool phyrexian;
  final bool represents_mana;
  final String svg_uri;
  final String symbol;
  final bool transposable;

  ModelSymbols(
      {required this.appears_in_mana_costs,
      required this.colors,
      required this.english,
      required this.funny,
      required this.gatherer_alternates,
      required this.hybrid,
      required this.loose_variant,
      required this.mana_value,
      required this.object,
      required this.phyrexian,
      required this.represents_mana,
      required this.svg_uri,
      required this.symbol,
      required this.transposable});

  static ModelSymbols fromJson(Map<String, Object?> json) => ModelSymbols(
      appears_in_mana_costs: CollectorsBankHelperFunctions.checkIfBoolNull(
          json["appears_in_mana_costs"]),
      colors:
          CollectorsBankHelperFunctions.addListString(json["colors"] as List?),
      english: CollectorsBankHelperFunctions.checkIfStringNull(json["english"]),
      funny: CollectorsBankHelperFunctions.checkIfBoolNull(json["funny"]),
      gatherer_alternates: CollectorsBankHelperFunctions.addListString(
          json["gatherer_alternates"] as List?),
      hybrid: CollectorsBankHelperFunctions.checkIfBoolNull(json["hybrid"]),
      loose_variant: CollectorsBankHelperFunctions.checkIfStringNull(
          json["loose_variant"]),
      mana_value:
          CollectorsBankHelperFunctions.checkIfDoubleNull(json["mana_value"]),
      object: json["object"] as String,
      phyrexian:
          CollectorsBankHelperFunctions.checkIfBoolNull(json["phyrexian"]),
      represents_mana: CollectorsBankHelperFunctions.checkIfBoolNull(
          json["represents_mana"]),
      svg_uri: CollectorsBankHelperFunctions.checkIfStringNull(json["svg_uri"]),
      symbol: CollectorsBankHelperFunctions.checkIfStringNull(json["symbol"]),
      transposable:
          CollectorsBankHelperFunctions.checkIfBoolNull(json["transposable"]));
}
