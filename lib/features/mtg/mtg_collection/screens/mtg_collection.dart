import 'package:collectors_bank/common/profiles/mtg_profile.dart';
import 'package:collectors_bank/features/fetch_loaders.dart';
import 'package:collectors_bank/utils/constants/sizes.dart';
import 'package:collectors_bank/utils/constants/variables.dart';
import 'package:collectors_bank/utils/http/http_server_mtg.dart';
import 'package:collectors_bank/features/mtg/mtg_cards/models/model_card.dart';
import 'package:collectors_bank/features/mtg/mtg_cards/screens/mtg_card.dart';
import 'package:collectors_bank/utils/local_storage/storage_mtg.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class MtgCollection extends StatefulWidget {
  const MtgCollection({super.key});

  @override
  State<MtgCollection> createState() => _MtgCollection();
}

class _MtgCollection extends State<MtgCollection> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<MtgProfile>>(
      future: CollectorsBankStorageMtg.instance.readMTGData(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.data == null ||
            snapshot.connectionState == ConnectionState.waiting) {
          return const FetchLoader();
        }
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.hasError) {
          return Center(
            child: Text(
                'Error fetching your Collection. ${snapshot.error.toString()}'),
          );
        }
        if (snapshot.connectionState == ConnectionState.done) {
          List<MtgProfile> profile = snapshot.data;
          List<MtgProfileCard> profileCards = [];
          for (var set in profile) {
            for (var card in set.profileSet.cards) {
              profileCards.add(card);
            }
          }
          return Padding(
            padding: const EdgeInsets.all(CollectorsBankSizes.md),
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: CollectorsBankVariables.numerOfCardsPerRow,
                mainAxisSpacing: CollectorsBankSizes.gridViewSpacing,
                crossAxisSpacing: CollectorsBankSizes.gridViewSpacing,
                childAspectRatio: (5 / 7),
              ),
              itemCount: profileCards.length,
              itemBuilder: (context, index) {
                return SizedBox(
                  height: 100,
                  width: 80,
                  child: InkWell(
                    onTap: () async {
                      ModelMtgCard card =
                          await CollectorsBankHttpServer.getMtgCardsByUri(
                              profileCards[index].uri);
                      Navigator.push(
                        // ignore: use_build_context_synchronously
                        context,
                        MaterialPageRoute(
                          builder: (_) => MtgCard(card: card),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: CollectorsBankSizes.sm),
                      child: Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: Image.network(profileCards[index].imageUri)
                                .image,
                            fit: BoxFit.scaleDown,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        }
        return const Center(
          child: Text('Error fetching your collection'),
        );
      },
    );
  }
}
