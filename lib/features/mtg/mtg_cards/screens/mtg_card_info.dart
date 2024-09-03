import 'dart:io';

import 'package:collectors_bank/features/fetch_loaders.dart';
import 'package:collectors_bank/features/mtg/mtg_cards/models/model_card.dart';
import 'package:collectors_bank/features/mtg/mtg_sets/models/model_symbols.dart';
import 'package:collectors_bank/utils/constants/colors.dart';
import 'package:collectors_bank/utils/constants/sizes.dart';
import 'package:collectors_bank/utils/device/device_utility.dart';
import 'package:collectors_bank/utils/helpers/helper_functions.dart';
import 'package:collectors_bank/utils/helpers/mtg_helper_functions.dart';
import 'package:collectors_bank/utils/http/http_server_mtg.dart';
import 'package:collectors_bank/utils/theme/custom_themes/border_side_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:iconsax/iconsax.dart';

class MtgCardInfo extends StatefulWidget {
  const MtgCardInfo({super.key, required this.card});

  final ModelMtgCard card;

  @override
  State<MtgCardInfo> createState() => _MtgCardInfo();
}

class _MtgCardInfo extends State<MtgCardInfo> {
  List<Widget> showManaCost(ModelMtgCard card, List<ModelSymbols> symbols) {
    List<Widget> manaCost = [];
    List<String> cardManaCostValues = [];
    if (card.mana_cost != "") {
      cardManaCostValues =
          card.mana_cost.substring(1, card.mana_cost.length - 1).split("}{");
    }
    for (var icon in cardManaCostValues) {
      for (var symbol in symbols) {
        if (icon == symbol.symbol.substring(1, symbol.symbol.length - 1)) {
          manaCost.add(
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: CollectorsBankSizes.xs),
              child: SizedBox(
                height: 30,
                width: 30,
                child: SvgPicture.network(symbol.svg_uri),
              ),
            ),
          );
        }
      }
    }
    return manaCost;
  }

  @override
  Widget build(BuildContext context) {
    ModelMtgCard card = widget.card;
    bool dark = CollectorsBankDeviceUtils.isDarkMode(context);
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: CollectorsBankSizes.defaultSpace),
      child: FutureBuilder<List<ModelSymbols>>(
        future: CollectorsBankHttpServer.getMtgSymbols(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.data == null ||
              snapshot.connectionState == ConnectionState.waiting) {
            return const FetchLoader();
          }
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.hasError) {
            return Center(
              child: Text(
                  'Error fetching card ${card.set} - ${card.name}. ${snapshot.error.toString()}'),
            );
          }
          if (snapshot.connectionState == ConnectionState.done) {
            List<ModelSymbols> symbols = snapshot.data;
            return ListView(
              padding: const EdgeInsets.only(top: 25),
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              children: [
                /// Card art_crop
                Center(
                  child: SizedBox(
                    height: CollectorsBankDeviceUtils.getScreenHeight() * 0.50,
                    width:
                        CollectorsBankDeviceUtils.getScreenWidth(context) - 30,
                    child: CollectorsBankMtgHelperFunctions.checkIfMtgImage(
                      card,
                      true,
                    ),
                  ),
                ),

                /// Card name
                Container(
                  decoration: BoxDecoration(
                    border: Border(
                      top: dark
                          ? CollectorsBankBorderSideTheme.darkBorderSideTheme
                          : CollectorsBankBorderSideTheme.lightBorderSideTheme,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: CollectorsBankSizes.sm),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Card Name",
                            style: TextStyle(
                              color: dark
                                  ? CollectorsBankColors.darkTextSecondaryColor
                                  : CollectorsBankColors
                                      .lightTextSecondaryColor,
                              fontSize: CollectorsBankSizes.fontSizeMd,
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: CollectorsBankSizes.defaultSpace),
                            child: FittedBox(
                              fit: BoxFit.fitWidth,
                              child: Text(
                                card.name,
                                style: const TextStyle(
                                  fontSize: CollectorsBankSizes.fontSizeLg,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                /// mana_cost
                Padding(
                  padding: const EdgeInsets.only(
                      bottom: CollectorsBankSizes.spaceBtwItems),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: showManaCost(card, symbols),
                  ),
                ),

                /// type_line + rarity (logo?)
                Container(
                  decoration: BoxDecoration(
                    border: Border(
                      top: dark
                          ? CollectorsBankBorderSideTheme.darkBorderSideTheme
                          : CollectorsBankBorderSideTheme.lightBorderSideTheme,
                    ),
                  ),
                  child: Row(
                    children: [
                      Text(card.rarity.substring(0, 1).toUpperCase()),
                      Icon(
                        Iconsax.star,
                        color: CollectorsBankColors.mtgRarities[
                            card.rarity.substring(0, 1).toUpperCase()],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: CollectorsBankSizes.spaceBtwItems),
                        child: FittedBox(
                          fit: BoxFit.fitWidth,
                          child: Text(
                            card.type_line,
                            style: const TextStyle(
                              fontSize: CollectorsBankSizes.fontSizeLg,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                /// oracle_text
                Container(
                  decoration: BoxDecoration(
                    border: Border(
                      top: dark
                          ? CollectorsBankBorderSideTheme.darkBorderSideTheme
                          : CollectorsBankBorderSideTheme.lightBorderSideTheme,
                      right: dark
                          ? CollectorsBankBorderSideTheme.darkBorderSideTheme
                          : CollectorsBankBorderSideTheme.lightBorderSideTheme,
                      bottom: dark
                          ? CollectorsBankBorderSideTheme.darkBorderSideTheme
                          : CollectorsBankBorderSideTheme.lightBorderSideTheme,
                      left: dark
                          ? CollectorsBankBorderSideTheme.darkBorderSideTheme
                          : CollectorsBankBorderSideTheme.lightBorderSideTheme,
                    ),
                  ),
                  child: Padding(
                    padding:
                        const EdgeInsets.all(CollectorsBankSizes.spaceBtwItems),
                    child: Text(card.oracle_text),
                  ),
                ),

                /// if creature = power / toughness
                /// edhrec_rank
                /// legalities
                /// prices
                /// availability (games)
                /// isOversized
                /// isPromo
                /// isReprint
                /// set_name + code
                /// collector_number
                /// artist
                /// puchase_uris
              ],
            );
          }
          return Center(
            child: Text("Error fetching ${card.name}'s details."),
          );
        },
      ),
    );
  }
}
