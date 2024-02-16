import 'package:collectors_bank/DB/constants.dart';
import 'package:collectors_bank/DB/data/data_mtg.dart';
import 'package:collectors_bank/DB/models/mtg_card.dart';
import 'package:collectors_bank/mtgCardPage/mtg_card_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:isolate';

class MTGSetPage extends StatefulWidget {
  const MTGSetPage({super.key, required this.setCode, required this.setName});

  final String setCode;
  final String setName;

  @override
  State<MTGSetPage> createState() => _MTGSetPage();
}

class _MTGSetPage extends State<MTGSetPage> {
  List<MTGData> mtgData = [];

  void loadMtgData() async {
    mtgData = await Constants.readMTGData();
  }

  void updateMTGData(List<MTGData> mtgData) {
    setState(() {
      this.mtgData = mtgData;
    });
  }

  Future<List<MTGCard>> getCards(setCode) async {
    String url =
        "https://collectorsvault.000webhostapp.com/collectors_bank/collectors_bank_mtg/entities/mtg_getCards.php?setCode=$setCode";
    var result =
        await http.get(Uri.parse(url), headers: {'Accept': 'application/json'});
    if (result.statusCode == 200) {
      final parser = JsonParserMTGCardToList(result.body);
      return parser.parseInBackground();
    } else {
      throw Exception('Failed to retreive Cards Json.');
    }
  }

  Widget checkIfImage(MTGCard card) {
    if (card.image == '') {
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
                  card.number),
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
            image: Image.memory(
                    Uri.parse(card.image).data?.contentAsBytes() as Uint8List)
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
    loadMtgData();
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 60, 60, 60),
      appBar: AppBar(
        title: Text(setName),
        backgroundColor: const Color.fromARGB(255, 250, 10, 10),
      ),
      body: FutureBuilder<List<MTGCard>>(
        future: getCards(setCode),
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
            List<MTGCard> cards = snapshot.data;
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

class JsonParserMTGCard {
  JsonParserMTGCard(this.encodedJson);
  final String encodedJson;

  Future<List<MTGCard>> parseInBackground() async {
    final p = ReceivePort();
    await Isolate.spawn(_decodeAndParseJson, p.sendPort);
    return await p.first;
  }

  Future<void> _decodeAndParseJson(SendPort port) async {
    final jsonData = jsonDecode(encodedJson);
    final resultJson = jsonData as List<dynamic>;
    final result = resultJson.map((json) => MTGCard.fromJson(json)).toList();
    Isolate.exit(port, result);
  }
}
