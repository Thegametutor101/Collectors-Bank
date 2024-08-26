import 'package:collectors_bank/features/mtg/mtg_sets/controllers/all_sets_controller.dart';
import 'package:collectors_bank/utils/constants/colors.dart';
import 'package:collectors_bank/utils/device/device_utility.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class SetsDotNavigation extends StatelessWidget {
  const SetsDotNavigation({super.key});
  @override
  Widget build(BuildContext context) {
    final controller = AllSetsController.instance;
    return Positioned(
      top: CollectorsBankDeviceUtils.getAppBarHeight() - 25,
      child: SizedBox(
        width: CollectorsBankDeviceUtils.getScreenWidth(context),
        child: Align(
          alignment: Alignment.topCenter,
          child: SmoothPageIndicator(
            controller: controller.pageController,
            onDotClicked: controller.dotNavigationClick,
            count: 3,
            effect: const ExpandingDotsEffect(
                activeDotColor: CollectorsBankColors.scaffoldAccentColor,
                dotHeight: 6),
          ),
        ),
      ),
    );
  }
}
