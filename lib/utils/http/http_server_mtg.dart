import 'dart:convert';
import 'package:collectors_bank/features/mtg/mtg_cards/models/model_rulings.dart';
import 'package:collectors_bank/features/mtg/mtg_sets/models/model_symbols.dart';
import 'package:http/http.dart' as http;
import 'package:collectors_bank/utils/constants/api_constants.dart';
import 'package:collectors_bank/features/mtg/mtg_cards/models/model_card.dart';
import 'package:collectors_bank/features/mtg/mtg_sets/models/model_set.dart';

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
      String setCode, String uri) async {
    http.Response response;
    dynamic jsonData;
    bool next_page = true;
    String nextPageUri = "";
    List<ModelMtgCard> result = [];
    while (next_page) {
      if (nextPageUri == "") {
        response = await http
            .get(Uri.parse(uri), headers: {'Accept': 'application/json'});
      } else {
        response = await http.get(Uri.parse(nextPageUri),
            headers: {'Accept': 'application/json'});
      }
      if (response.statusCode == 200) {
        jsonData = jsonDecode(response.body);
        for (var cards in jsonData['data']) {
          result.add(ModelMtgCard.fromJson(cards));
        }
        if (jsonData["has_more"]) {
          nextPageUri = jsonData["next_page"];
        } else {
          next_page = false;
        }
      } else {
        throw Exception(
            'Sorry!\nFailed to retreive Magic the Gathering cards for set ${setCode.toUpperCase()} from our servers.');
      }
    }
    return result;
  }

  static Future<List<ModelMtgCard>> getMtgCardsByName(String cardName) async {
    var response = await http.get(
        Uri.parse(
            '${APIConstants.scryfallCardsSearch}include_extras=true&include_variations=true&order=set&q=!"$cardName"&unique=prints'),
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
          'Sorry!\nFailed to retreive other versions of "$cardName" from our servers.');
    }
  }

  static Future<ModelMtgCard> getMtgCardsByUri(String uri) async {
    var response =
        await http.get(Uri.parse(uri), headers: {'Accept': 'application/json'});
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      ModelMtgCard card = ModelMtgCard.fromJson(jsonData);
      return card;
    } else {
      throw Exception(
          "Sorry!\nFailed to retreive the selected card's information from our servers.");
    }
  }

  static Future<List<ModelRulings>> getMtgCardRulings(
      String cardName, String rulingsUri) async {
    var response = await http
        .get(Uri.parse(rulingsUri), headers: {'Accept': 'application/json'});
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      List<ModelRulings> result = [];
      for (var rulings in jsonData['data']) {
        result.add(ModelRulings.fromJson(rulings));
      }
      return result;
    } else {
      throw Exception(
          'Sorry!\nFailed to retreive card rulings for "$cardName" from our servers.');
    }
  }

  static Future<List<ModelSymbols>> getMtgSymbols() async {
    var response = await http.get(Uri.parse(APIConstants.scryfallSymbols),
        headers: {'Accept': 'application/json'});
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      List<ModelSymbols> result = [];
      for (var symbol in jsonData['data']) {
        result.add(ModelSymbols.fromJson(symbol));
      }
      return result;
    } else {
      throw Exception(
          'Sorry!\nFailed to retreive Magic the Gathering symbols from our servers.');
    }
  }
}
