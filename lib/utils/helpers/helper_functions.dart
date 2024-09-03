import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
    if (item == null || item == 0) {
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

  static double roundDouble(double value, int places) {
    String num = value.toStringAsFixed(places);
    return double.parse(num);
  }
}
