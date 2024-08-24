import 'package:collectors_bank/bindings/profiles/mtg_profile.dart';
import 'package:collectors_bank/features/mtg/mtg_sets/screens/mtg_sets.dart';
import 'package:collectors_bank/utils/constants/colors.dart';
import 'package:collectors_bank/utils/local_storage/storage_mtg.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

// ignore: must_be_immutable
class MTGHome extends StatelessWidget {
  MTGHome({super.key});

  List<MtgProfile> mtgProfile = [];

  void loadMtgData() async {
    mtgProfile = await CollectorsBankStorageMtg().readMTGData();
  }

  @override
  Widget build(BuildContext context) {
    loadMtgData();
    final controller = Get.put(NavigationController());
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Collector\'s Bank  -  MTG',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: CollectorsBankColors.primaryColor,
      ),
      body: controller.screens[controller.selectedIndex.value],
      bottomNavigationBar: Obx(
        () => NavigationBarTheme(
          data: NavigationBarThemeData(
            indicatorColor: CollectorsBankColors.primaryColor,
            backgroundColor: CollectorsBankColors.scaffoldColor,
            labelTextStyle: WidgetStateProperty.resolveWith<TextStyle>(
              (Set<WidgetState> states) => states.contains(WidgetState.selected)
                  ? const TextStyle(color: CollectorsBankColors.primaryColor)
                  : const TextStyle(color: Colors.white),
            ),
          ),
          child: NavigationBar(
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
                      Iconsax.note,
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
    MTGSets(mtgProfile: MTGHome().mtgProfile),
    Container(color: Colors.blue),
    Container(color: Colors.deepPurple),
    Container(color: Colors.amber)
  ];
}
