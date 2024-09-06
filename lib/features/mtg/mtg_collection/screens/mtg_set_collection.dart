import 'package:collectors_bank/common/profiles/mtg_profile.dart';
import 'package:collectors_bank/features/mtg/mtg_cards/models/model_card.dart';
import 'package:collectors_bank/features/mtg/mtg_cards/screens/mtg_card.dart';
import 'package:collectors_bank/utils/constants/sizes.dart';
import 'package:collectors_bank/utils/constants/variables.dart';
import 'package:collectors_bank/utils/http/http_server_mtg.dart';
import 'package:flutter/material.dart';

class MtgSetCollection extends StatefulWidget {
  const MtgSetCollection(
      {super.key, required this.profileSet, required this.cards});

  final MtgProfileSet profileSet;
  final List<MtgProfileCard> cards;

  @override
  State<MtgSetCollection> createState() => _MtgSetCollection();
}

class _MtgSetCollection extends State<MtgSetCollection> {
  @override
  Widget build(BuildContext context) {
    for (var card in widget.cards) {
      card.collectorNumber = card.collectorNumber.padLeft(7, "0");
    }
    widget.cards.sort((a, b) => a.collectorNumber.compareTo(b.collectorNumber));
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.profileSet.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(CollectorsBankSizes.md),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: CollectorsBankVariables.numerOfCardsPerRow,
            mainAxisSpacing: CollectorsBankSizes.gridViewSpacing,
            crossAxisSpacing: CollectorsBankSizes.gridViewSpacing,
            childAspectRatio: (5 / 7),
          ),
          itemCount: widget.cards.length,
          itemBuilder: (context, index) {
            return SizedBox(
              height: 100,
              width: 80,
              child: InkWell(
                onTap: () async {
                  ModelMtgCard card =
                      await CollectorsBankHttpServer.getMtgCardsByUri(
                          widget.cards[index].uri);
                  Navigator.push(
                    // ignore: use_build_context_synchronously
                    context,
                    MaterialPageRoute(
                      builder: (_) => MtgCard(
                        setIcon: widget.profileSet.setIcon,
                        card: card,
                      ),
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: CollectorsBankSizes.sm),
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image:
                            Image.network(widget.cards[index].imageUri).image,
                        fit: BoxFit.scaleDown,
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
