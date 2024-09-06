import 'package:collectors_bank/features/fetch_loader.dart';
import 'package:collectors_bank/features/mtg/mtg_cards/models/model_card.dart';
import 'package:collectors_bank/features/mtg/mtg_cards/models/model_image_uris.dart';
import 'package:collectors_bank/features/mtg/mtg_cards/models/model_related_card_objects.dart';
import 'package:collectors_bank/features/mtg/mtg_cards/models/model_rulings.dart';
import 'package:collectors_bank/features/mtg/mtg_cards/screens/mtg_card.dart';
import 'package:collectors_bank/features/mtg/mtg_set/models/model_symbols.dart';
import 'package:collectors_bank/utils/constants/colors.dart';
import 'package:collectors_bank/utils/constants/sizes.dart';
import 'package:collectors_bank/utils/device/device_utility.dart';
import 'package:collectors_bank/utils/helpers/helper_functions.dart';
import 'package:collectors_bank/utils/helpers/mtg_helper_functions.dart';
import 'package:collectors_bank/utils/helpers/router_helper.dart';
import 'package:collectors_bank/utils/http/http_server_mtg.dart';
import 'package:collectors_bank/utils/theme/custom_themes/border_side_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MtgCardInfo extends StatefulWidget {
  const MtgCardInfo({
    super.key,
    required this.setIcon,
    required this.card,
  });

  final String setIcon;
  final ModelMtgCard card;

  @override
  State<MtgCardInfo> createState() => _MtgCardInfo();
}

class _MtgCardInfo extends State<MtgCardInfo> {
  late CurrentCardFace cardFace;

  @override
  void initState() {
    super.initState();
    ModelMtgCard card = widget.card;
    if (card.card_faces.isNotEmpty) {
      cardFace = CurrentCardFace(
        name: card.card_faces[0].name,
        mana_cost: card.card_faces[0].mana_cost,
        type_line: card.card_faces[0].type_line,
        oracle_text: card.card_faces[0].oracle_text,
        colors: card.card_faces[0].colors,
        color_indicator: card.card_faces[0].color_indicator,
        power: card.card_faces[0].power,
        toughness: card.card_faces[0].toughness,
        artist: card.card_faces[0].artist,
        image_uris: card.card_faces[0].image_uris,
      );
    } else {
      cardFace = CurrentCardFace(
        name: card.name,
        mana_cost: card.mana_cost,
        type_line: card.type_line,
        oracle_text: card.oracle_text,
        colors: card.colors,
        color_indicator: card.color_indicator,
        power: card.power,
        toughness: card.toughness,
        artist: card.artist,
        image_uris: card.image_uris,
      );
    }
  }

  void changeCardFace(CurrentCardFace _cardFace) {
    ModelMtgCard card = widget.card;
    int index = 0;
    setState(() {
      if (_cardFace.name == card.card_faces[0].name) {
        index = 1;
      }
      cardFace = CurrentCardFace(
        name: card.card_faces[index].name,
        mana_cost: card.card_faces[index].mana_cost,
        type_line: card.card_faces[index].type_line,
        oracle_text: card.card_faces[index].oracle_text,
        colors: card.card_faces[index].colors,
        color_indicator: card.card_faces[index].color_indicator,
        power: card.card_faces[index].power,
        toughness: card.card_faces[index].toughness,
        artist: card.card_faces[index].artist,
        image_uris: card.card_faces[index].image_uris,
      );
    });
  }

  Widget checkIsCreature(CurrentCardFace card) {
    if (card.type_line.toLowerCase().contains("creature")) {
      return SizedBox(
        height: CollectorsBankSizes.appBarHeight,
        child: Padding(
          padding:
              const EdgeInsets.only(right: CollectorsBankSizes.defaultSpace),
          child: Align(
            alignment: Alignment.centerRight,
            child: Text(
              "${card.power}/${card.toughness}",
              style: const TextStyle(
                fontSize: CollectorsBankSizes.fontSizeXl,
              ),
            ),
          ),
        ),
      );
    }
    return const SizedBox(
      height: CollectorsBankSizes.dividerHeight,
    );
  }

