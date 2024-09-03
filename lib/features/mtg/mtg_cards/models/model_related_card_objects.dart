import 'package:collectors_bank/utils/helpers/helper_functions.dart';

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
