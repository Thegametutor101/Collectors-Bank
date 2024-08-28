import 'package:collectors_bank/utils/constants/colors.dart';
import 'package:collectors_bank/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class CollectorsBankElevatedButtonTheme {
  CollectorsBankElevatedButtonTheme._();

  static final lightElevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
        elevation: 0,
        foregroundColor: CollectorsBankColors.lightScaffoldColor,
        backgroundColor: CollectorsBankColors.lightPrimaryColor,
        disabledForegroundColor: Colors.grey,
        disabledBackgroundColor: Colors.grey,
        side: const BorderSide(color: CollectorsBankColors.lightPrimaryColor),
        padding: const EdgeInsets.symmetric(
            vertical: CollectorsBankSizes.defaultSpace),
        textStyle: const TextStyle(
            fontSize: CollectorsBankSizes.fontSizeXl,
            color: CollectorsBankColors.lightTextColor,
            fontWeight: FontWeight.w600),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
  );
  static final darkElevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
        elevation: 0,
        foregroundColor: CollectorsBankColors.darkScaffoldColor,
        backgroundColor: CollectorsBankColors.darkPrimaryColor,
        disabledForegroundColor: Colors.grey,
        disabledBackgroundColor: Colors.grey,
        side: const BorderSide(color: CollectorsBankColors.darkPrimaryColor),
        padding: const EdgeInsets.symmetric(
            vertical: CollectorsBankSizes.defaultSpace),
        textStyle: const TextStyle(
            fontSize: CollectorsBankSizes.fontSizeXl,
            color: CollectorsBankColors.darkTextColor,
            fontWeight: FontWeight.w600),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
  );
}
