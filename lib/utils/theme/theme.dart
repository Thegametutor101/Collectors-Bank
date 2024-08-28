import 'package:collectors_bank/utils/constants/colors.dart';
import 'package:collectors_bank/utils/theme/custom_themes/elevated_button_theme.dart';
import 'package:collectors_bank/utils/theme/custom_themes/text_theme.dart';
import 'package:collectors_bank/utils/theme/custom_themes/appbar_theme.dart';
import 'package:collectors_bank/utils/theme/custom_themes/bottom_sheet_theme.dart';
import 'package:collectors_bank/utils/theme/custom_themes/checkbox_theme.dart';
import 'package:collectors_bank/utils/theme/custom_themes/chip_theme.dart';
import 'package:collectors_bank/utils/theme/custom_themes/text_field_theme.dart';
import 'package:flutter/material.dart';

class CollectorsBankTheme {
  CollectorsBankTheme._();

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Roboto',
    brightness: Brightness.light,
    primaryColor: CollectorsBankColors.lightPrimaryColor,
    scaffoldBackgroundColor: CollectorsBankColors.lightScaffoldColor,
    textTheme: CollectorsBankTextTheme.lightTextTheme,
    elevatedButtonTheme:
        CollectorsBankElevatedButtonTheme.lightElevatedButtonTheme,
    inputDecorationTheme:
        CollectorsBankTextFieldTheme.lightInputDecorationTheme,
    appBarTheme: CollectorsBankAppBarTheme.lightAppBarTheme,
    bottomSheetTheme: CollectorsBankBottomSheetTheme.lightBottomSheetTheme,
    checkboxTheme: CollectorsBankCheckboxTheme.lightChecboxTheme,
    chipTheme: CollectorsBankChipTheme.lightChipTheme,
  );
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Roboto',
    brightness: Brightness.dark,
    primaryColor: CollectorsBankColors.darkPrimaryColor,
    scaffoldBackgroundColor: CollectorsBankColors.darkScaffoldColor,
    textTheme: CollectorsBankTextTheme.darkTextTheme,
    elevatedButtonTheme:
        CollectorsBankElevatedButtonTheme.darkElevatedButtonTheme,
    inputDecorationTheme: CollectorsBankTextFieldTheme.darkInputDecorationTheme,
    appBarTheme: CollectorsBankAppBarTheme.darkAppBarTheme,
    bottomSheetTheme: CollectorsBankBottomSheetTheme.darkBottomSheetTheme,
    checkboxTheme: CollectorsBankCheckboxTheme.darkChecboxTheme,
    chipTheme: CollectorsBankChipTheme.darkChipTheme,
  );
}
