import 'package:collectors_bank/features/mtg/mtg_cards/controllers/card_variations_controller.dart';
import 'package:collectors_bank/utils/constants/colors.dart';
import 'package:collectors_bank/utils/device/device_utility.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class CardVariationsDotNavigation extends StatelessWidget {
  const CardVariationsDotNavigation({super.key});
  @override
  Widget build(BuildContext context) {
    final controller = CardVariationsController.instance;
    bool dark = CollectorsBankDeviceUtils.isDarkMode(context);
    return Positioned(
      bottom: CollectorsBankDeviceUtils.getBottomNavigationBarHeight(),
      child: SizedBox(
        width: CollectorsBankDeviceUtils.getScreenWidth(context),
        child: Align(
          alignment: Alignment.topCenter,
          child: SmoothPageIndicator(
            controller: controller.pageController,
            onDotClicked: controller.dotNavigationClick,
            count: 2,
            effect: ExpandingDotsEffect(
                activeDotColor: dark
                    ? CollectorsBankColors.darkPrimaryColor
                    : CollectorsBankColors.lightPrimaryColor,
                dotHeight: 6),
          ),
        ),
      ),
    );
  }
}
