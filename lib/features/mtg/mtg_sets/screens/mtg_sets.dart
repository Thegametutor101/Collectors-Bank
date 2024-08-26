import 'package:collectors_bank/features/mtg/mtg_sets/controllers/all_sets_controller.dart';
import 'package:collectors_bank/features/mtg/mtg_sets/screens/sections/sets_dot_navigation.dart';
import 'package:collectors_bank/features/mtg/mtg_sets/screens/sections/sets_info_icon.dart';
import 'package:collectors_bank/features/mtg/mtg_sets/screens/sections/sets_list.dart';
import 'package:collectors_bank/features/mtg/mtg_sets/screens/sections/sets_search_icon.dart';
import 'package:collectors_bank/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:collectors_bank/utils/local_storage/storage_mtg.dart';
import 'package:collectors_bank/bindings/profiles/mtg_profile.dart';
import 'package:collectors_bank/bindings/models/mtg/model_set.dart';
import 'package:collectors_bank/utils/http/http_server_mtg.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class MTGSets extends StatefulWidget {
  const MTGSets({super.key});
  // List<MtgProfile> mtgProfile = [];

  @override
  State<MTGSets> createState() => _MTGSetsState();
}

class _MTGSetsState extends State<MTGSets> {
  void updateMTGData(List<MtgProfile> mtgProfile) {
    setState(() {
      CollectorsBankStorageMtg().writeMTGData();
    });
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AllSetsController());
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
                  style:
                      TextStyle(color: CollectorsBankColors.textSecondaryColor),
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
          List<ModelMtgSet> setsPrimary = [];
          List<ModelMtgSet> setsSecondary = [];
          List<ModelMtgSet> setsMisc = [];
          List<ModelMtgSet> setData = snapshot.data;
          for (var set in setData) {
            if (set.set_type == 'core' ||
                set.set_type == 'expansion' ||
                set.set_type == 'masters' ||
                set.set_type == 'draft_innovation') {
              setsPrimary.add(set);
            } else if (set.set_type == 'from_the_vault' ||
                set.set_type == 'spellbook' ||
                set.set_type == 'duel_deck' ||
                set.set_type == 'commander') {
              setsSecondary.add(set);
            } else {
              setsMisc.add(set);
            }
          }
          return Stack(
            children: [
              //Info icon of lists
              const SetsInfoIcon(),

              //Dot Navigation SmoothPageIndicator
              const SetsDotNavigation(),

              //Search Bar
              const SetsSearchIcon(),

              //ListView for sets
              PageView(
                controller: controller.pageController,
                onPageChanged: controller.updatePageIndicator,
                children: [
                  SetsList(
                    sets: setsPrimary,
                  ),
                  SetsList(
                    sets: setsSecondary,
                  ),
                  SetsList(
                    sets: setsMisc,
                  ),
                ],
              ),
            ],
          );
        }
        return const Center(
          child: Text('Error fetching MTG Sets.'),
        );
      },
    );
  }
}