  Widget getRulings(bool dark, ModelMtgCard card) {
    return FutureBuilder<List<ModelRulings>>(
      future: CollectorsBankHttpServer.getMtgCardRulings(
          card.name, card.rulings_uri),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.data == null ||
            snapshot.connectionState == ConnectionState.waiting) {
          return const FetchLoader();
        }
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.hasError) {
          return const Center(
            child: Text('Error fetching rulings for this card.'),
          );
        }
        if (snapshot.connectionState == ConnectionState.done) {
          List<ModelRulings> rulings = snapshot.data;
          List<Widget> displayRulings = [];
          for (var ruling in rulings) {
            displayRulings.add(loopRulings(dark, ruling));
          }
          return Padding(
            padding: const EdgeInsets.symmetric(
                vertical: CollectorsBankSizes.spaceBtwSections),
            child: Container(
              decoration: BoxDecoration(
                border: Border(
                  top: dark
                      ? CollectorsBankBorderSideTheme.darkBorderSideTheme
                      : CollectorsBankBorderSideTheme.lightBorderSideTheme,
                ),
              ),
              alignment: Alignment.centerLeft,
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Rulings",
                      style: TextStyle(
                        color: dark
                            ? CollectorsBankColors.darkPrimaryTextColor
                            : CollectorsBankColors.lightPrimaryTextColor,
                        fontSize: CollectorsBankSizes.fontSizeLg,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: CollectorsBankSizes.defaultSpace),
                      child: Column(
                        children: displayRulings,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }
        return const Center(
          child: Text('Error fetching rulings for this card.'),
        );
      },
    );
  }

