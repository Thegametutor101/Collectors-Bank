import 'package:flutter/material.dart';

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
        title: const Text('Collector\'s Bank'),
        backgroundColor: const Color.fromARGB(255, 250, 10, 10),
      ),
      body: ElevatedButton(
        child: const Text('MTG'),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const MTGHomePage(),
            ),
          );
        },
      ),
    );
  }
}

class MTGHomePage extends StatelessWidget {
  const MTGHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Collector\'s Bank  -  MTG'),
        backgroundColor: const Color.fromARGB(255, 250, 10, 10),
      ),
    );
  }
}
