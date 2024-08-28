import 'package:collectors_bank/utils/helpers/helper_functions.dart';

class ModelSymbols {
  final bool appears_in_mana_costs;
  final List<String> colors;
  final String english;
  final bool funny;
  final String gatherer_alternates;
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
      appears_in_mana_costs: json["appears_in_mana_costs"] as bool,
      colors:
          CollectorsBankHelperFunctions.addListString(json["colors"] as List),
      english: json["english"] as String,
      funny: json["funny"] as bool,
      gatherer_alternates: CollectorsBankHelperFunctions.checkIfStringNull(
          json["gatherer_alternates"]),
      hybrid: json["hybrid"] as bool,
      loose_variant: CollectorsBankHelperFunctions.checkIfStringNull(
          json["loose_variant"]),
      mana_value:
          CollectorsBankHelperFunctions.checkIfDoubleNull(json["mana_value"]),
      object: json["object"] as String,
      phyrexian: json["phyrexian"] as bool,
      represents_mana: json["represents_mana"] as bool,
      svg_uri: CollectorsBankHelperFunctions.checkIfStringNull(json["svg_uri"]),
      symbol: json["symbol"] as String,
      transposable: json["transposable"] as bool);
}
