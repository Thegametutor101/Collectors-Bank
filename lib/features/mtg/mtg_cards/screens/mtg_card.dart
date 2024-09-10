import 'package:collectors_bank/features/fetch_loader.dart';
import 'package:collectors_bank/features/mtg/mtg_cards/controllers/card_variations_controller.dart';
import 'package:collectors_bank/features/mtg/mtg_cards/screens/mtg_card_display.dart';
import 'package:collectors_bank/features/mtg/mtg_cards/screens/mtg_card_info.dart';
import 'package:collectors_bank/features/mtg/mtg_cards/screens/mtg_card_versions.dart';
import 'package:collectors_bank/features/mtg/mtg_cards/screens/sections/card_dot_navigation.dart';
import 'package:collectors_bank/utils/http/http_mtg.dart';
import 'package:flutter/material.dart';
import 'package:collectors_bank/features/mtg/mtg_cards/models/model_card.dart';
import 'package:get/get.dart';

class MtgCard extends StatelessWidget {
  const MtgCard({
    super.key,
    required this.isCatalogue,
    required this.card,
  });

  final bool isCatalogue;
  final ModelMtgCard card;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CardVariationsController());
    return Scaffold(
      appBar: AppBar(
        title: FittedBox(
          fit: BoxFit.fitWidth,
          child: Text(
            "${card.name} (${card.set} #${card.collector_number})",
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: FutureBuilder<List<ModelMtgCard>>(
        future: CollectorsBankHttpMtg.getMtgCardsByName(card.name),
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
            List<ModelMtgCard> cardVersions = snapshot.data;
            return Stack(
              children: [
                /// dots Navigation
                const CardDotNavigation(),

                /// Page Views for card
                PageView(
                  controller: controller.pageController,
                  onPageChanged: controller.updatePageIndicator,
                  children: [
                    MtgCardDisplay(card: card),
                    MtgCardInfo(isCatalogue: isCatalogue, card: card),
                    MtgCardVersions(
                        isCatalogue: isCatalogue, cards: cardVersions)
                  ],
                ),
              ],
            );
          }
          return Center(
            child: Text('Error fetching the ${card.set} - ${card.name} card.'),
          );
        },
      ),
    );
  }
}
