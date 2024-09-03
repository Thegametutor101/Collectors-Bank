import 'package:collectors_bank/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class CollectorsBankNavigationBarTheme {
  CollectorsBankNavigationBarTheme._();

  static NavigationBarThemeData lightNavigationBarTheme =
      NavigationBarThemeData(
    indicatorColor: CollectorsBankColors.lightPrimaryColor,
    backgroundColor: CollectorsBankColors.lightScaffoldColor,
    labelTextStyle: WidgetStateProperty.resolveWith<TextStyle>(
      (Set<WidgetState> states) => states.contains(WidgetState.selected)
          ? const TextStyle(color: CollectorsBankColors.darkPrimaryColor)
          : const TextStyle(color: CollectorsBankColors.lightTextColor),
    ),
  );
  static NavigationBarThemeData darkNavigationBarTheme = NavigationBarThemeData(
    indicatorColor: CollectorsBankColors.darkPrimaryColor,
    backgroundColor: CollectorsBankColors.darkScaffoldColor,
    labelTextStyle: WidgetStateProperty.resolveWith<TextStyle>(
      (Set<WidgetState> states) => states.contains(WidgetState.selected)
          ? const TextStyle(color: CollectorsBankColors.lightPrimaryColor)
          : const TextStyle(color: CollectorsBankColors.darkTextColor),
    ),
  );
}
