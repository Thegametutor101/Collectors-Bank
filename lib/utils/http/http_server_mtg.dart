import 'package:collectors_bank/bindings/models/mtg/model_set.dart';
import 'package:collectors_bank/utils/local_storage/storage_mtg.dart';
import 'package:http/http.dart' as http;

class CollectorsBankHttpServer {
  static const String _baseUrlMtg =
      "http://192.168.50.126/Collectors-Bank/mtg/entities";

  static Future<List<ModelMtgSet>> getMtgSets(String endpoint) async {
    final response = await http.get(Uri.parse('$_baseUrlMtg/$endpoint'),
        headers: {'Accept': 'application/json'});
    if (response.statusCode == 200) {
      final parser = JsonParserMTGSets(response.body);
      return parser.parseInBackground();
    } else {
      throw Exception(
          'Sorry!\nFailed to retreive Magic the Gathering sets from our servers.');
    }
  }
}
