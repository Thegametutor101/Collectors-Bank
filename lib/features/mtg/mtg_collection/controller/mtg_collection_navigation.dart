import 'package:collectors_bank/features/mtg/mtg_cards/screens/mtg_card.dart';
import 'package:collectors_bank/features/mtg/mtg_collection/screens/mtg_collection.dart';
import 'package:collectors_bank/features/mtg/mtg_collection/screens/mtg_set_collection.dart';
import 'package:collectors_bank/utils/helpers/router_helper.dart';
import 'package:flutter/material.dart';

class MtgCollectionNavigation extends StatefulWidget {
  const MtgCollectionNavigation({super.key});

  @override
  State<MtgCollectionNavigation> createState() =>
      _MtgCollectionNavigationState();
}

class _MtgCollectionNavigationState extends State<MtgCollectionNavigation> {
  GlobalKey<NavigatorState> mtgCatalogueNavigationKey =
      GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: mtgCatalogueNavigationKey,
      onGenerateRoute: (RouteSettings settings) {
        return MaterialPageRoute(
          builder: (BuildContext context) {
            if (settings.name == RouterHelper.getMtgSetCollection()) {
              return settings.arguments as MtgSetCollection;
            } else if (settings.name == RouterHelper.getMtgCardCollection()) {
              return settings.arguments as MtgCard;
            }
            return const MtgCollection();
          },
        );
      },
    );
  }
}
