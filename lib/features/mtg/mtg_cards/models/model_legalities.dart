class Legalities {
  final String standard;
  final String future;
  final String historic;
  final String timeless;
  final String gladiator;
  final String pioneer;
  final String explorer;
  final String modern;
  final String legacy;
  final String pauper;
  final String vintage;
  final String penny;
  final String commander;
  final String oathbreaker;
  final String standardbrawl;
  final String brawl;
  final String alchemy;
  final String paupercommander;
  final String duel;
  final String oldschool;
  final String premodern;
  final String predh;

  Legalities(
      {required this.standard,
      required this.future,
      required this.historic,
      required this.timeless,
      required this.gladiator,
      required this.pioneer,
      required this.explorer,
      required this.modern,
      required this.legacy,
      required this.pauper,
      required this.vintage,
      required this.penny,
      required this.commander,
      required this.oathbreaker,
      required this.standardbrawl,
      required this.brawl,
      required this.alchemy,
      required this.paupercommander,
      required this.duel,
      required this.oldschool,
      required this.premodern,
      required this.predh});

  static Legalities fromJson(Map<String, Object?> json) => Legalities(
      standard: json["standard"] as String,
      future: json["future"] as String,
      historic: json["historic"] as String,
      timeless: json["timeless"] as String,
      gladiator: json["gladiator"] as String,
      pioneer: json["pioneer"] as String,
      explorer: json["explorer"] as String,
      modern: json["modern"] as String,
      legacy: json["legacy"] as String,
      pauper: json["pauper"] as String,
      vintage: json["vintage"] as String,
      penny: json["penny"] as String,
      commander: json["commander"] as String,
      oathbreaker: json["oathbreaker"] as String,
      standardbrawl: json["standardbrawl"] as String,
      brawl: json["brawl"] as String,
      alchemy: json["alchemy"] as String,
      paupercommander: json["paupercommander"] as String,
      duel: json["duel"] as String,
      oldschool: json["oldschool"] as String,
      premodern: json["premodern"] as String,
      predh: json["predh"] as String);
}
