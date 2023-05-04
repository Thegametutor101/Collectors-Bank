import 'dart:isolate';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import './models/mtg_card.dart';

class MTGCardPage extends StatefulWidget {
  const MTGCardPage(
      {super.key,
      required this.cardCode,
      required this.cardName,
      required this.setCode});

  final String cardCode;
  final String cardName;
  final String setCode;

  @override
  State<MTGCardPage> createState() => _MTGCardPage();
}

class _MTGCardPage extends State<MTGCardPage> {
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

  ImageProvider checkIfImage(String image) {
    if (image == '') {
      return const Image(image: AssetImage('lib/assets/mtg_default.png')).image;
    } else {
      return Image.memory(Uri.parse(image).data?.contentAsBytes() as Uint8List)
          .image;
    }
  }

  @override
  Widget build(BuildContext context) {
    String cardCode = widget.cardCode;
    String cardName = widget.cardName;
    String setCode = widget.setCode;
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
            return Flex(
              direction: Axis.vertical,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(top: 20),
                  child: Text(
                    card.name,
                    style: const TextStyle(
                      color: Color.fromARGB(255, 250, 250, 250),
                    ),
                  ),
                ),
                Card(
                  margin: const EdgeInsets.only(top: 20),
                  color: const Color.fromARGB(0, 0, 0, 0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Image(
                    image: checkIfImage(card.image),
                  ),
                ),
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

class JsonParserMTGCard {
  JsonParserMTGCard(this.encodedJson);
  final String encodedJson;

  Future<MTGCard> parseInBackground() async {
    final p = ReceivePort();
    await Isolate.spawn(_decodeAndParseJson, p.sendPort);
    return await p.first;
  }

  Future<void> _decodeAndParseJson(SendPort port) async {
    final jsonData = jsonDecode(encodedJson);
    final resultJson = jsonData as List<dynamic>;
    final result = resultJson.map((json) => MTGCard.fromJson(json));
    Isolate.exit(port, result.first);
  }
}
