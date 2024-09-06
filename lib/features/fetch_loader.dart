import 'package:flutter/material.dart';

class FetchLoader extends StatelessWidget {
  const FetchLoader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
          const Center(child: Text('Please wait for data to load.')),
        ],
      ),
    );
  }
}
