import 'package:flutter/material.dart';
import './mtg_home.dart';

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
      backgroundColor: const Color.fromARGB(255, 100, 100, 100),
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
        child: ElevatedButton(
          child: const Text(
            'MTG',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 30,
            ),
          ),
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
