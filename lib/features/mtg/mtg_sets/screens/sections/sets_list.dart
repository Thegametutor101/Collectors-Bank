import 'package:collectors_bank/bindings/models/mtg/model_set.dart';
import 'package:collectors_bank/features/mtg/mtg_sets/screens/mtg_set.dart';
import 'package:collectors_bank/utils/constants/colors.dart';
import 'package:collectors_bank/utils/local_storage/storage_mtg.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SetsList extends StatelessWidget {
  const SetsList({super.key, required this.sets});

  final List<ModelMtgSet> sets;

  String getSetCollected(String setCode) {
    String collected = '0';
    for (var set in CollectorsBankStorageMtg.instance.storage) {
      if (set.profileSet.setCode == setCode) {
        collected = set.profileSet.collected;
      }
    }
    return collected;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 65),
      child: Container(
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(
                color: CollectorsBankColors.scaffoldAccentColor,
                style: BorderStyle.solid,
                width: 2),
          ),
          borderRadius: BorderRadius.only(
              topLeft: Radius.elliptical(10, 7),
              topRight: Radius.elliptical(10, 7)),
        ),
        child: ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: sets.length,
          itemBuilder: (context, index) {
            return ListTile(
              textColor: CollectorsBankColors.textColor,
              title: Text(sets[index].name),
              subtitle: Flex(
                direction: Axis.horizontal,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    sets[index].code.toUpperCase(),
                    style: const TextStyle().copyWith(
                        color: CollectorsBankColors.textSecondaryColor),
                  ),
                  Text(
                      "${getSetCollected(sets[index].code)}/${sets[index].card_count}"),
                ],
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => MTGSetPage(
                        setUri: sets[index].search_uri,
                        setCode: sets[index].code,
                        setName: sets[index].name),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
