import 'package:collectors_bank/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class CollectorsBankCheckboxTheme {
  CollectorsBankCheckboxTheme._();

  static CheckboxThemeData lightChecboxTheme = CheckboxThemeData(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      checkColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return CollectorsBankColors.darkTextColor;
        } else {
          return CollectorsBankColors.lightTextColor;
        }
      }),
      fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return CollectorsBankColors.lightPrimaryColor;
        } else {
          return CollectorsBankColors.transparent;
        }
      }));

  static CheckboxThemeData darkChecboxTheme = CheckboxThemeData(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      checkColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return CollectorsBankColors.darkTextColor;
        } else {
          return CollectorsBankColors.lightTextColor;
        }
      }),
      fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return CollectorsBankColors.darkPrimaryColor;
        } else {
          return CollectorsBankColors.transparent;
        }
      }));
}
