import 'package:flutter/material.dart';

class CollectorsBankColors {
  CollectorsBankColors._();

  /// Generic
  static const Color transparent = Colors.transparent;

  ///Home Section Gradiants
  static const Gradient mtgBackgroundGradient =
      RadialGradient(radius: 2, colors: [Colors.black, transparent]);
  static const Gradient pokBackgroundGradient = RadialGradient(
      radius: 2, colors: [Color.fromARGB(255, 46, 69, 148), transparent]);
  static const Gradient ygoBackgroundGradient = RadialGradient(
      radius: 2, colors: [Color.fromARGB(255, 226, 31, 29), transparent]);

  /// Mtg Rarities
  static const Map<String, Color> mtgRarities = {
    "C": Color(0xC7272727),
    "U": Color(0xC7BFE0EB),
    "R": Color(0xC7E5CB80),
    "M": Color(0xC7D96E1E),
    "S": Color(0xC7A817AA),
    "B": Color(0xC71BCBDD),
  };

  ///Dark
  static const Color darkPrimaryColor = Color.fromARGB(255, 250, 10, 10);
  static const Color darkScaffoldColor = Color.fromARGB(255, 60, 60, 60);
  static const Color darkScaffoldAccentColor = Color.fromARGB(255, 84, 84, 84);
  static const Color darkTextColor = Color.fromARGB(255, 255, 255, 255);
  static const Color darkTextSecondaryColor =
      Color.fromARGB(255, 200, 200, 200);

  ///Light
  static const Color lightPrimaryColor = Color.fromARGB(255, 230, 60, 60);
  static const Color lightScaffoldColor = Color.fromARGB(255, 225, 225, 225);
  static const Color lightScaffoldAccentColor =
      Color.fromARGB(255, 185, 185, 185);
  static const Color lightTextColor = Color.fromARGB(255, 45, 45, 45);
  static const Color lightTextSecondaryColor =
      Color.fromARGB(255, 100, 100, 100);
}
