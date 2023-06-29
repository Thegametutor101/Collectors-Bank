import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:collectors_bank/mtg_home.dart';
import 'package:collectors_bank/DB/constants.dart';
import 'package:collectors_bank/DB/data/data_mtg.dart';

void main(List<String> args) {
  runApp(const CollectorsBank());
}

class CollectorsBank extends StatelessWidget {
  const CollectorsBank({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Collector\'s Bank',
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 60, 60, 60),
      appBar: AppBar(
        title: const Text(
          'Collector\'s Bank',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color.fromARGB(255, 250, 10, 10),
      ),
      body: Container(
        width: double.infinity,
        alignment: Alignment.topCenter,
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
        child: IconButton(
          icon: const Image(image: AssetImage('lib/assets/mtg_default.png')),
          iconSize: 250,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const MTGHomePage(),
              ),
            );
          },
        ),
      ),
    );
  }
}
