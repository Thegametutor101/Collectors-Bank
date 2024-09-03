import 'package:collectors_bank/features/mtg/mtg_cards/models/model_card.dart';
import 'package:collectors_bank/features/mtg/mtg_cards/screens/mtg_card.dart';
import 'package:collectors_bank/utils/constants/sizes.dart';
import 'package:collectors_bank/utils/device/device_utility.dart';
import 'package:collectors_bank/utils/helpers/mtg_helper_functions.dart';
import 'package:collectors_bank/utils/theme/custom_themes/border_side_theme.dart';
import 'package:flutter/material.dart';

class MtgCardVersions extends StatefulWidget {
  const MtgCardVersions({super.key, required this.cards});

  final List<ModelMtgCard> cards;

  @override
  State<MtgCardVersions> createState() => _MtgCardVersions();
}

class _MtgCardVersions extends State<MtgCardVersions> {
  @override
  Widget build(BuildContext context) {
    bool dark = CollectorsBankDeviceUtils.isDarkMode(context);
    return ListView.builder(
      padding: const EdgeInsets.only(top: 35),
      itemCount: widget.cards.length,
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(
            border: Border(
              bottom: dark
                  ? CollectorsBankBorderSideTheme.darkBorderSideTheme
                  : CollectorsBankBorderSideTheme.lightBorderSideTheme,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
                vertical: CollectorsBankSizes.spaceBtwItems),
            child: Padding(
              padding: const EdgeInsets.only(
                  right: CollectorsBankSizes.defaultSpace),
              child: InkWell(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 100,
                      width: 140,
                      child: CollectorsBankMtgHelperFunctions.checkIfMtgImage(
                        widget.cards[index],
                        false,
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                            "card number: ${widget.cards[index].collector_number}"),
                        Text(widget.cards[index].set_name),
                      ],
                    )
                  ],
                ),
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => MtgCard(
                        card: widget.cards[index],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
