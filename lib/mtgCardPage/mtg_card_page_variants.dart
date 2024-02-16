import 'package:collectors_bank/DB/models/mtg_card.dart';
import 'package:collectors_bank/DB/models/view_mtg_card_variants.dart';
import 'package:collectors_bank/mtgCardPage/mtg_card_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:collectors_bank/DB/constants.dart';

class MTGCardPageVariants extends StatefulWidget {
  const MTGCardPageVariants({super.key, required this.card});

  final MTGCard card;

  @override
  State<MTGCardPageVariants> createState() => _MTGCardPageVariants();
}

class _MTGCardPageVariants extends State<MTGCardPageVariants> {
  Future<List<ViewMTGCardVariants>> getVariants(MTGCard card) async {
    String url =
        "https://collectorsvault.000webhostapp.com/collectors_bank/collectors_bank_mtg/entities/mtg_getVariants.php?cardName=${card.name}";
    var result =
        await http.get(Uri.parse(url), headers: {'Accept': 'application/json'});
    if (result.statusCode == 200) {
      final parser = JsonParserViewMTGCardVariantsToList(result.body);
      return parser.parseInBackground();
    } else {
      throw Exception('Failed to retreive Cards Json.');
    }
  }

  @override
  Widget build(BuildContext context) {
    final MTGCard currentCard = widget.card;
    return FutureBuilder<List<ViewMTGCardVariants>>(
      future: getVariants(currentCard),
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
                "Error fetching {${currentCard.name}}'s variants. ${snapshot.error.toString()}"),
          );
        }
        if (snapshot.connectionState == ConnectionState.done) {
          List<ViewMTGCardVariants> cards = snapshot.data;
          return ListView.builder(
              itemCount: cards.length,
              itemBuilder: (context, index) {
                return ListTile(
                  textColor: const Color.fromARGB(255, 250, 250, 250),
                  title: Text(cards[index].setName),
                  subtitle: Flex(
                    direction: Axis.horizontal,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(cards[index].setCode),
                      Text("card number: ${cards[index].cardNumber}"),
                    ],
                  ),
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) => MTGCardPage(
                          cardCode: cards[index].cardID,
                          cardName: cards[index].cardName,
                          setCode: cards[index].setCode,
                        ),
                      ),
                    );
                  },
                );
              });
        }
        return Center(
          child: Text("Error fetching {${currentCard.name}}'s variants."),
        );
      },
    );
  }
}
