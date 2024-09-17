import 'package:collectors_bank/features/fetch_loader.dart';
import 'package:collectors_bank/features/mtg/mtg_cards/models/model_card.dart';
import 'package:collectors_bank/features/mtg/mtg_set/models/model_symbols.dart';
import 'package:collectors_bank/utils/constants/sizes.dart';
import 'package:collectors_bank/utils/device/device_utility.dart';
import 'package:collectors_bank/utils/http/http_mtg.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

// ignore: must_be_immutable
class MtgSearch extends StatelessWidget {
  MtgSearch({
    super.key,
    required this.searchTab,
  });

  final String searchTab;
  Map<String, String> requestString = {
    "Name": "",
    "Group_Listings": "",
    "Type_Line": "",
    "Oracle_Text": "",
    "CMC": "",
    "Colors": "",
    "Power": "",
    "Toughness": "",
    "Set_Name": "",
    "Set_Code": "",
    "Rarity": "",
    "Artist": "",
  };

  List<ModelMtgCard> getCardsContainName(String name) {
    List<ModelMtgCard> cards = [];
    FutureBuilder<List<ModelMtgCard>>(
      future: CollectorsBankHttpMtg.getMtgCardsByNamePart(name),
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
          cards = snapshot.data;
        }
        return const Center(
          child: Text('Error fetching rulings for this card.'),
        );
      },
    );
    return cards;
  }

  @override
  Widget build(BuildContext context) {
    bool dark = CollectorsBankDeviceUtils.isDarkMode(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Magic - Search $searchTab",
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () {},
            icon: const Icon(Iconsax.search_normal_1),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: CollectorsBankSizes.defaultSpace),
        child: FutureBuilder<List<ModelSymbols>>(
          future: CollectorsBankHttpMtg.getMtgSymbols(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.data == null ||
                snapshot.connectionState == ConnectionState.waiting) {
              return const FetchLoader();
            }
            if (snapshot.connectionState == ConnectionState.done &&
                snapshot.hasError) {
              return Center(
                child: Text(
                    'Error fetching Mtg Symbols. ${snapshot.error.toString()}'),
              );
            }
            if (snapshot.connectionState == ConnectionState.done) {
              List<ModelSymbols> symbols = snapshot.data;
              return ListView(
                children: [
                  /// Card Name
                  Autocomplete<ModelMtgCard>(
                    optionsBuilder: (TextEditingValue cardNameEditingValue) {
                      List<ModelMtgCard> cards = [];
                      if (cardNameEditingValue.text.length >= 3) {
                        cards = getCardsContainName(cardNameEditingValue.text);
                      }
                      return cards.where(
                        (ModelMtgCard option) {
                          return option.name.contains(
                              cardNameEditingValue.text.toLowerCase());
                        },
                      );
                    },
                  ),

                  /// Group Prints (Radio or other kind of button)
                  /// [Seperator]
                  /// Type Line
                  /// oracle Text
                  /// CMC
                  /// Colors with 6clickable icons
                  /// Power + Toughness
                  /// [Seperator]
                  /// Set Name and Code
                  /// Rarity dropdown
                  /// Artist
                ],
              );
            }
            return const Center(
              child: Text("Error fetching Symbols."),
            );
          },
        ),
      ),
    );
  }
}
