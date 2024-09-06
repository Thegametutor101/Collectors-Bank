import 'package:collectors_bank/common/profiles/mtg_profile.dart';
import 'package:collectors_bank/features/mtg/mtg_cards/models/model_card.dart';
import 'package:collectors_bank/features/mtg/mtg_set/models/model_set.dart';
import 'package:collectors_bank/features/mtg/mtg_set/models/model_symbols.dart';
import 'package:collectors_bank/utils/constants/colors.dart';
import 'package:collectors_bank/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
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
      var networkImage = Image.network(image);
      return Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: networkImage.image,
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

  static List<Widget> showManaCost(
      ModelMtgCard card, List<ModelSymbols> symbols) {
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

  static Color? checkMtgLegality(bool dark, String legality) {
    switch (legality) {
      case "legal":
        return dark
            ? CollectorsBankColors.darkMtgLegalities["legal"]
            : CollectorsBankColors.lightMtgLegalities["legal"];
      case "not_legal":
        return dark
            ? CollectorsBankColors.darkMtgLegalities["not_legal"]
            : CollectorsBankColors.lightMtgLegalities["not_legal"];
      case "restricted":
        return dark
            ? CollectorsBankColors.darkMtgLegalities["restricted"]
            : CollectorsBankColors.lightMtgLegalities["restricted"];
      case "banned":
        return dark
            ? CollectorsBankColors.darkMtgLegalities["banned"]
            : CollectorsBankColors.lightMtgLegalities["banned"];
      default:
        return dark
            ? CollectorsBankColors.darkMtgLegalities[""]
            : CollectorsBankColors.lightMtgLegalities[""];
    }
  }

  static List<Widget> loopCardAvailabilities(bool dark, ModelMtgCard card) {
    List<Widget> availables = [];
    for (var availability in card.games) {
      availables.add(
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: dark
                  ? CollectorsBankColors.darkScaffoldAccentColor
                  : CollectorsBankColors.lightScaffoldAccentColor,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(CollectorsBankSizes.sm),
            child: Text(
              availability.substring(0, 1).toUpperCase() +
                  availability.substring(1),
              style: const TextStyle(fontSize: CollectorsBankSizes.fontSizeMd),
            ),
          ),
        ),
      );
    }
    return availables;
  }

  static List<InlineSpan> replaceIconsInText(
      String oracleText, List<ModelSymbols> symbols) {
    List<InlineSpan> result = [];
    String text = oracleText;
    while (text.contains("{")) {
      String textBeforeIcon = text.substring(0, text.indexOf("{"));
      result.add(
        TextSpan(
          text: textBeforeIcon,
        ),
      );
      String iconInText =
          text.substring(text.indexOf("{"), text.indexOf("}") + 1);
      for (var symbol in symbols) {
        if (symbol.symbol == iconInText) {
          result.add(
            WidgetSpan(
              child: SizedBox(
                width: 22,
                height: 22,
                child: SvgPicture.network(symbol.svg_uri),
              ),
            ),
          );
        }
      }
      if (text.indexOf("}") + 1 < text.length) {
        text = text.substring(text.indexOf("}") + 1);
      } else {
        text = text.substring(text.indexOf("}"));
      }
    }
    if (!text.contains("{")) {
      result.add(
        TextSpan(
          text: text,
        ),
      );
    }
    return result;
  }
}
