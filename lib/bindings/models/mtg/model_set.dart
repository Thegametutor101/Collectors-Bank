const String tableSets = 'sets';

class ModelMtgSetFields {
  static final List<String> values = [name, code, date, is_promo, cardCount];

  static const String name = 'Nname';
  static const String code = 'Ncode';
  static const String date = 'NdateValue';
  static const String is_promo = 'Nis_promo';
  static const String cardCount = 'cardCount';
}

class ModelMtgSet {
  final String name;
  final String code;
  final String date;
  final String is_promo;
  final String cardCount;

  ModelMtgSet(
      {required this.name,
      required this.code,
      required this.date,
      required this.is_promo,
      required this.cardCount});

  static ModelMtgSet fromJson(Map<String, Object?> json) => ModelMtgSet(
      name: json[ModelMtgSetFields.name] as String,
      code: json[ModelMtgSetFields.code] as String,
      date: json[ModelMtgSetFields.date] as String,
      is_promo: json[ModelMtgSetFields.is_promo] as String,
      cardCount: json[ModelMtgSetFields.cardCount] as String);
}
