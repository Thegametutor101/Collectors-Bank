import 'dart:io';

import 'package:collectors_bank/features/mtg/mtg_cards/models/model_card.dart';
import 'package:collectors_bank/utils/constants/sizes.dart';
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

  static bool checkIfBoolNull(Object? item) {
    if (item == null) {
      return false;
    } else {
      return item as bool;
    }
  }

  static int checkIfIntNull(Object? item) {
    if (item == null) {
      return 0;
    } else {
      return item as int;
    }
  }

  static double checkIfDoubleNull(Object? item) {
    if (item == null) {
      return 0;
    } else {
      return item as double;
    }
  }

  static List<String> addListString(List? list) {
    List<String> item = [];
    if (list != null) {
      for (var i in list) {
        item.add(checkIfStringNull(i));
      }
    }
    return item;
  }

  static List<int> addListInt(List? list) {
    List<int> item = [];
    if (list != null) {
      for (var i in list) {
        item.add(checkIfIntNull(i));
      }
    }
    return item;
  }

  static Widget checkIfMtgImage(ModelMtgCard card) {
    String image = card.image_uris.normal;
    if (image == "" && card.card_faces.isNotEmpty) {
      image = card.card_faces[0].image_uris.normal;
    }
    if (image == "") {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.only(bottom: 5),
            child: Text(
                style: const TextStyle(
                    color: Color.fromARGB(255, 220, 220, 220),
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
                card.collector_number),
          ),
          Text(
              style: const TextStyle(
                  color: Color.fromARGB(255, 220, 220, 220),
                  fontSize: 15,
                  fontWeight: FontWeight.bold),
              card.name),
        ],
      );
    } else {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: CollectorsBankSizes.sm),
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: Image.network(image).image,
              fit: BoxFit.scaleDown,
            ),
          ),
        ),
      );
    }
  }
}
