const String viewCardVariants = 'v_cardVariants';

class ViewMTGCardVariantsFields {
  static final List<String> values = [
    cardID,
    cardName,
    cardNumber,
    cardType,
    cardImage,
    setCode,
    setName,
    setDate
  ];

  static const String cardID = 'cardID';
  static const String cardName = 'cardName';
  static const String cardNumber = 'cardNumber';
  static const String cardType = 'cardType';
  static const String cardImage = 'cardImage';
  static const String setCode = 'setCode';
  static const String setName = 'setName';
  static const String setDate = 'setDate';
}

class ViewMTGCardVariants {
  final String cardID;
  final String cardName;
  final String cardNumber;
  final String cardType;
  final String cardImage;
  final String setCode;
  final String setName;
  final String setDate;

  ViewMTGCardVariants(
      {required this.cardID,
      required this.cardName,
      required this.cardNumber,
      required this.cardType,
      required this.cardImage,
      required this.setCode,
      required this.setName,
      required this.setDate});

  static ViewMTGCardVariants fromJson(Map<String, Object?> json) =>
      ViewMTGCardVariants(
          cardID: checkIfNull(json[ViewMTGCardVariantsFields.cardID]),
          cardName: checkIfNull(json[ViewMTGCardVariantsFields.cardName]),
          cardNumber: checkIfNull(json[ViewMTGCardVariantsFields.cardNumber]),
          cardType: checkIfNull(json[ViewMTGCardVariantsFields.cardType]),
          cardImage: checkIfNull(json[ViewMTGCardVariantsFields.cardImage]),
          setCode: checkIfNull(json[ViewMTGCardVariantsFields.setCode]),
          setName: checkIfNull(json[ViewMTGCardVariantsFields.setName]),
          setDate: checkIfNull(json[ViewMTGCardVariantsFields.setDate]));

  static String checkIfNull(Object? item) {
    if (item == null) {
      return '';
    } else {
      return item as String;
    }
  }
}
