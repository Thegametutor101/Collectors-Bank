import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';

class CollectorsBankHelperFunctions {
  static showSnackBar(String message) {
    ScaffoldMessenger.of(Get.context!).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  static void showAlert(String title, String message) {
    showDialog(
        context: Get.context!,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(title),
            content: Text(message),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('OK'),
              ),
            ],
          );
        });
  }

  static void navigateToScreen(BuildContext context, Widget screen) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => screen));
  }

  static String truncateText(String text, int maxLength) {
    if (text.length > maxLength) {
      return '${text.substring(0, maxLength)}...';
    } else {
      return text;
    }
  }

  static Future<File> localFile(String name) async {
    final directory = await getApplicationDocumentsDirectory();
    if (await File('${directory.path}/$name').exists()) {
      return File('${directory.path}/$name');
    } else {
      return File('${directory.path}/$name').create();
    }
  }

  static String checkIfStringNull(Object? item) {
    if (item == null) {
      return '';
    } else {
      return item as String;
    }
  }
}
