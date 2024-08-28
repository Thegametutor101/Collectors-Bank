import 'package:collectors_bank/utils/constants/colors.dart';
import 'package:collectors_bank/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class AppSection extends StatelessWidget {
  const AppSection(
      {super.key,
      required this.defaultImage,
      required this.pressedImage,
      required this.backgroundGradient,
      required this.targetPage});

  final String defaultImage;
  final String pressedImage;
  final Gradient backgroundGradient;
  final Widget targetPage;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          vertical: CollectorsBankSizes.dividerHeight),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(
                Radius.circular(CollectorsBankSizes.borderRadiusLg)),
            gradient: backgroundGradient),
        child: IconButton(
          splashColor: CollectorsBankColors.transparent,
          highlightColor: CollectorsBankColors.transparent,
          icon: Image(image: AssetImage(defaultImage)),
          selectedIcon: Image(image: AssetImage(pressedImage)),
          iconSize: 250,
          onPressed: () {
            Get.to(targetPage);
          },
        ),
      ),
    );
  }
}
