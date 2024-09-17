import 'package:collectors_bank/features/mtg/mtg_cards/screens/mtg_card.dart';
import 'package:collectors_bank/features/mtg/mtg_catalogue/screens/mtg_catalogue.dart';
import 'package:collectors_bank/features/mtg/mtg_search/screens/mtg_search.dart';
import 'package:collectors_bank/features/mtg/mtg_set/screens/mtg_set.dart';
import 'package:collectors_bank/utils/helpers/router_helper.dart';
import 'package:flutter/material.dart';

class MtgCatalogueNavigation extends StatefulWidget {
  const MtgCatalogueNavigation({super.key});

  @override
  State<MtgCatalogueNavigation> createState() => _MtgCatalogueNavigationState();
}

class _MtgCatalogueNavigationState extends State<MtgCatalogueNavigation> {
  GlobalKey<NavigatorState> mtgCatalogueNavigationKey =
      GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: mtgCatalogueNavigationKey,
      onGenerateRoute: (RouteSettings settings) {
        return MaterialPageRoute(
          builder: (BuildContext context) {
            if (settings.name == RouterHelper.getMtgSetCatalogue()) {
              return settings.arguments as MtgSet;
            } else if (settings.name == RouterHelper.getMtgCardCatalogue()) {
              return settings.arguments as MtgCard;
            } else if (settings.name == RouterHelper.getMtgSearchCatalogue()) {
              return settings.arguments as MtgSearch;
            }
            return const MtgCatalogue();
          },
        );
      },
    );
  }
}
