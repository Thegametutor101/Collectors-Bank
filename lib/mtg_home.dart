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
  Future getSets() async {
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
      backgroundColor: const Color.fromARGB(255, 100, 100, 100),
      appBar: AppBar(
        title: const Text('Collector\'s Bank  -  MTG'),
        backgroundColor: const Color.fromARGB(255, 250, 10, 10),
      ),
      body: FutureBuilder(
        future: getSets(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          List<MTGSet> sets = snapshot.data;
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            return const Center(
              child: Text('Error fetching MTG Sets.'),
            );
          }
          return ListView.builder(
            itemCount: sets.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(sets[index].name),
                subtitle: Text(sets[index].code),
              );
            },
          );
        },
      ),
    );
  }
}
