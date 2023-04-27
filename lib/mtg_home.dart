import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import './models/mtg_set.dart';

class MTGHomePage extends StatefulWidget {
  const MTGHomePage({super.key});

  @override
  State<MTGHomePage> createState() => _MTGHomePageState();
}

class _MTGHomePageState extends State<MTGHomePage> {
  Future<List<MTGSet>> getSets() async {
    String url =
        "https://collectorsvault.000webhostapp.com/collectors_bank/collectors_bank_mtg/entities/mtg_sets_entity.php";
    var result =
        await http.get(Uri.parse(url), headers: {'Accept': 'application/json'});
    List<MTGSet> list = [];
    for (var item in json.decode(result.body)) {
      list.add(MTGSet.fromJson(item));
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
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
                  subtitle: Text(sets[index].code),
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