  Widget loopRulings(bool dark, ModelRulings ruling) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          vertical: CollectorsBankSizes.spaceBtwItems),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            ruling.comment,
            style: const TextStyle(
              fontSize: CollectorsBankSizes.fontSizeLg,
            ),
          ),
          const SizedBox(
            height: CollectorsBankSizes.xs,
          ),
          Row(
            children: [
              const Text(
                "Source: ",
                style: TextStyle(
                  fontSize: CollectorsBankSizes.fontSizeMd,
                ),
              ),
              Text(
                ruling.source,
                style: TextStyle(
                  color: dark
                      ? CollectorsBankColors.darkPrimaryTextColor
                      : CollectorsBankColors.lightPrimaryTextColor,
                  fontSize: CollectorsBankSizes.fontSizeMd,
                ),
              ),
            ],
          ),
          Text(
            ruling.published_at,
            style: TextStyle(
              color: dark
                  ? CollectorsBankColors.darkPrimaryTextColor
                  : CollectorsBankColors.lightPrimaryTextColor,
              fontSize: CollectorsBankSizes.fontSizeMd,
            ),
          ),
        ],
      ),
    );
  }

  Widget getRelatedCards(bool dark, ModelMtgCard card) {
    List<Widget> relatedCards = [];
    for (var relatedCard in card.all_parts) {
      relatedCards.add(getRelatedCard(dark, relatedCard));
    }
    return Padding(
      padding: const EdgeInsets.symmetric(
          vertical: CollectorsBankSizes.spaceBtwSections),
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            top: dark
                ? CollectorsBankBorderSideTheme.darkBorderSideTheme
                : CollectorsBankBorderSideTheme.lightBorderSideTheme,
          ),
        ),
        alignment: Alignment.centerLeft,
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                "Related Cards",
                style: TextStyle(
                  color: dark
                      ? CollectorsBankColors.darkPrimaryTextColor
                      : CollectorsBankColors.lightPrimaryTextColor,
                  fontSize: CollectorsBankSizes.fontSizeLg,
                ),
              ),
            ),
            Column(
              children: relatedCards,
            ),
          ],
        ),
      ),
    );
  }

  Widget getRelatedCard(bool dark, RelatedCardObjects relatedCard) {
    return FutureBuilder<ModelMtgCard>(
      future: CollectorsBankHttpServer.getMtgCardsByUri(relatedCard.uri),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.data == null ||
            snapshot.connectionState == ConnectionState.waiting) {
          return const FetchLoader();
        }
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.hasError) {
          return const Center(
            child: Text('Error fetching rulings for this card.'),
          );
        }
        if (snapshot.connectionState == ConnectionState.done) {
          ModelMtgCard card = snapshot.data;
          return loopRelatedCards(dark, card, relatedCard.component);
        }
        return const Center(
          child: Text('Error fetching rulings for this card.'),
        );
      },
    );
  }

  Widget loopRelatedCards(bool dark, ModelMtgCard card, String relationship) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          vertical: CollectorsBankSizes.spaceBtwItems),
      child: Padding(
        padding: const EdgeInsets.only(right: CollectorsBankSizes.defaultSpace),
        child: InkWell(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 100,
                width: 140,
                child: CollectorsBankMtgHelperFunctions.checkIfMtgImage(
                  card,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(printRelationship(relationship)),
                  FittedBox(
                    fit: BoxFit.fitWidth,
                    child: Text(card.card_faces.isNotEmpty
                        ? card.card_faces[0].name
                        : card.name),
                  ),
                  FittedBox(
                    fit: BoxFit.fitWidth,
                    child: Text(card.card_faces.isNotEmpty
                        ? card.card_faces[0].type_line
                        : card.type_line),
                  ),
                ],
              )
            ],
          ),
          onTap: () {
            Navigator.pushNamed(
              context,
              RouterHelper.getMtgCard(),
              arguments: MtgCard(
                setIcon: widget.setIcon,
                card: card,
              ),
            );
          },
        ),
      ),
    );
  }

  String printRelationship(String relationship) {
    switch (relationship) {
      case "token":
        return "Token";
      case "meld_part":
        return "Meld Part";
      case "meld_result":
        return "Meld Result";
      case "combo_piece":
        return "Combo Piece";
      default:
        return "";
    }
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
            return Padding(
              padding: const EdgeInsets.only(top: 55),
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
                child: ListView(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  children: [
                    /// Card art_crop
                    InkWell(
                      child: SizedBox(
                        height:
                            CollectorsBankDeviceUtils.getScreenHeight() * 0.35,
                        width:
                            CollectorsBankDeviceUtils.getScreenWidth(context) -
                                30,
                        child: CollectorsBankMtgHelperFunctions.showMtgArtCrop(
                          cardFace,
                        ),
                      ),
                      onTap: () {
                        if (card.card_faces.isNotEmpty) {
                          changeCardFace(cardFace);
                        }
                      },
                    ),

                    /// Card name
                    CardInfoName(dark: dark, card: cardFace),

                    /// mana_cost
                    CardInfoManaCost(card: cardFace, symbols: symbols),

                    /// type_line + rarity (logo?)
                    CardInfoRarityAndType(
                      dark: dark,
                      widget: widget,
                      card: card,
                      cardFace: cardFace,
                    ),

                    /// oracle_text
                    CardInfoOracleText(
                        dark: dark, card: cardFace, symbols: symbols),

                    /// if creature = power / toughness
                    checkIsCreature(cardFace),

                    /// set_name + code
                    CardInfoSet(dark: dark, card: card),

                    /// prices
                    CardInfoPrices(dark: dark, card: card),

                    /// isOversized + isPromo + isReprint
                    CardInfoPromoReprintOversized(dark: dark, card: card),

                    /// artist
                    CardInfoArtist(dark: dark, card: cardFace),

                    /// edhrec_rank
                    CardInfoEdhrecRank(card: card, dark: dark),

                    /// availability (games)
                    CardInfoAvailability(dark: dark, card: card),

                    /// legalities
                    CardInfoLegalities(dark: dark, card: card),

                    /// Rulings
                    getRulings(dark, card),

                    /// Related Cards
                    getRelatedCards(dark, card),
                  ],
                ),
              ),
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

class CurrentCardFace {
  final String name;
  final String mana_cost;
  final String type_line;
  final String oracle_text;
  final List<String> colors;
  final List<String> color_indicator;
  final String power;
  final String toughness;
  final String artist;
  final ImageUris image_uris;

  CurrentCardFace(
      {required this.name,
      required this.mana_cost,
      required this.type_line,
      required this.oracle_text,
      required this.colors,
      required this.color_indicator,
      required this.power,
      required this.toughness,
      required this.artist,
      required this.image_uris});
}

class CardInfoLegalities extends StatelessWidget {
  const CardInfoLegalities({
    super.key,
    required this.dark,
    required this.card,
  });

  final bool dark;
  final ModelMtgCard card;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: dark
              ? CollectorsBankBorderSideTheme.darkBorderSideTheme
              : CollectorsBankBorderSideTheme.lightBorderSideTheme,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: CollectorsBankSizes.sm),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                "Legalities",
                style: TextStyle(
                  color: dark
                      ? CollectorsBankColors.darkPrimaryTextColor
                      : CollectorsBankColors.lightPrimaryTextColor,
                  fontSize: CollectorsBankSizes.fontSizeLg,
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width:
                            CollectorsBankDeviceUtils.getScreenWidth(context) *
                                0.5,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            LegalityLabel(dark: dark, label: "Standard"),
                            LegalityLabel(dark: dark, label: "Future"),
                            LegalityLabel(dark: dark, label: "Historic"),
                            LegalityLabel(dark: dark, label: "Timeless"),
                            LegalityLabel(dark: dark, label: "Gladiator"),
                            LegalityLabel(dark: dark, label: "Pioneer"),
                            LegalityLabel(dark: dark, label: "Explorer"),
                            LegalityLabel(dark: dark, label: "Modern"),
                            LegalityLabel(dark: dark, label: "Legacy"),
                            LegalityLabel(dark: dark, label: "Pauper"),
                            LegalityLabel(dark: dark, label: "Vintage"),
                            LegalityLabel(dark: dark, label: "Penny"),
                            LegalityLabel(dark: dark, label: "Commander"),
                            LegalityLabel(dark: dark, label: "Oathbreaker"),
                            LegalityLabel(dark: dark, label: "Standard Brawl"),
                            LegalityLabel(dark: dark, label: "Brawl"),
                            LegalityLabel(dark: dark, label: "Alchemy"),
                            LegalityLabel(
                                dark: dark, label: "Pauper Commander"),
                            LegalityLabel(dark: dark, label: "Duel"),
                            LegalityLabel(dark: dark, label: "Old School"),
                            LegalityLabel(dark: dark, label: "Pre-Modern"),
                            LegalityLabel(dark: dark, label: "Predh"),
                          ],
                        ),
                      ),
                      Column(
                        children: [
                          LegalityTag(
                              dark: dark, legality: card.legalities.standard),
                          LegalityTag(
                              dark: dark, legality: card.legalities.future),
                          LegalityTag(
                              dark: dark, legality: card.legalities.historic),
                          LegalityTag(
                              dark: dark, legality: card.legalities.timeless),
                          LegalityTag(
                              dark: dark, legality: card.legalities.gladiator),
                          LegalityTag(
                              dark: dark, legality: card.legalities.pioneer),
                          LegalityTag(
                              dark: dark, legality: card.legalities.explorer),
                          LegalityTag(
                              dark: dark, legality: card.legalities.modern),
                          LegalityTag(
                              dark: dark, legality: card.legalities.legacy),
                          LegalityTag(
                              dark: dark, legality: card.legalities.pauper),
                          LegalityTag(
                              dark: dark, legality: card.legalities.vintage),
                          LegalityTag(
                              dark: dark, legality: card.legalities.penny),
                          LegalityTag(
                              dark: dark, legality: card.legalities.commander),
                          LegalityTag(
                              dark: dark,
                              legality: card.legalities.oathbreaker),
                          LegalityTag(
                              dark: dark,
                              legality: card.legalities.standardbrawl),
                          LegalityTag(
                              dark: dark, legality: card.legalities.brawl),
                          LegalityTag(
                              dark: dark, legality: card.legalities.alchemy),
                          LegalityTag(
                              dark: dark,
                              legality: card.legalities.paupercommander),
                          LegalityTag(
                              dark: dark, legality: card.legalities.duel),
                          LegalityTag(
                              dark: dark, legality: card.legalities.oldschool),
                          LegalityTag(
                              dark: dark, legality: card.legalities.premodern),
                          LegalityTag(
                              dark: dark, legality: card.legalities.predh),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CardInfoAvailability extends StatelessWidget {
  const CardInfoAvailability({
    super.key,
    required this.dark,
    required this.card,
  });

  final bool dark;
  final ModelMtgCard card;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          vertical: CollectorsBankSizes.spaceBtwItems),
      child: Container(
        decoration: BoxDecoration(
            border: Border(
          top: dark
              ? CollectorsBankBorderSideTheme.darkBorderSideTheme
              : CollectorsBankBorderSideTheme.lightBorderSideTheme,
        )),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: CollectorsBankSizes.spaceBtwItems),
                child: Text(
                  "Availablilities",
                  style: TextStyle(
                      color: dark
                          ? CollectorsBankColors.darkPrimaryTextColor
                          : CollectorsBankColors.lightPrimaryTextColor,
                      fontSize: CollectorsBankSizes.fontSizeLg),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: CollectorsBankMtgHelperFunctions.loopCardAvailabilities(
                  dark, card),
            ),
          ],
        ),
      ),
    );
  }
}

