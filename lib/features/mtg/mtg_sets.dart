import 'package:collectors_bank/utils/constants/constants.dart';
import 'package:collectors_bank/DB/profiles/mtg_profile.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:collectors_bank/DB/models/mtg/mtg_set.dart';
import 'package:collectors_bank/features/mtg/mtg_set.dart';

// ignore: must_be_immutable
class MTGSets extends StatefulWidget {
  MTGSets({super.key, required List<MTGData> mtgData});
  List<MTGData> mtgData = [];

  @override
  State<MTGSets> createState() => _MTGSetsState();
}

class _MTGSetsState extends State<MTGSets> {
  void loadMtgData() async {
    widget.mtgData = await Constants.readMTGData();
  }

  void updateMTGData(List<MTGData> mtgData) {
    setState(() {
      widget.mtgData = mtgData;
    });
  }

  Future<List<MTGSet>> getSets() async {
    String url =
        "http://192.168.50.126/Collectors-Bank/php/collectors_bank_mtg/entities/mtg_getSets.php";
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
    return FutureBuilder<List<MTGSet>>(
      future: getSets(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.data == null ||
            snapshot.connectionState == ConnectionState.waiting) {
          return Container(
            margin: const EdgeInsets.only(top: 100),
            child: ListView(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
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
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
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
                        "${getSetCollected(sets[index].code, widget.mtgData)}/${sets[index].cardCount}"),
                  ],
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => MTGSetPage(
                          setCode: sets[index].code, setName: sets[index].name),
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
    );
  }
}
