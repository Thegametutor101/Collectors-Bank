import 'package:collectors_bank/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class CollectorsBankBorderSideTheme {
  CollectorsBankBorderSideTheme._();

  static BorderSide lightBorderSideTheme = const BorderSide(
      style: BorderStyle.solid,
      width: 2,
      color: CollectorsBankColors.lightScaffoldAccentColor);
  static BorderSide darkBorderSideTheme = const BorderSide(
      style: BorderStyle.solid,
      width: 2,
      color: CollectorsBankColors.darkScaffoldAccentColor);
}
