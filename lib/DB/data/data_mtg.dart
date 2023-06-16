import 'package:flutter/material.dart';

class MTGDataFeilds {
  static final List<String> values = [dataSet];

  static const String dataSet = 'DataSet';
}

class MTGDataSetFeilds {
  static final List<String> values = [setCode, collected, card];

  static const String setCode = 'setCode';
  static const String collected = 'collected';
  static const String card = 'DataCard';
}

class MTGDataCardFeilds {
  static final List<String> values = [cardCode, owned, inUse];

  static const String cardCode = 'cardCode';
  static const String owned = 'owned';
  static const String inUse = 'inUse';
}

class MTGData {
  final MTGDataSet dataSet;

  MTGData({required this.dataSet});

  static MTGData fromJson(Map<String, dynamic> json) => MTGData(
      dataSet: MTGDataSet(
          setCode: checkIfNull(
              json[MTGDataFeilds.dataSet][MTGDataSetFeilds.setCode]),
          collected: checkIfNull(
              json[MTGDataFeilds.dataSet][MTGDataSetFeilds.collected]),
          card: json[MTGDataFeilds.dataSet][MTGDataSetFeilds.card]
              .map<MTGDataCard>((json) => _loopDataCards(json))
              .toList()));

  static MTGDataCard _loopDataCards(Map<String, dynamic> json) => MTGDataCard(
      cardCode: checkIfNull(json[MTGDataCardFeilds.cardCode]),
      owned: checkIfNull(json[MTGDataCardFeilds.owned]),
      inUse: checkIfNull(json[MTGDataCardFeilds.inUse]));

  static String checkIfNull(Object? item) {
    if (item == null) {
      return '';
    } else {
      return item as String;
    }
  }
}

class MTGDataSet {
  final String setCode;
  final String collected;
  final List<MTGDataCard> card;

  MTGDataSet(
      {required this.setCode, required this.collected, required this.card});
}

class MTGDataCard {
  final String cardCode;
  final String owned;
  final String inUse;

  MTGDataCard(
      {required this.cardCode, required this.owned, required this.inUse});
}
