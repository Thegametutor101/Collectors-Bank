import 'package:collectors_bank/features/app_sections.dart';
import 'package:collectors_bank/features/mtg/mtg_home.dart';
import 'package:collectors_bank/utils/constants/colors.dart';
import 'package:collectors_bank/utils/constants/image_strings.dart';
import 'package:collectors_bank/utils/constants/variables.dart';
import 'package:collectors_bank/utils/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CollectorsBank extends StatelessWidget {
  const CollectorsBank({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      themeMode: ThemeMode.system,
      theme: CollectorsBankTheme.lightTheme,
      darkTheme: CollectorsBankTheme.darkTheme,
      title: CollectorsBankVariables.appName,
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          CollectorsBankVariables.appName,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        width: double.infinity,
        alignment: Alignment.topCenter,
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
        child: ListView(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          children: [
            const AppSection(
              defaultImage: CollectorsBankImageStrings.mtgDefault,
              pressedImage: CollectorsBankImageStrings.mtgPressed,
              backgroundGradient: CollectorsBankColors.mtgBackgroundGradient,
              targetPage: MTGHome(),
            ),
            AppSection(
              defaultImage: CollectorsBankImageStrings.pokDefault,
              pressedImage: CollectorsBankImageStrings.pokPressed,
              backgroundGradient: CollectorsBankColors.pokBackgroundGradient,
              targetPage: Container(),
            ),
            AppSection(
              defaultImage: CollectorsBankImageStrings.ygoDefault,
              pressedImage: CollectorsBankImageStrings.ygoPressed,
              backgroundGradient: CollectorsBankColors.ygoBackgroundGradient,
              targetPage: Container(),
            ),
          ],
        ),
      ),
    );
  }
}
