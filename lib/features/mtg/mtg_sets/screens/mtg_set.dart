import 'package:collectors_bank/features/fetch_loaders.dart';
import 'package:collectors_bank/features/mtg/mtg_sets/models/model_set.dart';
import 'package:collectors_bank/utils/constants/sizes.dart';
import 'package:collectors_bank/utils/constants/variables.dart';
import 'package:collectors_bank/utils/helpers/helper_functions.dart';
import 'package:collectors_bank/utils/http/http_server_mtg.dart';
import 'package:collectors_bank/features/mtg/mtg_cards/models/model_card.dart';
import 'package:collectors_bank/features/mtg/mtg_cards/screens/mtg_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class MtgSetPage extends StatefulWidget {
  const MtgSetPage({super.key, required this.set});

  final ModelMtgSet set;

  @override
  State<MtgSetPage> createState() => _MtgSetPage();
}

class _MtgSetPage extends State<MtgSetPage> {
  @override
  Widget build(BuildContext context) {
    // Get.back(result: "updateCollected");
    String setName = widget.set.name;
    return Scaffold(
      appBar: AppBar(
        title: Text(setName),
      ),
      body: FutureBuilder<List<ModelMtgCard>>(
        future: CollectorsBankHttpServer.getMtgCards(
            widget.set.code, widget.set.search_uri),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.data == null ||
              snapshot.connectionState == ConnectionState.waiting) {
            return const FetchLoader();
          }
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.hasError) {
            return Center(
              child: Text(
                  'Error fetching cards from set $setName. ${snapshot.error.toString()}'),
            );
          }
          if (snapshot.connectionState == ConnectionState.done) {
            List<ModelMtgCard> cards = snapshot.data;
            return Padding(
              padding: const EdgeInsets.all(CollectorsBankSizes.md),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: CollectorsBankVariables.numerOfCardsPerRow,
                  mainAxisSpacing: CollectorsBankSizes.gridViewSpacing,
                  crossAxisSpacing: CollectorsBankSizes.gridViewSpacing,
                  childAspectRatio: (5 / 7),
                ),
                itemCount: cards.length,
                itemBuilder: (context, index) {
                  return SizedBox(
                    height: 100,
                    width: 80,
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => MtgCard(card: cards[index]),
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: CollectorsBankSizes.sm),
                        child: CollectorsBankHelperFunctions.checkIfMtgImage(
                            cards[index]),
                      ),
                    ),
                  );
                },
              ),
            );
          }
          return Center(
            child: Text('Error fetching the cards for the $setName set.'),
          );
        },
      ),
    );
  }
}
