import 'package:collectors_bank/features/mtg/mtg_collection/screens/mtg_collection.dart';
import 'package:collectors_bank/features/mtg/mtg_sets/screens/mtg_sets.dart';
import 'package:collectors_bank/utils/device/device_utility.dart';
import 'package:collectors_bank/utils/local_storage/storage_mtg.dart';
import 'package:collectors_bank/utils/theme/custom_themes/navigationbar_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

// ignore: must_be_immutable
class MTGHome extends StatefulWidget {
  const MTGHome({super.key});

  @override
  State<MTGHome> createState() => _MTGHomeState();
}

class _MTGHomeState extends State<MTGHome> {
  @override
  Widget build(BuildContext context) {
    Get.put(CollectorsBankStorageMtg());
    // CollectorsBankStorageMtg.instance.deleteMTGData();
    final controller = Get.put(NavigationController());
    bool dark = CollectorsBankDeviceUtils.isDarkMode(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Magic: The Gathering",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: controller.screens[controller.selectedIndex.value],
      bottomNavigationBar: Obx(
        () => NavigationBarTheme(
          data: dark
              ? CollectorsBankNavigationBarTheme.darkNavigationBarTheme
              : CollectorsBankNavigationBarTheme.lightNavigationBarTheme,
          child: NavigationBar(
              height: 60,
              elevation: 0,
              selectedIndex: controller.selectedIndex.value,
              onDestinationSelected: (index) {
                setState(() {
                  controller.selectedIndex.value = index;
                });
              },
              destinations: const [
                NavigationDestination(
                    icon: Icon(
                      Iconsax.book,
                    ),
                    label: "Catalogue"),
                NavigationDestination(
                    icon: Icon(
                      Iconsax.bank,
                    ),
                    label: "Collection"),
                NavigationDestination(
                    icon: Icon(
                      Iconsax.note,
                    ),
                    label: "Decks"),
                NavigationDestination(
                    icon: Icon(
                      Iconsax.camera,
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
    const MTGSets(),
    const MtgCollection(),
    Container(color: Colors.deepPurple),
    Container(color: Colors.amber)
  ];
}
