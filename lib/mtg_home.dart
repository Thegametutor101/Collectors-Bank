import 'package:collectors_bank/DB/constants.dart';
import 'package:collectors_bank/DB/data/data_mtg.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:isolate';
import 'package:collectors_bank/DB/models/mtg_set.dart';
import 'package:collectors_bank/mtg_set_page.dart';

class MTGHomePage extends StatefulWidget {
  const MTGHomePage({super.key});

  @override
  State<MTGHomePage> createState() => _MTGHomePageState();
}

class _MTGHomePageState extends State<MTGHomePage> {
  late List<MTGData> mtgData;

  void loadMtgData() async {
    mtgData = await Constants.readMTGData();
  }

  void updateMTGData(List<MTGData> mtgData) {
    setState(() {
      this.mtgData = mtgData;
    });
  }

  Future<List<MTGSet>> getSets() async {
    String url =
        "https://collectorsvault.000webhostapp.com/collectors_bank/collectors_bank_mtg/entities/mtg_getSets.php";
    var result =
        await http.get(Uri.parse(url), headers: {'Accept': 'application/json'});
    if (result.statusCode == 200) {
      final parser = JsonParserMTGSets(result.body);
      return parser.parseInBackground();
    } else {
      throw Exception('Failed to retreive Cards Json.');
    }
  }

  String getSetCollected(String setCode, List<MTGData> mtgData) {
    String collected = '0';
    for (var set in mtgData) {
      if (set.dataSet.setCode == setCode) collected = set.dataSet.collected;
    }
    return collected;
  }

  @override
  Widget build(BuildContext context) {
    loadMtgData();
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 60, 60, 60),
      appBar: AppBar(
        title: const Text('Collector\'s Bank  -  MTG'),
        backgroundColor: const Color.fromARGB(255, 250, 10, 10),
      ),
      body: FutureBuilder<List<MTGSet>>(
        future: getSets(),
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
              child:
                  Text('Error fetching MTG Sets. ${snapshot.error.toString()}'),
            );
          }
          if (snapshot.connectionState == ConnectionState.done) {
            List<MTGSet> sets = snapshot.data;
            return ListView.builder(
              itemCount: sets.length,
              itemBuilder: (context, index) {
                return ListTile(
                  textColor: const Color.fromARGB(255, 250, 250, 250),
                  title: Text(sets[index].name),
                  subtitle: Flex(
                    direction: Axis.horizontal,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(sets[index].code),
                      Text(
                          "${getSetCollected(sets[index].code, mtgData)}/${sets[index].cardCount}"),
                    ],
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => MTGSetPage(
                            setCode: sets[index].code,
                            setName: sets[index].name),
                      ),
                    );
                  },
                );
              },
            );
          }
          return const Center(
            child: Text('Error fetching MTG Sets.'),
          );
        },
      ),
    );
  }
}

class JsonParserMTGSets {
  JsonParserMTGSets(this.encodedJson);
  final String encodedJson;

  Future<List<MTGSet>> parseInBackground() async {
    final p = ReceivePort();
    await Isolate.spawn(_decodeAndParseJson, p.sendPort);
    return await p.first;
  }

  Future<void> _decodeAndParseJson(SendPort port) async {
    final jsonData = jsonDecode(encodedJson);
    final resultJson = jsonData as List<dynamic>;
    final result = resultJson.map((json) => MTGSet.fromJson(json)).toList();
    Isolate.exit(port, result);
  }
}
