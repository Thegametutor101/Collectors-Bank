import 'dart:convert';
import 'dart:isolate';
import 'package:collectors_bank/common/profiles/mtg_profile.dart';
import 'package:collectors_bank/bindings/models/mtg/view_mtg_card_variants.dart';
import 'package:get/get.dart';
import 'package:json_store/json_store.dart';

class CollectorsBankStorageMtg extends GetxController {
  static CollectorsBankStorageMtg get instance => Get.find();

  final JsonStore _jsonStore = JsonStore();

  Future<List<MtgProfile>> readMTGData() async {
    Map<String, dynamic>? json = await _jsonStore.getItem('mtgProfile');
    List<MtgProfile> result = [];
    if (json != null) {
      for (var profile in json["data"]) {
        result.add(MtgProfile.fromJson(profile));
      }
    }
    return result;
  }

  void writeMTGData(List<MtgProfile> profile) async {
    List<Map<String, dynamic>> profileString = [];
    for (var set in profile) {
      profileString.add(set.toJson());
    }
    Map<String, dynamic> json = {"data": profileString};
    await _jsonStore.setItem('mtgProfile', json);
  }

  void deleteMTGData() async {
    await _jsonStore.deleteItem('mtgProfile');
  }
}

class JsonParserMtgProfile {
  JsonParserMtgProfile(this.encodedJson);
  final String encodedJson;

  Future<List<MtgProfile>> parseInBackground() async {
    final p = ReceivePort();
    await Isolate.spawn(_decodeAndParseJson, p.sendPort);
    return await p.first;
  }

  Future<void> _decodeAndParseJson(SendPort port) async {
    if (encodedJson.isEmpty) {
      Isolate.exit(port, List<MtgProfile>.empty(growable: true));
    }
    final jsonData = jsonDecode(encodedJson);
    final resultJson = jsonData as List<dynamic>;
    final result = resultJson
        .map((json) => MtgProfile.fromJson(json))
        .toList(growable: true);
    Isolate.exit(port, result);
  }
}

class JsonParserViewMTGCardVariantsToList {
  JsonParserViewMTGCardVariantsToList(this.encodedJson);
  final String encodedJson;

  Future<List<ViewMTGCardVariants>> parseInBackground() async {
    final p = ReceivePort();
    await Isolate.spawn(_decodeAndParseJson, p.sendPort);
    return await p.first;
  }

  Future<void> _decodeAndParseJson(SendPort port) async {
    final jsonData = jsonDecode(encodedJson);
    final resultJson = jsonData as List<dynamic>;
    final result =
        resultJson.map((json) => ViewMTGCardVariants.fromJson(json)).toList();
    Isolate.exit(port, result);
  }
}
