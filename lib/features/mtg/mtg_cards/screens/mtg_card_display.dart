import 'package:collectors_bank/common/profiles/mtg_profile.dart';
import 'package:collectors_bank/utils/constants/sizes.dart';
import 'package:collectors_bank/utils/device/device_utility.dart';
import 'package:collectors_bank/utils/helpers/helper_functions.dart';
import 'package:collectors_bank/utils/local_storage/storage_mtg.dart';
import 'package:collectors_bank/utils/theme/custom_themes/border_side_theme.dart';
import 'package:flutter/material.dart';
import 'package:collectors_bank/features/mtg/mtg_cards/models/model_card.dart';
import 'package:iconsax/iconsax.dart';

class MtgCardDisplay extends StatefulWidget {
  const MtgCardDisplay({super.key, required this.card});

  final ModelMtgCard card;

  @override
  State<MtgCardDisplay> createState() => _MtgCardDisplay();
}

class _MtgCardDisplay extends State<MtgCardDisplay> {
  int ownedCopies = 0;
  int inADeck = 0;
  List<MtgProfile> mtgProfile = [];

  @override
  void initState() {
    super.initState();
    loadProfile();
  }

  Future loadProfile() async {
    var data = await CollectorsBankStorageMtg.instance.readMTGData();
    setState(() {
      mtgProfile = data;
      for (var set in mtgProfile) {
        if (set.profileSet.setCode == widget.card.set) {
          for (var card in set.profileSet.cards) {
            if (card.cardCode == widget.card.id) {
              ownedCopies = card.owned;
              inADeck = card.inDecks;
            }
          }
        }
      }
    });
  }

  void updateValues() {
    CollectorsBankStorageMtg.instance.writeMTGData(mtgProfile);
    setState(() {
      for (var set in mtgProfile) {
        if (set.profileSet.setCode == widget.card.set) {
          for (var card in set.profileSet.cards) {
            if (card.cardCode == widget.card.id) {
              ownedCopies = card.owned;
              inADeck = card.inDecks;
            }
          }
        }
      }
    });
  }

  void changeCardValues(bool changeOwned, bool add) {
    checkIfExists();
    for (var set in mtgProfile) {
      if (set.profileSet.setCode == widget.card.set) {
        for (var card in set.profileSet.cards) {
          if (card.cardCode == widget.card.id) {
            if (changeOwned) {
              if (add) {
                card.owned++;
              } else {
                if (card.owned > 0) {
                  card.owned--;
                }
                if (card.owned < card.inDecks) {
                  card.inDecks--;
                }
              }
            } else {
              if (add) {
                if (card.owned > card.inDecks) {
                  card.inDecks++;
                }
              } else {
                if (card.inDecks > 0) {
                  card.inDecks--;
                }
              }
            }
          }
        }
      }
    }
    updateValues();
  }

  void checkIfExists() {
    bool setExists = false;
    bool cardExists = false;
    for (var set in mtgProfile) {
      if (set.profileSet.setCode == widget.card.set) {
        setExists = true;
        for (var card in set.profileSet.cards) {
          if (card.cardCode == widget.card.id) {
            cardExists = true;
          }
        }
      }
    }

    if (!setExists) {
      mtgProfile.add(
        MtgProfile(
          profileSet: MtgProfileSet(
            setCode: widget.card.set,
            uri: widget.card.set_uri,
            collected: 0,
            cards: [],
          ),
        ),
      );
    }
    if (!cardExists) {
      for (var set in mtgProfile) {
        if (set.profileSet.setCode == widget.card.set) {
          String image = widget.card.image_uris.normal;
          if (image == "" && widget.card.card_faces.isNotEmpty) {
            image = widget.card.card_faces[0].image_uris.normal;
          }
          set.profileSet.cards.add(
            MtgProfileCard(
              cardCode: widget.card.id,
              uri: widget.card.uri,
              imageUri: image,
              owned: 0,
              inDecks: 0,
            ),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    ModelMtgCard card = widget.card;
    bool dark = CollectorsBankDeviceUtils.isDarkMode(context);
    return Stack(
      children: [
        ListView(
          padding: const EdgeInsets.only(top: 25),
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          children: [
            Center(
              child: SizedBox(
                height: CollectorsBankDeviceUtils.getScreenHeight() * 0.70,
                width: CollectorsBankDeviceUtils.getScreenWidth(context) - 30,
                child: CollectorsBankHelperFunctions.checkIfMtgImage(card),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                border: Border(
                  top: dark
                      ? CollectorsBankBorderSideTheme.darkBorderSideTheme
                      : CollectorsBankBorderSideTheme.lightBorderSideTheme,
                ),
              ),
              child: const Padding(
                padding:
                    EdgeInsets.only(left: CollectorsBankSizes.defaultSpace),
                child: Text(
                  "Owned copies",
                  style: TextStyle(
                    fontSize: CollectorsBankSizes.fontSizeLg,
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {
                    changeCardValues(true, false);
                  },
                  icon: const Icon(
                    Iconsax.minus,
                    size: CollectorsBankSizes.iconXl,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: CollectorsBankSizes.defaultSpace),
                  child: Text(
                    ownedCopies.toString(),
                    style: const TextStyle(
                      fontSize: CollectorsBankSizes.fontSize2X,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    changeCardValues(true, true);
                  },
                  icon: const Icon(
                    Iconsax.add,
                    size: CollectorsBankSizes.iconXl,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: CollectorsBankSizes.spaceBtwItems,
            ),
            Container(
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
              child: const Padding(
                padding:
                    EdgeInsets.only(left: CollectorsBankSizes.defaultSpace),
                child: Text(
                  "Cards in a Deck",
                  style: TextStyle(
                    fontSize: CollectorsBankSizes.fontSizeLg,
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {
                    changeCardValues(false, false);
                  },
                  icon: const Icon(
                    Iconsax.minus,
                    size: CollectorsBankSizes.iconXl,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: CollectorsBankSizes.defaultSpace),
                  child: Text(
                    inADeck.toString(),
                    style: const TextStyle(
                      fontSize: CollectorsBankSizes.fontSize2X,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    changeCardValues(false, true);
                  },
                  icon: const Icon(
                    Iconsax.add,
                    size: CollectorsBankSizes.iconXl,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: CollectorsBankSizes.spaceBtwItems,
            ),
            ElevatedButton(
              onPressed: () {},
              child: const Text(
                "Add to a deck",
              ),
            ),
          ],
        ),
      ],
    );
  }
}
