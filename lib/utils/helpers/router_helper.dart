import 'package:collectors_bank/app.dart';
import 'package:collectors_bank/features/mtg/mtg_cards/screens/mtg_card.dart';
import 'package:collectors_bank/features/mtg/mtg_collection/screens/mtg_collection.dart';
import 'package:collectors_bank/features/mtg/mtg_collection/screens/mtg_set_collection.dart';
import 'package:collectors_bank/features/mtg/mtg_home.dart';
import 'package:collectors_bank/features/mtg/mtg_set/screens/mtg_set.dart';
import 'package:collectors_bank/features/mtg/mtg_catalogue/screens/mtg_catalogue.dart';
import 'package:get/get.dart';

class RouterHelper {
  static const String initial = "/";
  static const String mtgHome = "/mtg-Home";

  /// Mtg Catalogue
  static const String mtgCatalogue = "/mtg-catalogue";
  static const String mtgSetCatalogue = "/catalogue-set";
  static const String mtgCardCatalogue = "/catalogue-card";

  /// Mtg Collection
  static const String mtgCollection = "/mtg-collection";
  static const String mtgSetCollection = "/collection-set";
  static const String mtgCardCollection = "/collection-card";

  static String getInitial() => "$initial";
  static String getMtgHome() => "$mtgHome";
  static String getMtgCatalogue() => "$mtgCatalogue";
  static String getMtgSetCatalogue() => "$mtgCatalogue$mtgSetCatalogue";
  static String getMtgCardCatalogue() =>
      "$mtgCatalogue$mtgSetCatalogue$mtgCardCatalogue";
  static String getMtgCollection() => "$mtgCollection";
  static String getMtgSetCollection() => "$mtgCollection$mtgSetCollection";
  static String getMtgCardCollection() =>
      "$mtgCollection$mtgSetCollection$mtgCardCollection";

  static List<GetPage> routes = [
    GetPage(
      name: initial,
      page: () {
        return const HomePage();
      },
      transition: Transition.fade,
    ),
    GetPage(
      name: mtgHome,
      page: () {
        return const MTGHome();
      },
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: mtgCatalogue,
      page: () {
        return const MtgCatalogue();
      },
      children: [
        GetPage(
          name: mtgSetCatalogue,
          page: () {
            MtgSet _mtgSets = Get.arguments;
            return _mtgSets;
          },
          children: [
            GetPage(
              name: mtgCardCatalogue,
              page: () {
                MtgCard _mtgCard = Get.arguments;
                return _mtgCard;
              },
            ),
          ],
        ),
      ],
    ),
    GetPage(
      name: mtgCollection,
      page: () {
        return const MtgCollection();
      },
      children: [
        GetPage(
          name: mtgSetCollection,
          page: () {
            MtgSetCollection _mtgSetCollection = Get.arguments;
            return _mtgSetCollection;
          },
          children: [
            GetPage(
              name: mtgCardCollection,
              page: () {
                MtgCard _mtgCard = Get.arguments;
                return _mtgCard;
              },
            ),
          ],
        ),
      ],
    ),
  ];
}
