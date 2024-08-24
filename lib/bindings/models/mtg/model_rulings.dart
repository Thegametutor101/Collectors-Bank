class ModelRulings {
  final String object;
  final String oracle_id;
  final String source; // 'token', 'meld_part', 'meld_result', 'combo_piece'
  final String published_at;
  final String comment;

  ModelRulings(
      {required this.object,
      required this.oracle_id,
      required this.source,
      required this.published_at,
      required this.comment});

  static ModelRulings fromJson(Map<String, Object?> json) => ModelRulings(
      object: json["object"] as String,
      oracle_id: json["oracle_id"] as String,
      source: json["source"] as String,
      published_at: json["published_at"] as String,
      comment: json["comment"] as String);
}
