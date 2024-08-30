import 'package:collectors_bank/common/profiles/mtg_profile.dart';
import 'package:collectors_bank/utils/constants/sizes.dart';
import 'package:collectors_bank/utils/device/device_utility.dart';
import 'package:collectors_bank/utils/helpers/mtg_helper_functions.dart';
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
  List<MtgProfileCardFinishes> profileFinishes = [];
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
              for (var finish in card.finishes) {
                profileFinishes.add(finish);
              }
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
              for (var finish in card.finishes) {
                profileFinishes.add(finish);
              }
            }
          }
        }
      }
    });
  }

  void changeCardValues(bool add, String selectedFinish) {
    checkIfExists(selectedFinish);
    for (var set in mtgProfile) {
      if (set.profileSet.setCode == widget.card.set) {
        for (var card in set.profileSet.cards) {
          if (card.cardCode == widget.card.id) {
            for (var finish in card.finishes) {
              if (finish.finish == selectedFinish) {
                if (add) {
                  finish.owned++;
                  if (finish.owned == 1) {
                    set.profileSet.collected++;
                  }
                } else {
                  if (finish.owned > 0) {
                    finish.owned--;
                    if (finish.owned == 0) {
                      set.profileSet.collected--;
                    }
                  }
                }
              }
            }
          }
        }
      }
    }
    updateValues();
  }

  void checkIfExists(String selectedFinish) {
    bool setExists = false;
    bool cardExists = false;
    bool finishExists = false;
    for (var set in mtgProfile) {
      if (set.profileSet.setCode == widget.card.set) {
        setExists = true;
        for (var card in set.profileSet.cards) {
          if (card.cardCode == widget.card.id) {
            cardExists = true;
            for (var finish in card.finishes) {
              if (finish.finish == selectedFinish) {
                finishExists = true;
              }
            }
          }
        }
      }
    }

    if (!setExists) {
      mtgProfile.add(
        MtgProfile(
          profileSet: MtgProfileSet(
            setCode: widget.card.set,
            name: widget.card.set_name,
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
              prices: widget.card.prices,
              finishes: [],
              collectorNumber: widget.card.collector_number,
            ),
          );
        }
      }
    }
    if (!finishExists) {
      for (var set in mtgProfile) {
        if (set.profileSet.setCode == widget.card.set) {
          for (var card in set.profileSet.cards) {
            if (card.cardCode == widget.card.id) {
              card.finishes.add(
                MtgProfileCardFinishes(
                  finish: selectedFinish,
                  owned: 0,
                  inDecks: 0,
                ),
              );
            }
          }
        }
      }
    }
  }

  List<Widget> loopcreateFinish(bool dark, List<String> jsonFinishes) {
    List<Widget> finishesWidget = [];
    for (var jsonFinish in jsonFinishes) {
      MtgProfileCardFinishes profileFinish = MtgProfileCardFinishes(
        finish: "newfinish",
        owned: 0,
        inDecks: 0,
      );
      for (var profileFinishItem in profileFinishes) {
        if (profileFinishItem.finish == jsonFinish) {
          profileFinish = profileFinishItem;
        }
      }
      finishesWidget.add(createFinish(dark, jsonFinish, profileFinish));
    }
    return finishesWidget;
  }

  Widget createFinish(
      bool dark, String finish, MtgProfileCardFinishes profileFinish) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border(
              top: dark
                  ? CollectorsBankBorderSideTheme.darkBorderSideTheme
                  : CollectorsBankBorderSideTheme.lightBorderSideTheme,
            ),
          ),
          child: Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding:
                  const EdgeInsets.only(left: CollectorsBankSizes.defaultSpace),
              child: Text(
                "Owned $finish copies",
                style: const TextStyle(
                  fontSize: CollectorsBankSizes.fontSizeLg,
                ),
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
                changeCardValues(false, finish);
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
                profileFinish.owned.toString(),
                style: const TextStyle(
                  fontSize: CollectorsBankSizes.fontSize2X,
                ),
              ),
            ),
            IconButton(
              onPressed: () {
                changeCardValues(true, finish);
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
          width: double.infinity,
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
          child: Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding:
                  const EdgeInsets.only(left: CollectorsBankSizes.defaultSpace),
              child: Text(
                "${finish}s in a Deck",
                style: const TextStyle(
                  fontSize: CollectorsBankSizes.fontSizeLg,
                ),
              ),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: CollectorsBankSizes.defaultSpace),
              child: Text(
                profileFinish.inDecks.toString(),
                style: const TextStyle(
                  fontSize: CollectorsBankSizes.fontSize2X,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: CollectorsBankSizes.spaceBtwItems,
        ),
      ],
    );
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
            /// Card Image
            Center(
              child: SizedBox(
                height: CollectorsBankDeviceUtils.getScreenHeight() * 0.70,
                width: CollectorsBankDeviceUtils.getScreenWidth(context) - 30,
                child: CollectorsBankMtgHelperFunctions.checkIfMtgImage(card),
              ),
            ),

            /// create sections for each finish of the card
            Column(
              children: loopcreateFinish(dark, card.finishes),
            ),

            /// Button to add to deck
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
