import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:collectors_bank/bindings/models/mtg/model_set.dart';
import 'package:collectors_bank/utils/constants/api_constants.dart';

class CollectorsBankHttpServer {
  static Future<List<ModelMtgSet>> getMtgSets() async {
    final response = await http.get(Uri.parse(APIConstants.scryfallSets),
        headers: {'Accept': 'application/json'});
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      List<ModelMtgSet> result = [];
      for (var set in jsonData['data']) {
        result.add(ModelMtgSet.fromJson(set));
      }
      return result;
    } else {
      throw Exception(
          'Sorry!\nFailed to retreive Magic the Gathering sets from our servers.');
    }
  }
}
