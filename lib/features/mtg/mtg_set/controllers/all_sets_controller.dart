import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AllSetsController extends GetxController {
  static AllSetsController get instance => Get.find();

  ///Variables
  final pageController = PageController();
  Rx<int> currentPageIndex = 0.obs;

  ///Update Curent Index when Page Scroll
  void updatePageIndicator(index) => currentPageIndex.value = index;

  ///Jump tp the specific dot selected page
  void dotNavigationClick(index) {
    currentPageIndex.value = index;
    pageController.jumpTo(index);
  }
}
