import 'package:collectors_bank/utils/constants/colors.dart';
import 'package:collectors_bank/utils/constants/sizes.dart';
import 'package:collectors_bank/utils/constants/variables.dart';
import 'package:collectors_bank/utils/http/http_server_mtg.dart';
import 'package:collectors_bank/bindings/models/mtg/model_card.dart';
import 'package:collectors_bank/features/mtg/mtg_cards/mtg_card.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class MTGSetPage extends StatefulWidget {
  const MTGSetPage(
      {super.key,
      required this.setUri,
      required this.setCode,
      required this.setName});

  final String setUri;
  final String setCode;
  final String setName;

  @override
  State<MTGSetPage> createState() => _MTGSetPage();
}

class _MTGSetPage extends State<MTGSetPage> {
  Widget checkIfImage(ModelMtgCard card) {
    String image = card.image_uris.normal;
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
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: CollectorsBankSizes.sm),
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: Image.network(image).image,
              fit: BoxFit.scaleDown,
            ),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    String setCode = widget.setCode;
    String setName = widget.setName;
    return Scaffold(
      backgroundColor: CollectorsBankColors.scaffoldColor,
      appBar: AppBar(
        title: Text(setName),
        backgroundColor: CollectorsBankColors.primaryColor,
      ),
      body: FutureBuilder<List<ModelMtgCard>>(
        future: CollectorsBankHttpServer.getMtgCards(setCode, widget.setUri),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.data == null ||
              snapshot.connectionState == ConnectionState.waiting) {
            return Container(
              margin: const EdgeInsets.only(top: 100),
              child: ListView(
                children: [
                  Center(
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      child: const SizedBox(
                        width: 60,
                        height: 60,
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  ),
                  const DefaultTextStyle(
                    style: TextStyle(color: Color.fromARGB(255, 200, 200, 200)),
                    child: Center(
                      child: Text('Please wait for data to load.'),
                    ),
                  ),
                ],
              ),
            );
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
              padding: const EdgeInsets.all(CollectorsBankSizes.defaultSpace),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: CollectorsBankVariables.numerOfCardsPerRow,
                  mainAxisSpacing: CollectorsBankSizes.gridViewSpacing,
                  crossAxisSpacing: CollectorsBankSizes.gridViewSpacing,
                ),
                itemCount: cards.length,
                itemBuilder: (context, index) {
                  return SizedBox(
                    height: CollectorsBankSizes.imageCardSize,
                    child: Card(
                      elevation: 0,
                      margin: EdgeInsets.zero,
                      color: CollectorsBankColors.scaffoldAccentColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            CollectorsBankSizes.cardRadiusMd),
                      ),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => MTGCardPage(
                                  cardCode: cards[index].id,
                                  cardName: cards[index].name,
                                  setCode: setCode),
                            ),
                          );
                        },
                        child: checkIfImage(cards[index]),
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
