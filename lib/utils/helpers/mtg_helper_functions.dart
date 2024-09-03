import 'package:collectors_bank/common/profiles/mtg_profile.dart';
import 'package:collectors_bank/features/mtg/mtg_cards/models/model_card.dart';
import 'package:collectors_bank/features/mtg/mtg_sets/models/model_set.dart';
import 'package:collectors_bank/utils/constants/colors.dart';
import 'package:collectors_bank/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class CollectorsBankMtgHelperFunctions {
  static Widget checkIfMtgImage(ModelMtgCard card, bool useArtCrop) {
    String image = card.image_uris.normal;
    if (image == "" && card.card_faces.isNotEmpty) {
      image = card.card_faces[0].image_uris.normal;
    }
    if (useArtCrop) {
      image = card.image_uris.art_crop;
      if (image == "" && card.card_faces.isNotEmpty) {
        image = card.card_faces[0].image_uris.art_crop;
      }
    }
    if (image == "") {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.only(bottom: 5),
            child: Text(
                style: const TextStyle(
                    color: Color.fromARGB(255, 220, 220, 220),
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
                card.collector_number),
          ),
          Text(
              style: const TextStyle(
                  color: Color.fromARGB(255, 220, 220, 220),
                  fontSize: 15,
                  fontWeight: FontWeight.bold),
              card.name),
        ],
      );
    } else {
      return Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: Image.network(image).image,
            fit: BoxFit.scaleDown,
          ),
        ),
      );
    }
  }

  static Widget getSetCollected(
      bool dark, ModelMtgSet set, List<MtgProfile> mtgProfile) {
    int collected = 0;
    bool complete = false;
    for (var profileSet in mtgProfile) {
      if (profileSet.profileSet.setCode == set.code) {
        // print("setCode: $setCode");
        // print("collected: ${set.profileSet.collected}");
        collected = profileSet.profileSet.collected;
      }
    }
    if (collected == set.card_count) {
      complete = true;
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text("${collected.toString()}/${set.card_count.toString()}"),
        complete
            ? Padding(
                padding: const EdgeInsets.only(left: CollectorsBankSizes.sm),
                child: Icon(
                  Iconsax.star5,
                  size: CollectorsBankSizes.lg,
                  color: dark
                      ? CollectorsBankColors.darkPrimaryColor
                      : CollectorsBankColors.lightPrimaryColor,
                ),
              )
            : Container(),
      ],
    );
  }

  // static
}
