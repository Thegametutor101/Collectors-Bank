import 'package:collectors_bank/features/fetch_loader.dart';
import 'package:collectors_bank/features/mtg/mtg_set/models/model_set.dart';
import 'package:collectors_bank/utils/constants/sizes.dart';
import 'package:collectors_bank/utils/constants/variables.dart';
import 'package:collectors_bank/utils/helpers/mtg_helper_functions.dart';
import 'package:collectors_bank/utils/helpers/router_helper.dart';
import 'package:collectors_bank/utils/http/http_server_mtg.dart';
import 'package:collectors_bank/features/mtg/mtg_cards/models/model_card.dart';
import 'package:collectors_bank/features/mtg/mtg_cards/screens/mtg_card.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class MtgSet extends StatefulWidget {
  const MtgSet({super.key, required this.set});

  final ModelMtgSet set;

  @override
  State<MtgSet> createState() => _MtgSet();
}

class _MtgSet extends State<MtgSet> {
  @override
  Widget build(BuildContext context) {
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
                        Navigator.pushNamed(
                          context,
                          RouterHelper.getMtgCard(),
                          arguments: MtgCard(
                              setIcon: widget.set.icon_svg_uri,
                              card: cards[index]),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: CollectorsBankSizes.sm),
                        child: CollectorsBankMtgHelperFunctions.checkIfMtgImage(
                          cards[index],
                          false,
                        ),
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
