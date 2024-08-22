import 'package:collectors_bank/features/mtg/mtg_home.dart';
import 'package:collectors_bank/utils/constants/colors.dart';
import 'package:collectors_bank/utils/constants/image_strings.dart';
import 'package:collectors_bank/utils/constants/variables.dart';
import 'package:collectors_bank/utils/theme/theme.dart';
import 'package:flutter/material.dart';

class CollectorsBank extends StatelessWidget {
  const CollectorsBank({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
        backgroundColor: CollectorsBankColors.primaryColor,
      ),
      body: Container(
        width: double.infinity,
        alignment: Alignment.topCenter,
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
        child: IconButton(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          icon: const Image(
              image: AssetImage(CollectorsBankImageStrings.mtgDefault)),
          selectedIcon: const Image(
              image: AssetImage(CollectorsBankImageStrings.mtgPressed)),
          iconSize: 250,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => MTGHome(),
              ),
            );
          },
        ),
      ),
    );
  }
}
