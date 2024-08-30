import 'package:collectors_bank/common/profiles/mtg_profile.dart';
import 'package:collectors_bank/features/mtg/mtg_cards/models/model_card.dart';
import 'package:flutter/material.dart';

class CollectorsBankMtgHelperFunctions {
  static Widget checkIfMtgImage(ModelMtgCard card) {
    String image = card.image_uris.normal;
    if (image == "" && card.card_faces.isNotEmpty) {
      image = card.card_faces[0].image_uris.normal;
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

  static String getSetCollected(String setCode, List<MtgProfile> mtgProfile) {
    String collected = '0';
    for (var set in mtgProfile) {
      if (set.profileSet.setCode == setCode) {
        // print("setCode: $setCode");
        // print("collected: ${set.profileSet.collected}");
        collected = set.profileSet.collected.toString();
      }
    }
    return collected;
  }
}
