import 'package:collectors_bank/common/profiles/mtg_profile.dart';
import 'package:collectors_bank/utils/constants/sizes.dart';
import 'package:collectors_bank/utils/device/device_utility.dart';
import 'package:collectors_bank/utils/helpers/helper_functions.dart';
import 'package:collectors_bank/utils/local_storage/storage_mtg.dart';
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
            collected: 0,
            cards: [],
          ),
        ),
      );
    }
    if (!cardExists) {
      for (var set in mtgProfile) {
        if (set.profileSet.setCode == widget.card.set) {
          set.profileSet.cards.add(
            MtgProfileCard(
              cardCode: widget.card.id,
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
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: CollectorsBankDeviceUtils.getScreenHeight() * 0.70,
          width: double.infinity,
          child: CollectorsBankHelperFunctions.checkIfMtgImage(card),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                Text(
                  ownedCopies.toString(),
                  style: const TextStyle(
                    fontSize: CollectorsBankSizes.fontSizeXl,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () {
                        changeCardValues(true, true);
                      },
                      icon: const Icon(
                        Iconsax.add_circle,
                        size: CollectorsBankSizes.iconXl,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        changeCardValues(true, false);
                      },
                      icon: const Icon(
                        Iconsax.minus_cirlce,
                        size: CollectorsBankSizes.iconXl,
                      ),
                    ),
                  ],
                ),
                const Text(
                  "Owned copies",
                  style: TextStyle(
                    fontSize: CollectorsBankSizes.fontSizeXl,
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Text(
                  inADeck.toString(),
                  style: const TextStyle(
                    fontSize: CollectorsBankSizes.fontSizeXl,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () {
                        changeCardValues(false, true);
                      },
                      icon: const Icon(
                        Iconsax.add_circle,
                        size: CollectorsBankSizes.iconXl,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        changeCardValues(false, false);
                      },
                      icon: const Icon(
                        Iconsax.minus_cirlce,
                        size: CollectorsBankSizes.iconXl,
                      ),
                    ),
                  ],
                ),
                const Text(
                  "Cards in a Deck",
                  style: TextStyle(
                    fontSize: CollectorsBankSizes.fontSizeXl,
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
