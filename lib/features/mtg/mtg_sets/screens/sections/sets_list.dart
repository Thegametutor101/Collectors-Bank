import 'package:collectors_bank/common/profiles/mtg_profile.dart';
import 'package:collectors_bank/features/mtg/mtg_sets/models/model_set.dart';
import 'package:collectors_bank/features/mtg/mtg_sets/screens/mtg_set.dart';
import 'package:collectors_bank/utils/constants/colors.dart';
import 'package:collectors_bank/utils/device/device_utility.dart';
import 'package:collectors_bank/utils/helpers/mtg_helper_functions.dart';
import 'package:collectors_bank/utils/local_storage/storage_mtg.dart';
import 'package:collectors_bank/utils/theme/custom_themes/border_side_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class SetsList extends StatefulWidget {
  SetsList({super.key, required this.sets, required this.mtgProfile});

  final List<ModelMtgSet> sets;
  List<MtgProfile> mtgProfile;

  @override
  State<SetsList> createState() => _SetsListState();
}

class _SetsListState extends State<SetsList> {
  Future updateCollected() async {
    var data = await CollectorsBankStorageMtg.instance.readMTGData();
    setState(() {
      widget.mtgProfile = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    bool dark = CollectorsBankDeviceUtils.isDarkMode(context);
    return Padding(
      padding: const EdgeInsets.only(top: 65),
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            top: dark
                ? CollectorsBankBorderSideTheme.darkBorderSideTheme
                : CollectorsBankBorderSideTheme.lightBorderSideTheme,
          ),
          borderRadius: const BorderRadius.only(
              topLeft: Radius.elliptical(10, 7),
              topRight: Radius.elliptical(10, 7)),
        ),
        child: ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: widget.sets.length,
          itemBuilder: (context, index) {
            return ListTile(
              textColor: dark
                  ? CollectorsBankColors.darkTextColor
                  : CollectorsBankColors.lightTextColor,
              title: Text(widget.sets[index].name),
              subtitle: Flex(
                direction: Axis.horizontal,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    widget.sets[index].code.toUpperCase(),
                    style: const TextStyle().copyWith(
                        color: dark
                            ? CollectorsBankColors.darkTextSecondaryColor
                            : CollectorsBankColors.lightTextSecondaryColor),
                  ),
                  Text(
                      "${CollectorsBankMtgHelperFunctions.getSetCollected(widget.sets[index].code, widget.mtgProfile)}/${widget.sets[index].card_count}"),
                ],
              ),
              onTap: () async {
                final back = await Get.to(MtgSetPage(set: widget.sets[index]));
                if (back == "updateCollected") {
                  updateCollected();
                }
              },
            );
          },
        ),
      ),
    );
  }
}
