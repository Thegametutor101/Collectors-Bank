import 'package:collectors_bank/features/mtg/mtg_cards/models/model_card.dart';
import 'package:collectors_bank/features/mtg/mtg_cards/screens/mtg_card.dart';
import 'package:flutter/material.dart';

class MtgCardVersions extends StatefulWidget {
  const MtgCardVersions({super.key, required this.cards});

  final List<ModelMtgCard> cards;

  @override
  State<MtgCardVersions> createState() => _MtgCardVersions();
}

class _MtgCardVersions extends State<MtgCardVersions> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.cards.length,
      itemBuilder: (context, index) {
        return ListTile(
          textColor: const Color.fromARGB(255, 250, 250, 250),
          title: Text(widget.cards[index].set_name),
          subtitle: Flex(
            direction: Axis.horizontal,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(widget.cards[index].set),
              Text("card number: ${widget.cards[index].collector_number}"),
            ],
          ),
          onTap: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => MtgCard(
                  card: widget.cards[index],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
