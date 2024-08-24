import 'package:collectors_bank/utils/http/http_server_mtg.dart';
import 'package:collectors_bank/bindings/profiles/mtg_profile.dart';
import 'package:collectors_bank/bindings/models/mtg/model_card.dart';
import 'package:collectors_bank/features/mtg/mtg_cards/mtg_card.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class MTGSetPage extends StatefulWidget {
  MTGSetPage(
      {super.key,
      required this.mtgProfile,
      required this.setCode,
      required this.setName});

  List<MtgProfile> mtgProfile = [];
  final String setCode;
  final String setName;

  @override
  State<MTGSetPage> createState() => _MTGSetPage();
}

class _MTGSetPage extends State<MTGSetPage> {
  List<MtgProfile> mtgData = [];

  void updateMTGData(List<MtgProfile> mtgData) {
    setState(() {
      this.mtgData = mtgData;
    });
  }

  Widget checkIfImage(ModelMtgCard card) {
    if (card.image_uris.normal == '') {
      return Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Flex(
          direction: Axis.vertical,
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
        ),
      );
    } else {
      return Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: Image.memory(Uri.parse(card.image_uris.normal)
                    .data
                    ?.contentAsBytes() as Uint8List)
                .image,
            fit: BoxFit.fitHeight,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    String setCode = widget.setCode;
    String setName = widget.setName;
    //loadMtgData();
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 60, 60, 60),
      appBar: AppBar(
        title: Text(setName),
        backgroundColor: const Color.fromARGB(255, 250, 10, 10),
      ),
      body: FutureBuilder<List<ModelMtgCard>>(
        future: CollectorsBankHttpServer.getMtgCards(
            setCode, "order=set&include_extras=true&q=s%3A$setCode"),
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
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
              ),
              itemCount: cards.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: EdgeInsets.zero,
                  color: const Color.fromARGB(0, 0, 0, 0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
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
                );
              },
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
