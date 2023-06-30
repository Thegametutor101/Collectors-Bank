import 'dart:isolate';
import 'package:collectors_bank/DB/constants.dart';
import 'package:collectors_bank/DB/data/data_mtg.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:collectors_bank/DB/models/mtg_card.dart';

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
  List<MTGData> mtgData = List.empty(growable: true);

  void loadMtgData() async {
    mtgData = await Constants.readMTGData();
  }

  void updateMTGData(List<MTGData> mtgData) {
    this.mtgData = mtgData;
    setState(() {
      Constants.writeMTGData(mtgData);
    });
  }

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
      return const Image(
              image: AssetImage('lib/assets/No_Image_Found_Template.png'))
          .image;
    } else {
      return Image.memory(Uri.parse(image).data?.contentAsBytes() as Uint8List)
          .image;
    }
  }

  String getCardValue(
      String feild, String setCode, String cardCode, List<MTGData> mtgData) {
    String value = '0';
    for (var set in mtgData) {
      if (set.dataSet.setCode == setCode) {
        for (var card in set.dataSet.card) {
          if (card.cardCode == cardCode) {
            if (feild == "owned") value = card.owned;
            if (feild == "inUse") value = card.inUse;
          }
        }
      }
    }
    return value;
  }

  void changeCardValues(String method, String feild, String setCode,
      String cardCode, List<MTGData> mtgData) {
    List<MTGData> mtgDataGrowable = checkIfExists(setCode, cardCode, mtgData);
    for (var set in mtgDataGrowable) {
      if (set.dataSet.setCode == setCode) {
        for (var card in set.dataSet.card) {
          if (card.cardCode == cardCode) {
            int cardOwned = int.parse(card.owned);
            int cardInUse = int.parse(card.inUse);
            int setCollected = int.parse(set.dataSet.collected);
            if (method == "add") {
              if (feild == "owned") {
                if (cardOwned == 0) ++setCollected;
                card.owned = (++cardOwned).toString();
              } else if (feild == "inUse") {
                card.inUse = (++cardInUse).toString();
                if (cardOwned < cardInUse) {
                  card.inUse = (--cardInUse).toString();
                }
              }
              set.dataSet.collected = setCollected.toString();
            } else if (method == "remove") {
              if (feild == "owned") {
                card.owned = (--cardOwned).toString();
                if (cardOwned == 0) --setCollected;
                if (cardOwned < 0) {
                  card.owned = "0";
                }
                if (cardOwned > cardInUse) {
                  card.inUse = cardOwned.toString();
                }
              } else if (feild == "inUse") {
                card.inUse = (--cardInUse).toString();
                if (cardInUse < 0) {
                  card.inUse = "0";
                }
              }
              set.dataSet.collected = setCollected.toString();
            }
          }
        }
      }
    }
    updateMTGData(mtgDataGrowable);
  }

  List<MTGData> checkIfExists(
      String setCode, String cardCode, List<MTGData> mtgData) {
    bool setExists = false;
    bool cardExists = false;
    List<MTGData> mtgDataGrowable = mtgData.toList(growable: true);
    for (var set in mtgData) {
      if (set.dataSet.setCode == setCode) {
        setExists = true;
        for (var card in set.dataSet.card) {
          if (card.cardCode == cardCode) cardExists = true;
        }
      }
    }
    if (!setExists) {
      List<MTGDataCard> mtgDataCardEmpty = List.empty(growable: true);
      mtgDataGrowable.add(MTGData(
          dataSet: MTGDataSet(
              setCode: setCode, collected: "0", card: mtgDataCardEmpty)));
    }
    if (!cardExists) {
      for (var set in mtgDataGrowable) {
        if (set.dataSet.setCode == setCode) {
          set.dataSet.card
              .add(MTGDataCard(cardCode: cardCode, owned: "0", inUse: "0"));
        }
      }
    }
    return mtgDataGrowable;
  }

  @override
  Widget build(BuildContext context) {
    String cardCode = widget.cardCode;
    String cardName = widget.cardName;
    String setCode = widget.setCode;
    loadMtgData();
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
                Container(
                  margin: const EdgeInsets.only(top: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(top: 20),
                            child: const Text(
                              "Owned",
                              style: TextStyle(
                                fontSize: 26,
                                color: Color.fromARGB(255, 250, 250, 250),
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 20),
                            child: IconButton(
                              onPressed: () {
                                setState(() {
                                  changeCardValues("add", "owned", setCode,
                                      cardCode, mtgData);
                                });
                              },
                              icon: const Icon(
                                Icons.add,
                                color: Color.fromARGB(255, 250, 250, 250),
                                size: 26,
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 20),
                            child: Text(
                              getCardValue("owned", setCode, cardCode, mtgData),
                              style: const TextStyle(
                                fontSize: 46,
                                color: Color.fromARGB(255, 250, 250, 250),
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 20),
                            child: IconButton(
                              onPressed: () {
                                setState(() {
                                  changeCardValues("remove", "owned", setCode,
                                      cardCode, mtgData);
                                });
                              },
                              icon: const Icon(
                                Icons.remove,
                                color: Color.fromARGB(255, 250, 250, 250),
                                size: 26,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(top: 20),
                            child: const Text(
                              "In Use",
                              style: TextStyle(
                                fontSize: 26,
                                color: Color.fromARGB(255, 250, 250, 250),
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 20),
                            child: IconButton(
                              onPressed: () {
                                setState(() {
                                  changeCardValues("add", "inUse", setCode,
                                      cardCode, mtgData);
                                });
                              },
                              icon: const Icon(
                                Icons.add,
                                color: Color.fromARGB(255, 250, 250, 250),
                                size: 26,
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 20),
                            child: Text(
                              getCardValue("inUse", setCode, cardCode, mtgData),
                              style: const TextStyle(
                                fontSize: 46,
                                color: Color.fromARGB(255, 250, 250, 250),
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 20),
                            child: IconButton(
                              onPressed: () {
                                setState(() {
                                  changeCardValues("remove", "inUse", setCode,
                                      cardCode, mtgData);
                                });
                              },
                              icon: const Icon(
                                Icons.remove,
                                color: Color.fromARGB(255, 250, 250, 250),
                                size: 26,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
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
