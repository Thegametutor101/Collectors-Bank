import 'package:collectors_bank/utils/constants/colors.dart';
import 'package:collectors_bank/utils/constants/sizes.dart';
import 'package:collectors_bank/utils/device/device_utility.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class SetsSearchIcon extends StatelessWidget {
  const SetsSearchIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: CollectorsBankDeviceUtils.getAppBarHeight() - 50,
      right: CollectorsBankSizes.defaultSpace,
      child: IconButton(
        onPressed: () {},
        icon: const Icon(
          Iconsax.search_normal,
          color: CollectorsBankColors.textColor,
          size: 40,
        ),
      ),
    );
  }
}
