import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class Constants {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> _localFile(String name) async {
    final path = await _localPath;
    if (await File('$path/$name').exists()) {
      return File('$path/$name');
    } else {
      return File('$path/$name').create();
    }
  }

  Future<Map<String, Map<String, Object>>> readMTGData {
    
  }
}
