import 'package:collectors_bank/db/mtg_database.dart';
import 'package:collectors_bank/models/mtg_set.dart';
import 'package:flutter/material.dart';

class MTGHomePage extends StatefulWidget {
  const MTGHomePage({super.key});

  @override
  State<MTGHomePage> createState() => _MTGHomePageState();
}

class _MTGHomePageState extends State<MTGHomePage> {
  late List<MTGSet> sets;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    refreshSets();
  }

  @override
  void dispose() {
    MTGDatabase.instance.close();

    super.dispose();
  }

  Future refreshSets() async {
    setState(() => isLoading = true);

    this.sets = await MTGDatabase.instance.selectAllSets();

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 100, 100, 100),
      appBar: AppBar(
        title: const Text('Collector\'s Bank  -  MTG'),
        backgroundColor: const Color.fromARGB(255, 250, 10, 10),
      ),
      body: Expanded(
        child: ListView.builder(
          itemCount: sets.length,
          itemBuilder: (BuildContext context, index) {
            return Container(
              height: 20,
              margin: const EdgeInsets.all(5),
              child: Center(
                child: Text(sets[index].name),
              ),
            );
          },
        ),
      ),
    );
  }
}
