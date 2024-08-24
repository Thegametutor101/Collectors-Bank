import 'dart:convert';
import 'package:collectors_bank/bindings/models/mtg/model_rulings.dart';
import 'package:http/http.dart' as http;
import 'package:collectors_bank/utils/constants/api_constants.dart';
import 'package:collectors_bank/bindings/models/mtg/model_card.dart';
import 'package:collectors_bank/bindings/models/mtg/model_set.dart';

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

  static Future<List<ModelMtgCard>> getMtgCards(
      String setCode, String parameters) async {
    var response = await http.get(
        Uri.parse('${APIConstants.scryfallCardsInSet}$parameters'),
        headers: {'Accept': 'application/json'});
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      List<ModelMtgCard> result = [];
      for (var cards in jsonData['data']) {
        result.add(ModelMtgCard.fromJson(cards));
      }
      return result;
    } else {
      throw Exception(
          'Sorry!\nFailed to retreive Magic the Gathering cards for set ${setCode.toUpperCase()} from our servers.');
    }
  }

  static Future<List<ModelRulings>> getMtgCardRulings(
      String cardName, String rulingsUri) async {
    var response = await http
        .get(Uri.parse(rulingsUri), headers: {'Accept': 'application/json'});
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      List<ModelRulings> result = [];
      for (var cards in jsonData['data']) {
        result.add(ModelRulings.fromJson(cards));
      }
      return result;
    } else {
      throw Exception(
          'Sorry!\nFailed to retreive card rulings for "$cardName" from our servers.');
    }
  }
}
