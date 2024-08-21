import 'package:collectors_bank/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class CollectorsBankCheckboxTheme {
  CollectorsBankCheckboxTheme._();

  static CheckboxThemeData lightChecboxTheme = CheckboxThemeData(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      checkColor: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.selected)) {
          return Colors.white;
        } else {
          return Colors.black;
        }
      }),
      fillColor: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.selected)) {
          return CollectorsBankColors.primaryColor;
        } else {
          return Colors.transparent;
        }
      }));

  static CheckboxThemeData darkChecboxTheme = CheckboxThemeData(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      checkColor: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.selected)) {
          return Colors.white;
        } else {
          return Colors.black;
        }
      }),
      fillColor: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.selected)) {
          return CollectorsBankColors.primaryColor;
        } else {
          return Colors.transparent;
        }
      }));
}