class CardInfoEdhrecRank extends StatelessWidget {
  const CardInfoEdhrecRank({
    super.key,
    required this.card,
    required this.dark,
  });

  final ModelMtgCard card;
  final bool dark;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.symmetric(
            vertical: CollectorsBankSizes.spaceBtwItems),
        child: Row(
          children: [
            const Text(
              "EDHREC ranking #",
              style: TextStyle(
                fontSize: CollectorsBankSizes.fontSizeLg,
              ),
            ),
            Text(
              card.edhrec_rank.toString(),
              style: TextStyle(
                color: dark
                    ? CollectorsBankColors.darkPrimaryTextColor
                    : CollectorsBankColors.lightPrimaryTextColor,
                fontSize: CollectorsBankSizes.fontSizeLg,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CardInfoArtist extends StatelessWidget {
  const CardInfoArtist({
    super.key,
    required this.dark,
    required this.card,
  });

  final bool dark;
  final CurrentCardFace card;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: dark
              ? CollectorsBankBorderSideTheme.darkBorderSideTheme
              : CollectorsBankBorderSideTheme.lightBorderSideTheme,
        ),
      ),
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.symmetric(
            vertical: CollectorsBankSizes.spaceBtwItems),
        child: Row(
          children: [
            const Text(
              "Art by: ",
              style: TextStyle(
                fontSize: CollectorsBankSizes.fontSizeLg,
              ),
            ),
            Text(
              card.artist,
              style: TextStyle(
                color: dark
                    ? CollectorsBankColors.darkPrimaryTextColor
                    : CollectorsBankColors.lightPrimaryTextColor,
                fontSize: CollectorsBankSizes.fontSizeLg,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CardInfoPromoReprintOversized extends StatelessWidget {
  const CardInfoPromoReprintOversized({
    super.key,
    required this.dark,
    required this.card,
  });

  final bool dark;
  final ModelMtgCard card;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: dark
              ? CollectorsBankBorderSideTheme.darkBorderSideTheme
              : CollectorsBankBorderSideTheme.lightBorderSideTheme,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
            vertical: CollectorsBankSizes.spaceBtwItems),
        child: Padding(
          padding:
              const EdgeInsets.only(left: CollectorsBankSizes.defaultSpace),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: CollectorsBankDeviceUtils.getScreenWidth(context) *
                        0.35,
                    child: const Text(
                      "Oversized: ",
                      style: TextStyle(
                        fontSize: CollectorsBankSizes.fontSizeMd,
                      ),
                    ),
                  ),
                  card.oversized
                      ? const Text(
                          "Yes",
                          style: TextStyle(
                            fontSize: CollectorsBankSizes.fontSizeMd,
                            color: Colors.green,
                          ),
                        )
                      : const Text(
                          "No",
                          style: TextStyle(
                            fontSize: CollectorsBankSizes.fontSizeMd,
                            color: Colors.red,
                          ),
                        ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: CollectorsBankDeviceUtils.getScreenWidth(context) *
                        0.35,
                    child: const Text(
                      "Promo: ",
                      style: TextStyle(
                        fontSize: CollectorsBankSizes.fontSizeMd,
                      ),
                    ),
                  ),
                  card.promo
                      ? const Text(
                          "Yes",
                          style: TextStyle(
                            fontSize: CollectorsBankSizes.fontSizeMd,
                            color: Colors.green,
                          ),
                        )
                      : const Text(
                          "No",
                          style: TextStyle(
                            fontSize: CollectorsBankSizes.fontSizeMd,
                            color: Colors.red,
                          ),
                        ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: CollectorsBankDeviceUtils.getScreenWidth(context) *
                        0.35,
                    child: const Text(
                      "Reprinted: ",
                      style: TextStyle(
                        fontSize: CollectorsBankSizes.fontSizeMd,
                      ),
                    ),
                  ),
                  card.reprint
                      ? const Text(
                          "Yes",
                          style: TextStyle(
                            fontSize: CollectorsBankSizes.fontSizeMd,
                            color: Colors.green,
                          ),
                        )
                      : const Text(
                          "No",
                          style: TextStyle(
                            fontSize: CollectorsBankSizes.fontSizeMd,
                            color: Colors.red,
                          ),
                        ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CardInfoPrices extends StatelessWidget {
  const CardInfoPrices({
    super.key,
    required this.dark,
    required this.card,
  });

  final bool dark;
  final ModelMtgCard card;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: dark
              ? CollectorsBankBorderSideTheme.darkBorderSideTheme
              : CollectorsBankBorderSideTheme.lightBorderSideTheme,
        ),
      ),
      padding: const EdgeInsets.only(bottom: CollectorsBankSizes.spaceBtwItems),
      child: Column(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              "Prices",
              style: TextStyle(
                color: dark
                    ? CollectorsBankColors.darkPrimaryTextColor
                    : CollectorsBankColors.lightPrimaryTextColor,
                fontSize: CollectorsBankSizes.fontSizeLg,
              ),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(left: CollectorsBankSizes.defaultSpace),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width:
                      CollectorsBankDeviceUtils.getScreenWidth(context) * 0.5,
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Non Foil",
                        style: TextStyle(
                          fontSize: CollectorsBankSizes.fontSizeLg,
                        ),
                      ),
                      Text(
                        "Foil",
                        style: TextStyle(
                          fontSize: CollectorsBankSizes.fontSizeLg,
                        ),
                      ),
                      Text(
                        "Etched Foil",
                        style: TextStyle(
                          fontSize: CollectorsBankSizes.fontSizeLg,
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "\$${CollectorsBankHelperFunctions.checkPriceEmpty(card.prices.usd)}",
                      style: TextStyle(
                        fontSize: CollectorsBankSizes.fontSizeLg,
                        color: dark
                            ? CollectorsBankColors.darkTextSecondaryColor
                            : CollectorsBankColors.lightTextSecondaryColor,
                      ),
                    ),
                    Text(
                      "\$${CollectorsBankHelperFunctions.checkPriceEmpty(card.prices.usd_foil)}",
                      style: TextStyle(
                        fontSize: CollectorsBankSizes.fontSizeLg,
                        color: dark
                            ? CollectorsBankColors.darkTextSecondaryColor
                            : CollectorsBankColors.lightTextSecondaryColor,
                      ),
                    ),
                    Text(
                      "\$${CollectorsBankHelperFunctions.checkPriceEmpty(card.prices.usd_etched)}",
                      style: TextStyle(
                        fontSize: CollectorsBankSizes.fontSizeLg,
                        color: dark
                            ? CollectorsBankColors.darkTextSecondaryColor
                            : CollectorsBankColors.lightTextSecondaryColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CardInfoSet extends StatelessWidget {
  const CardInfoSet({
    super.key,
    required this.dark,
    required this.card,
  });

  final bool dark;
  final ModelMtgCard card;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: dark
              ? CollectorsBankBorderSideTheme.darkBorderSideTheme
              : CollectorsBankBorderSideTheme.lightBorderSideTheme,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: CollectorsBankSizes.sm),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                "Set",
                style: TextStyle(
                  color: dark
                      ? CollectorsBankColors.darkPrimaryTextColor
                      : CollectorsBankColors.lightPrimaryTextColor,
                  fontSize: CollectorsBankSizes.fontSizeLg,
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
                    "${card.set_name} (${card.set})",
                    style: const TextStyle(
                      fontSize: CollectorsBankSizes.fontSizeLg,
                    ),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(
                    left: CollectorsBankSizes.defaultSpace),
                child: Row(
                  children: [
                    const Text(
                      "Collector Number: #",
                      style: TextStyle(
                        fontSize: CollectorsBankSizes.fontSizeLg,
                      ),
                    ),
                    Text(
                      card.collector_number,
                      style: TextStyle(
                        color: dark
                            ? CollectorsBankColors.darkPrimaryTextColor
                            : CollectorsBankColors.lightPrimaryTextColor,
                        fontSize: CollectorsBankSizes.fontSizeLg,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CardInfoOracleText extends StatelessWidget {
  const CardInfoOracleText({
    super.key,
    required this.dark,
    required this.card,
    required this.symbols,
  });

  final bool dark;
  final CurrentCardFace card;
  final List<ModelSymbols> symbols;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: dark
              ? CollectorsBankColors.darkScaffoldAccentColor
              : CollectorsBankColors.lightScaffoldAccentColor,
          style: BorderStyle.solid,
          width: 2,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(CollectorsBankSizes.spaceBtwItems),
        child: Text.rich(
          TextSpan(
            children: CollectorsBankMtgHelperFunctions.replaceIconsInText(
              card.oracle_text,
              symbols,
            ),
          ),
          style: const TextStyle(fontSize: CollectorsBankSizes.fontSizeMd),
        ),
      ),
    );
  }
}

class CardInfoRarityAndType extends StatelessWidget {
  const CardInfoRarityAndType({
    super.key,
    required this.dark,
    required this.widget,
    required this.card,
    required this.cardFace,
  });

  final bool dark;
  final MtgCardInfo widget;
  final ModelMtgCard card;
  final CurrentCardFace cardFace;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: CollectorsBankSizes.sm),
          child: SizedBox(
            width: CollectorsBankSizes.iconMd,
            height: CollectorsBankSizes.iconMd,
            child: SvgPicture.network(
              widget.setIcon,
              // ignore: deprecated_member_use
              color: CollectorsBankColors
                  .mtgRarities[card.rarity.substring(0, 1).toUpperCase()],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
              vertical: CollectorsBankSizes.spaceBtwItems),
          child: FittedBox(
            fit: BoxFit.fitWidth,
            child: Text(
              cardFace.type_line,
              style: const TextStyle(
                fontSize: CollectorsBankSizes.fontSizeLg,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class CardInfoManaCost extends StatelessWidget {
  const CardInfoManaCost({
    super.key,
    required this.card,
    required this.symbols,
  });

  final CurrentCardFace card;
  final List<ModelSymbols> symbols;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: CollectorsBankSizes.spaceBtwItems),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: CollectorsBankMtgHelperFunctions.showManaCost(card, symbols),
      ),
    );
  }
}

class CardInfoName extends StatelessWidget {
  const CardInfoName({
    super.key,
    required this.dark,
    required this.card,
  });

  final bool dark;
  final CurrentCardFace card;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: dark
              ? CollectorsBankBorderSideTheme.darkBorderSideTheme
              : CollectorsBankBorderSideTheme.lightBorderSideTheme,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: CollectorsBankSizes.sm),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding:
                const EdgeInsets.only(left: CollectorsBankSizes.defaultSpace),
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
      ),
    );
  }
}

class LegalityLabel extends StatelessWidget {
  const LegalityLabel({
    super.key,
    required this.dark,
    required this.label,
  });

  final bool dark;
  final String label;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: CollectorsBankSizes.fontSizeLg + 16,
      child: Text(
        label,
        style: TextStyle(
          fontSize: CollectorsBankSizes.fontSizeLg,
          color: dark
              ? CollectorsBankColors.darkTextSecondaryColor
              : CollectorsBankColors.lightTextSecondaryColor,
        ),
      ),
    );
  }
}

class LegalityTag extends StatelessWidget {
  const LegalityTag({
    super.key,
    required this.dark,
    required this.legality,
  });

  final bool dark;
  final String legality;

  String displayLegality(String legality) {
    switch (legality) {
      case "legal":
        return "Legal";
      case "not_legal":
        return "Not legal";
      case "restricted":
        return "Restricted";
      case "banned":
        return "Banned";
      default:
        return "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Container(
        width: CollectorsBankDeviceUtils.getScreenWidth(context) * 0.30,
        height: CollectorsBankSizes.fontSizeLg + 12,
        padding: const EdgeInsets.symmetric(vertical: 2),
        alignment: Alignment.center,
        color:
            CollectorsBankMtgHelperFunctions.checkMtgLegality(dark, legality),
        child: Text(
          displayLegality(legality),
          style: const TextStyle(
            fontSize: CollectorsBankSizes.fontSizeLg,
          ),
        ),
      ),
    );
  }
}
