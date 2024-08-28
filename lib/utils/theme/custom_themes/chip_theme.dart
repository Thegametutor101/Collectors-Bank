import 'package:collectors_bank/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class CollectorsBankChipTheme {
  CollectorsBankChipTheme._();

  static ChipThemeData lightChipTheme = ChipThemeData(
    disabledColor: Colors.grey.withOpacity(0.4),
    labelStyle: const TextStyle(color: CollectorsBankColors.lightTextColor),
    selectedColor: CollectorsBankColors.lightPrimaryColor,
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
    checkmarkColor: CollectorsBankColors.lightTextColor,
  );

  static ChipThemeData darkChipTheme = const ChipThemeData(
    disabledColor: Colors.grey,
    labelStyle: TextStyle(color: CollectorsBankColors.darkTextColor),
    selectedColor: CollectorsBankColors.darkPrimaryColor,
    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
    checkmarkColor: CollectorsBankColors.darkTextColor,
  );
}
