import 'package:collectors_bank/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:collectors_bank/utils/local_storage/storage_mtg.dart';
import 'package:collectors_bank/bindings/profiles/mtg_profile.dart';
import 'package:collectors_bank/bindings/models/mtg/model_set.dart';
import 'package:collectors_bank/features/mtg/mtg_set.dart';
import 'package:collectors_bank/utils/http/http_server_mtg.dart';

// ignore: must_be_immutable
class MTGSets extends StatefulWidget {
  MTGSets({super.key, required List<MtgProfile> mtgProfile});
  List<MtgProfile> mtgProfile = [];

  @override
  State<MTGSets> createState() => _MTGSetsState();
}

class _MTGSetsState extends State<MTGSets> {
  void updateMTGData(List<MtgProfile> mtgProfile) {
    setState(() {
      CollectorsBankStorageMtg().writeMTGData();
    });
  }

  String getSetCollected(String setCode, List<MtgProfile> mtgProfile) {
    String collected = '0';
    for (var set in mtgProfile) {
      if (set.profileSet.setCode == setCode) {
        collected = set.profileSet.collected;
      }
    }
    return collected;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ModelMtgSet>>(
      future: CollectorsBankHttpServer.getMtgSets(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.data == null ||
            snapshot.connectionState == ConnectionState.waiting) {
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
          List<ModelMtgSet> sets = [];
          List<ModelMtgSet> setData = snapshot.data;
          for (var set in setData) {
            if (set.set_type == 'core' ||
                set.set_type == 'expansion' ||
                set.set_type == 'masters' ||
                set.set_type == 'draft_innovation') {
              sets.add(set);
            }
          }
          return ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: sets.length,
            itemBuilder: (context, index) {
              return ListTile(
                textColor: const Color.fromARGB(255, 250, 250, 250),
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
                        "${getSetCollected(sets[index].code, widget.mtgProfile)}/${sets[index].card_count}"),
                  ],
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => MTGSetPage(
                          mtgProfile: widget.mtgProfile,
                          setCode: sets[index].code,
                          setName: sets[index].name),
                    ),
                  );
                },
              );
            },
          );
        }
        return const Center(
          child: Text('Error fetching MTG Sets.'),
        );
      },
    );
  }
}
