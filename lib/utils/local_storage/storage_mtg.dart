import 'dart:convert';
import 'dart:io';
import 'dart:isolate';
import 'package:collectors_bank/bindings/profiles/mtg_profile.dart';
import 'package:collectors_bank/bindings/models/mtg/model_card.dart';
import 'package:collectors_bank/bindings/models/mtg/view_mtg_card_variants.dart';
import 'package:collectors_bank/utils/helpers/helper_functions.dart';
import 'package:get/get.dart';

class CollectorsBankStorageMtg extends GetxController {
  static CollectorsBankStorageMtg get instance => Get.find();

  List<MtgProfile> storage = List.empty(growable: true);

  Future<List<MtgProfile>> readMTGData() async {
    try {
      final file =
          await CollectorsBankHelperFunctions.localFile('MTGData.json');
      final contents = await file.readAsString();
      storage = JsonParserMtgProfile(contents).parseInBackground()
          as List<MtgProfile>;
      return storage;
    } catch (e) {
      return storage;
    }
  }

  Future<File> writeMTGData() async {
    final file = await CollectorsBankHelperFunctions.localFile('MTGData.json');
    return file.writeAsString(jsonEncode(storage));
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
