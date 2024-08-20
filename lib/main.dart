import 'package:collectors_bank/preferences.dart';
import 'package:flutter/material.dart';
import 'package:collectors_bank/Pages/mtg/mtg_home.dart';

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
      backgroundColor: Preferences().appBackgroundColor,
      appBar: AppBar(
        title: const Text(
          'Collector\'s Bank',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Preferences().appAccentColor,
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
                builder: (_) => MTGHome(),
              ),
            );
          },
        ),
      ),
    );
  }
}
