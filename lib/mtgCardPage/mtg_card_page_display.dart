import 'dart:ffi';
import 'dart:isolate';
import 'package:collectors_bank/DB/constants.dart';
import 'package:collectors_bank/DB/data/data_mtg.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:collectors_bank/DB/models/mtg_card.dart';

class MTGCardPageDisplay extends StatefulWidget {
  const MTGCardPageDisplay({super.key, required this.card});

  final MTGCard card;

  @override
  State<MTGCardPageDisplay> createState() => _MTGCardPageDisplay();
}

class _MTGCardPageDisplay extends State<MTGCardPageDisplay> {
  List<MTGData> mtgData = List.empty(growable: true);

  Future<bool> loadMtgData() async {
    mtgData = await Constants.readMTGData();
    return true;
  }

  void updateMTGData(List<MTGData> mtgData) {
    this.mtgData = mtgData;
    setState(() {
      Constants.writeMTGData(mtgData);
    });
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
      return Image.memory(
          Uri.parse(card.image).data?.contentAsBytes() as Uint8List);
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
                if (cardOwned < 0) card.owned = "0";
                if (cardOwned < cardInUse) {
                  card.inUse = cardOwned.toString();
                }
              } else if (feild == "inUse") {
                card.inUse = (--cardInUse).toString();
                if (cardInUse < 0) card.inUse = "0";
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
    MTGCard card = widget.card;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 60, 60, 60),
      body: FutureBuilder(
        future: loadMtgData(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
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
                  child: checkIfImage(card),
                ),
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(15),
                  child: Flex(
                    direction: Axis.horizontal,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Flex(
                            direction: Axis.horizontal,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                getCardValue(
                                    "owned", card.set, card.id, mtgData),
                                style: const TextStyle(
                                  fontSize: 46,
                                  color: Color.fromARGB(255, 250, 250, 250),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.only(left: 5),
                                child: Flex(
                                  direction: Axis.vertical,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        setState(() {
                                          changeCardValues("add", "owned",
                                              card.set, card.id, mtgData);
                                        });
                                      },
                                      icon: const Icon(
                                        Icons.add,
                                        color:
                                            Color.fromARGB(255, 250, 250, 250),
                                        size: 26,
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        setState(() {
                                          changeCardValues("remove", "owned",
                                              card.set, card.id, mtgData);
                                        });
                                      },
                                      icon: const Icon(
                                        Icons.remove,
                                        color:
                                            Color.fromARGB(255, 250, 250, 250),
                                        size: 26,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const Text(
                            "Owned",
                            style: TextStyle(
                              fontSize: 26,
                              color: Color.fromARGB(255, 250, 250, 250),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Flex(
                            direction: Axis.horizontal,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                getCardValue(
                                    "inUse", card.set, card.id, mtgData),
                                style: const TextStyle(
                                  fontSize: 46,
                                  color: Color.fromARGB(255, 250, 250, 250),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.only(left: 5),
                                child: Flex(
                                  direction: Axis.vertical,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        setState(() {
                                          changeCardValues("add", "inUse",
                                              card.set, card.id, mtgData);
                                        });
                                      },
                                      icon: const Icon(
                                        Icons.add,
                                        color:
                                            Color.fromARGB(255, 250, 250, 250),
                                        size: 26,
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        setState(() {
                                          changeCardValues("remove", "inUse",
                                              card.set, card.id, mtgData);
                                        });
                                      },
                                      icon: const Icon(
                                        Icons.remove,
                                        color:
                                            Color.fromARGB(255, 250, 250, 250),
                                        size: 26,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const Text(
                            "In Use",
                            style: TextStyle(
                              fontSize: 26,
                              color: Color.fromARGB(255, 250, 250, 250),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            );
          }
          return Center(
            child: Text('Error fetching the ${card.name} card.'),
          );
        },
      ),
    );
  }
}
