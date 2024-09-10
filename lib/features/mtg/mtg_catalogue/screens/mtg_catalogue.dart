import 'package:collectors_bank/common/profiles/mtg_profile.dart';
import 'package:collectors_bank/features/fetch_loader.dart';
import 'package:collectors_bank/features/mtg/mtg_set/controllers/all_sets_controller.dart';
import 'package:collectors_bank/features/mtg/mtg_catalogue/screens/sections/sets_dot_navigation.dart';
import 'package:collectors_bank/features/mtg/mtg_catalogue/screens/sections/sets_info_icon.dart';
import 'package:collectors_bank/features/mtg/mtg_catalogue/screens/sections/catalogue_list.dart';
import 'package:collectors_bank/features/mtg/mtg_catalogue/screens/sections/sets_search_icon.dart';
import 'package:collectors_bank/utils/local_storage/storage_mtg.dart';
import 'package:flutter/material.dart';
import 'package:collectors_bank/features/mtg/mtg_set/models/model_set.dart';
import 'package:collectors_bank/utils/http/http_mtg.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class MtgCatalogue extends StatefulWidget {
  const MtgCatalogue({super.key});

  @override
  State<MtgCatalogue> createState() => _MtgCatalogueState();
}

class _MtgCatalogueState extends State<MtgCatalogue> {
  List<MtgProfile> mtgProfile = [];
  @override
  void initState() {
    super.initState();
    loadProfile();
  }

  Future loadProfile() async {
    var data = await CollectorsBankStorageMtg.instance.readMTGData();
    setState(() {
      mtgProfile = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AllSetsController());
    return Scaffold(
      appBar: AppBar(
        // leading: IconButton(
        //   onPressed: () {
        //     ///TODO
        //   },
        //   icon: Icon(
        //     Iconsax.arrow_left,
        //     color: dark
        //         ? CollectorsBankColors.darkTextSecondaryColor
        //         : CollectorsBankColors.lightTextSecondaryColor,
        //   ),
        // ),
        title: const Text(
          "Magic: The Gathering",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: FutureBuilder<List<ModelMtgSet>>(
        future: CollectorsBankHttpMtg.getMtgSets(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.data == null ||
              snapshot.connectionState == ConnectionState.waiting) {
            return const FetchLoader();
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
                    CatalogueList(sets: setsPrimary, mtgProfile: mtgProfile),
                    CatalogueList(sets: setsSecondary, mtgProfile: mtgProfile),
                    CatalogueList(sets: setsMisc, mtgProfile: mtgProfile),
                  ],
                ),
              ],
            );
          }
          return const Center(
            child: Text('Error fetching MTG Sets.'),
          );
        },
      ),
    );
  }
}
