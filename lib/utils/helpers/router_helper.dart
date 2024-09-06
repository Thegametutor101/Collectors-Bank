import 'package:collectors_bank/app.dart';
import 'package:collectors_bank/features/mtg/mtg_cards/screens/mtg_card.dart';
import 'package:collectors_bank/features/mtg/mtg_home.dart';
import 'package:collectors_bank/features/mtg/mtg_set/screens/mtg_set.dart';
import 'package:collectors_bank/features/mtg/mtg_catalogue/screens/mtg_catalogue.dart';
import 'package:get/get.dart';

class RouterHelper {
  static const String initial = "/";
  static const String mtgHome = "/mtg-Home";
  static const String mtgCatalogue = "/mtg_catalogue";
  static const String mtgSet = "/set";
  static const String mtgCard = "/card";

  static String getInitial() => "$initial";
  static String getMtgHome() => "$mtgHome";
  static String getMtgCatalogue() => "$mtgCatalogue";
  static String getMtgSet() => "$mtgCatalogue$mtgSet";
  static String getMtgCard() => "$mtgCatalogue$mtgSet$mtgCard";

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
          name: mtgSet,
          page: () {
            MtgSet _mtgSets = Get.arguments;
            return _mtgSets;
          },
          children: [
            GetPage(
              name: mtgCard,
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
