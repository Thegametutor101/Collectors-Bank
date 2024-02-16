import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:collectors_bank/DB/constants.dart';
import 'package:collectors_bank/DB/models/mtg_card.dart';
import 'package:collectors_bank/mtgCardPage/mtg_card_page_display.dart';
import 'package:collectors_bank/mtgCardPage/mtg_card_page_variants.dart';

class MTGCardPage extends StatelessWidget {
  const MTGCardPage(
      {super.key,
      required this.cardCode,
      required this.cardName,
      required this.setCode});

  final String cardCode;
  final String cardName;
  final String setCode;

  Future<MTGCard> getCard(cardCode) async {
    String url =
        "https://collectorsvault.000webhostapp.com/collectors_bank/collectors_bank_mtg/entities/mtg_getCard.php?cardCode=$cardCode";
    var result =
        await http.get(Uri.parse(url), headers: {'Accept': 'application/json'});
    if (result.statusCode == 200) {
      final parser = JsonParserMTGCard(result.body);
      return parser.parseInBackground();
    } else {
      throw Exception('Failed to retreive Card Json.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 60, 60, 60),
      appBar: AppBar(
        title: Text('$setCode - $cardName'),
        backgroundColor: const Color.fromARGB(255, 250, 10, 10),
      ),
      body: FutureBuilder<MTGCard>(
        future: getCard(cardCode),
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
                  'Error fetching card $setCode - $cardName. ${snapshot.error.toString()}'),
            );
          }
          if (snapshot.connectionState == ConnectionState.done) {
            MTGCard card = snapshot.data;
            return PageView(
              children: [
                MTGCardPageDisplay(card: card),
                MTGCardPageVariants(card: card)
              ],
            );
          }
          return Center(
            child: Text('Error fetching the $setCode - $cardName card.'),
          );
        },
      ),
    );
  }
}
