import 'package:collectors_bank/utils/constants/sizes.dart';
import 'package:collectors_bank/utils/device/device_utility.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class SetsInfoIcon extends StatelessWidget {
  const SetsInfoIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: CollectorsBankDeviceUtils.getAppBarHeight() - 50,
      left: CollectorsBankSizes.defaultSpace,
      child: IconButton(
        onPressed: () {},
        icon: const Icon(
          Iconsax.info_circle,
          size: 40,
        ),
      ),
    );
  }
}
