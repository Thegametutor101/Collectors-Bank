import 'dart:convert';
import 'dart:io';
import 'dart:isolate';
import 'package:collectors_bank/bindings/profiles/mtg_profile.dart';
import 'package:collectors_bank/bindings/models/mtg/model_card.dart';
import 'package:collectors_bank/bindings/models/mtg/model_set.dart';
import 'package:collectors_bank/bindings/models/mtg/view_mtg_card_variants.dart';
import 'package:collectors_bank/utils/helpers/helper_functions.dart';

class CollectorsBankStorageMtg {
  static final CollectorsBankStorageMtg _instance =
      CollectorsBankStorageMtg._internal();

  factory CollectorsBankStorageMtg() {
    return _instance;
  }

  CollectorsBankStorageMtg._internal();

  Future<List<MtgProfile>> _storage =
      List.empty(growable: true) as Future<List<MtgProfile>>;

  Future<List<MtgProfile>> readMTGData() async {
    try {
      final file =
          await CollectorsBankHelperFunctions.localFile('MTGData.json');
      final contents = await file.readAsString();
      _storage = JsonParserMtgProfile(contents).parseInBackground();
      return _storage;
    } catch (e) {
      return _storage;
    }
  }

  Future<File> writeMTGData() async {
    final file = await CollectorsBankHelperFunctions.localFile('MTGData.json');
    return file.writeAsString(jsonEncode(_storage));
  }

  static Future<void> deleteMTGData() async {
    final file = await CollectorsBankHelperFunctions.localFile('MTGData.json');
    file.delete();
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

class JsonParserMTGSets {
  JsonParserMTGSets(this.encodedJson);
  final String encodedJson;

  Future<List<ModelMtgSet>> parseInBackground() async {
    final p = ReceivePort();
    await Isolate.spawn(_decodeAndParseJson, p.sendPort);
    return await p.first;
  }

  Future<void> _decodeAndParseJson(SendPort port) async {
    final jsonData = jsonDecode(encodedJson);
    final resultJson = jsonData as List<dynamic>;
    final result =
        resultJson.map((json) => ModelMtgSet.fromJson(json)).toList();
    Isolate.exit(port, result);
  }
}

class JsonParserMTGCard {
  JsonParserMTGCard(this.encodedJson, this.needsList);
  final String encodedJson;
  final bool needsList;

  Future<ModelMtgCard> parseInBackground() async {
    final p = ReceivePort();
    await Isolate.spawn(_decodeAndParseJson, p.sendPort);
    return await p.first;
  }

  Future<List<ModelMtgCard>> parseInBackgroundToList() async {
    final p = ReceivePort();
    await Isolate.spawn(_decodeAndParseJson, p.sendPort);
    return await p.first;
  }

  Future<void> _decodeAndParseJson(SendPort port) async {
    final jsonData = jsonDecode(encodedJson);
    final resultJson = jsonData as List<dynamic>;
    var result = resultJson.map((json) => ModelMtgCard.fromJson(json));
    if (needsList) {
      result = resultJson.map((json) => ModelMtgCard.fromJson(json)).toList();
    } else {}
    Isolate.exit(port, result.first);
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
