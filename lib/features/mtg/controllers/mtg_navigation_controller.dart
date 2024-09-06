import 'package:collectors_bank/features/mtg/mtg_catalogue/controllers/mtg_catalogue_navigation.dart';
import 'package:collectors_bank/features/mtg/mtg_collection/screens/mtg_collection.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MtgNavigationController extends GetxController {
  final Rx<int> selectedIndex = 0.obs;

  final screens = [
    const MtgCatalogueNavigation(),
    const MtgCollection(),
    Container(color: Colors.deepPurple),
    Container(color: Colors.amber)
  ];
}
