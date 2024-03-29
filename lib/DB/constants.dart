import 'dart:convert';
import 'dart:io';
import 'dart:isolate';
import 'package:collectors_bank/DB/data/data_mtg.dart';
import 'package:collectors_bank/DB/models/mtg_card.dart';
import 'package:collectors_bank/DB/models/mtg_set.dart';
import 'package:collectors_bank/DB/models/view_mtg_card_variants.dart';
import 'package:path_provider/path_provider.dart';

class Constants {
  static Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  static Future<File> _localFile(String name) async {
    final path = await _localPath;
    if (await File('$path/$name').exists()) {
      return File('$path/$name');
    } else {
      return File('$path/$name').create();
    }
  }

  static Future<List<MTGData>> readMTGData() async {
    try {
      final file = await _localFile('MTGData.json');
      final contents = await file.readAsString();
      final parser = JsonParserMTG(contents);
      return parser.parseInBackground();
    } catch (e) {
      return List.empty(growable: true);
    }
  }

  static Future<File> writeMTGData(List<MTGData> mtgData) async {
    final file = await _localFile('MTGData.json');
    return file.writeAsString(_MTGDataToString(mtgData));
  }

  static Future<void> deleteMTGData() async {
    final file = await _localFile('MTGData.json');
    file.delete();
  }

  // ignore: non_constant_identifier_names
  static String _MTGDataToString(List<MTGData> mtgData) {
    return jsonEncode(mtgData);
  }
}

class JsonParserMTG {
  JsonParserMTG(this.encodedJson);
  final String encodedJson;

  Future<List<MTGData>> parseInBackground() async {
    final p = ReceivePort();
    await Isolate.spawn(_decodeAndParseJson, p.sendPort);
    return await p.first;
  }

  Future<void> _decodeAndParseJson(SendPort port) async {
    if (encodedJson.isEmpty) {
      Isolate.exit(port, List<MTGData>.empty(growable: true));
    }
    final jsonData = jsonDecode(encodedJson);
    final resultJson = jsonData as List<dynamic>;
    final result =
        resultJson.map((json) => MTGData.fromJson(json)).toList(growable: true);
    Isolate.exit(port, result);
  }
}

class JsonParserMTGSets {
  JsonParserMTGSets(this.encodedJson);
  final String encodedJson;

  Future<List<MTGSet>> parseInBackground() async {
    final p = ReceivePort();
    await Isolate.spawn(_decodeAndParseJson, p.sendPort);
    return await p.first;
  }

  Future<void> _decodeAndParseJson(SendPort port) async {
    final jsonData = jsonDecode(encodedJson);
    final resultJson = jsonData as List<dynamic>;
    final result = resultJson.map((json) => MTGSet.fromJson(json)).toList();
    Isolate.exit(port, result);
  }
}

class JsonParserMTGCardToList {
  JsonParserMTGCardToList(this.encodedJson);
  final String encodedJson;

  Future<List<MTGCard>> parseInBackground() async {
    final p = ReceivePort();
    await Isolate.spawn(_decodeAndParseJson, p.sendPort);
    return await p.first;
  }

  Future<void> _decodeAndParseJson(SendPort port) async {
    final jsonData = jsonDecode(encodedJson);
    final resultJson = jsonData as List<dynamic>;
    final result = resultJson.map((json) => MTGCard.fromJson(json)).toList();
    Isolate.exit(port, result);
  }
}

class JsonParserMTGCard {
  JsonParserMTGCard(this.encodedJson);
  final String encodedJson;

  Future<MTGCard> parseInBackground() async {
    final p = ReceivePort();
    await Isolate.spawn(_decodeAndParseJson, p.sendPort);
    return await p.first;
  }

  Future<void> _decodeAndParseJson(SendPort port) async {
    final jsonData = jsonDecode(encodedJson);
    final resultJson = jsonData as List<dynamic>;
    final result = resultJson.map((json) => MTGCard.fromJson(json));
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
