import 'package:collectors_bank/common/profiles/mtg_profile.dart';
import 'package:collectors_bank/features/fetch_loader.dart';
import 'package:collectors_bank/features/mtg/mtg_collection/screens/mtg_set_collection.dart';
import 'package:collectors_bank/utils/constants/colors.dart';
import 'package:collectors_bank/utils/constants/sizes.dart';
import 'package:collectors_bank/utils/device/device_utility.dart';
import 'package:collectors_bank/utils/helpers/helper_functions.dart';
import 'package:collectors_bank/utils/helpers/router_helper.dart';
import 'package:collectors_bank/utils/local_storage/storage_mtg.dart';
import 'package:collectors_bank/utils/theme/custom_themes/border_side_theme.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class MtgCollection extends StatefulWidget {
  const MtgCollection({super.key});

  @override
  State<MtgCollection> createState() => _MtgCollection();
}

class _MtgCollection extends State<MtgCollection> {
  @override
  Widget build(BuildContext context) {
    bool dark = CollectorsBankDeviceUtils.isDarkMode(context);
    return Scaffold(
      appBar: AppBar(
        // leading: IconButton(
        //   onPressed: () {
        //     ///TODO
        //   },
        //   icon: Icon(
        //     Iconsax.arrow_left,
        //     color: dark
        //         ? CollectorsBankColors.darkTextSecondaryColor
        //         : CollectorsBankColors.lightTextSecondaryColor,
        //   ),
        // ),
        title: const Text(
          "Magic: The Gathering - Collection",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: FutureBuilder<List<MtgProfile>>(
        future: CollectorsBankStorageMtg.instance.readMTGData(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.data == null ||
              snapshot.connectionState == ConnectionState.waiting) {
            return const FetchLoader();
          }
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.hasError) {
            return Center(
              child: Text(
                  'Error fetching your Collection. ${snapshot.error.toString()}'),
            );
          }
          if (snapshot.connectionState == ConnectionState.done) {
            List<MtgProfile> profile = snapshot.data;
            double cardsPriceTotal = 0;
            int cardsCountPrints = 0;
            for (var set in profile) {
              for (var card in set.profileSet.cards) {
                for (var finish in card.finishes) {
                  cardsCountPrints += finish.owned;
                  String priceString = "0";
                  if (finish.finish == "nonfoil") {
                    priceString = card.prices.usd;
                  } else if (finish.finish == "foil") {
                    priceString = card.prices.usd_foil;
                  } else if (finish.finish == "etched") {
                    priceString = card.prices.usd_etched;
                  }
                  double price = CollectorsBankHelperFunctions.roundDouble(
                      double.parse(priceString), 2);
                  cardsPriceTotal = CollectorsBankHelperFunctions.roundDouble(
                      cardsPriceTotal + price * finish.owned, 2);
                }
              }
            }
            return Stack(
              children: [
                Positioned(
                  top: CollectorsBankDeviceUtils.getAppBarHeight() - 55,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: CollectorsBankSizes.defaultSpace),
                    child: SizedBox(
                      width: CollectorsBankDeviceUtils.getScreenWidth(context),
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: Column(
                          children: [
                            Container(
                              height: 150,
                              width: 150,
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: dark
                                        ? CollectorsBankColors.darkPrimaryColor
                                        : CollectorsBankColors
                                            .lightPrimaryColor,
                                    width: 3,
                                    style: BorderStyle.solid),
                                shape: BoxShape.circle,
                                color: dark
                                    ? CollectorsBankColors
                                        .darkScaffoldAccentColor
                                    : CollectorsBankColors
                                        .lightScaffoldAccentColor,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(
                                    CollectorsBankSizes.spaceBtwSections),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    FittedBox(
                                      fit: BoxFit.fitWidth,
                                      child: Text(
                                        "\$${cardsPriceTotal.toString()}",
                                        style: const TextStyle(
                                            fontSize:
                                                CollectorsBankSizes.fontSizeXl),
                                      ),
                                    ),
                                    FittedBox(
                                      fit: BoxFit.fitWidth,
                                      child: Text(
                                        "$cardsCountPrints cards",
                                        style: const TextStyle(
                                            fontSize:
                                                CollectorsBankSizes.fontSizeMd),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 200),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border(
                        top: dark
                            ? CollectorsBankBorderSideTheme.darkBorderSideTheme
                            : CollectorsBankBorderSideTheme
                                .lightBorderSideTheme,
                      ),
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.elliptical(10, 7),
                          topRight: Radius.elliptical(10, 7)),
                    ),
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: profile.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          textColor: dark
                              ? CollectorsBankColors.darkTextColor
                              : CollectorsBankColors.lightTextColor,
                          title: Text(profile[index].profileSet.name),
                          subtitle: Flex(
                            direction: Axis.horizontal,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                profile[index].profileSet.setCode.toUpperCase(),
                                style: const TextStyle().copyWith(
                                    color: dark
                                        ? CollectorsBankColors
                                            .darkTextSecondaryColor
                                        : CollectorsBankColors
                                            .lightTextSecondaryColor),
                              ),
                              Text(
                                  "collected: ${profile[index].profileSet.collected}"),
                            ],
                          ),
                          onTap: () async {
                            Navigator.pushNamed(
                              context,
                              RouterHelper.getMtgSetCollection(),
                              arguments: MtgSetCollection(
                                  profileSet: profile[index].profileSet,
                                  cards: profile[index].profileSet.cards),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ),
              ],
            );
          }
          return const Center(
            child: Text('Error fetching your collection'),
          );
        },
      ),
    );
  }
}
