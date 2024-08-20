import 'package:collectors_bank/DB/profiles/mtg_profile.dart';
import 'package:collectors_bank/Pages/mtg/mtg_sets.dart';
import 'package:collectors_bank/preferences.dart';
import 'package:collectors_bank/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:iconsax/iconsax.dart';

// ignore: must_be_immutable
class MTGHome extends StatelessWidget {
  MTGHome({super.key});

  List<MTGData> mtgData = [];

  void loadMtgData() async {
    mtgData = await Constants.readMTGData();
  }

  @override
  Widget build(BuildContext context) {
    loadMtgData();
    final controller = Get.put(NavigationController());
    return Scaffold(
      backgroundColor: Preferences().appBackgroundColor,
      appBar: AppBar(
        title: const Text(
          'Collector\'s Bank  -  MTG',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Preferences().appAccentColor,
      ),
      body: Column(
        children: [
          Container(
            height: 30,
            color: Colors.yellow,
          ),
          controller.screens[controller.selectedIndex.value],
        ],
      ),
      bottomNavigationBar: Obx(
        () => NavigationBarTheme(
          data: NavigationBarThemeData(
            labelTextStyle: MaterialStateProperty.resolveWith<TextStyle>(
              (Set<MaterialState> states) =>
                  states.contains(MaterialState.selected)
                      ? TextStyle(color: Preferences().appAccentColor)
                      : const TextStyle(color: Colors.white),
            ),
          ),
          child: NavigationBar(
              backgroundColor: Preferences().appBackgroundColor,
              shadowColor: Preferences().appAccentColor,
              surfaceTintColor: Preferences().appAccentColor,
              height: 60,
              elevation: 0,
              selectedIndex: controller.selectedIndex.value,
              onDestinationSelected: (index) =>
                  controller.selectedIndex.value = index,
              destinations: const [
                NavigationDestination(
                    icon: Icon(
                      Iconsax.book,
                      color: Colors.white,
                    ),
                    label: "Catalogue"),
                NavigationDestination(
                    icon: Icon(
                      Iconsax.bank,
                      color: Colors.white,
                    ),
                    label: "Collection"),
                NavigationDestination(
                    icon: Icon(
                      Iconsax.direct_normal,
                      color: Colors.white,
                    ),
                    label: "Decks"),
                NavigationDestination(
                    icon: Icon(
                      Iconsax.camera,
                      color: Colors.white,
                    ),
                    label: "Scan"),
              ]),
        ),
      ),
    );
  }
}

class NavigationController extends GetxController {
  final Rx<int> selectedIndex = 0.obs;

  final screens = [
    MTGSets(mtgData: MTGHome().mtgData),
    Container(color: Colors.blue),
    Container(color: Colors.deepPurple),
    Container(color: Colors.amber)
  ];
}
