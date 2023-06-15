import 'dart:convert';
import 'dart:io';
import 'dart:isolate';
import 'package:collectors_bank/DB/data/data_mtg.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class Constants {
  static Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  static Future<File> _localFile(String name) async {
    final path = await _localPath;
    if (await File('$path/$name').exists()) {
      print("file '$path/$name' exist.");
      return File('$path/$name');
    } else {
      print("file '$path/$name' does not exist.");
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
      return List.empty();
    }
  }

  static Future<File> writeMTGData() async {
    final file = await _localFile('MTGData.json');
    return file.writeAsString(
        '{"DataSet" : {"setCode" : "MOM","collected" : "92","DataCard" : {"cardCode" : "678354","owned" : "2","inUse" : "1"}}}');
  }

  static Future<void> deleteMTGData() async {
    final file = await _localFile('MTGData.json');
    file.delete();
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
    print("encodedJson: " + encodedJson);
    final jsonData = jsonDecode(encodedJson);
    print("jsonData");
    print(jsonData);
    final resultJson = jsonData as Map<String, dynamic>;
    print(resultJson);
    final result = MTGData.fromJson(resultJson);
    Isolate.exit(port, resultJson);
  }
}
