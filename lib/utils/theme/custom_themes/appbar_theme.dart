import 'package:collectors_bank/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class CollectorsBankAppBarTheme {
  CollectorsBankAppBarTheme._();

  static const lightAppBarTheme = AppBarTheme(
      elevation: 0,
      centerTitle: false,
      scrolledUnderElevation: 0,
      backgroundColor: CollectorsBankColors.lightPrimaryColor,
      surfaceTintColor: CollectorsBankColors.transparent,
      iconTheme:
          IconThemeData(color: CollectorsBankColors.lightTextColor, size: 24),
      actionsIconTheme:
          IconThemeData(color: CollectorsBankColors.lightTextColor, size: 24),
      titleTextStyle: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: CollectorsBankColors.lightTextColor));
  static const darkAppBarTheme = AppBarTheme(
      elevation: 0,
      centerTitle: false,
      scrolledUnderElevation: 0,
      backgroundColor: CollectorsBankColors.darkPrimaryColor,
      surfaceTintColor: CollectorsBankColors.transparent,
      iconTheme:
          IconThemeData(color: CollectorsBankColors.darkTextColor, size: 24),
      actionsIconTheme:
          IconThemeData(color: CollectorsBankColors.darkTextColor, size: 24),
      titleTextStyle: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: CollectorsBankColors.darkTextColor));
}
