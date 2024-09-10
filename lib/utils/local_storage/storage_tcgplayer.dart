import 'package:collectors_bank/utils/http/tcgplayer.dart';
import 'package:get/get.dart';
import 'package:json_store/json_store.dart';

class CollectorsBankStorageMtg extends GetxController {
  static CollectorsBankStorageMtg get instance => Get.find();

  final JsonStore _jsonStore = JsonStore();

  Future<ModelTcgPlayerToken> readMTGData() async {
    Map<String, dynamic>? json = await _jsonStore.getItem('tcgplayerToken');
    ModelTcgPlayerToken result = ModelTcgPlayerToken.fromJson(json?["data"]);
    return result;
  }

  void writeMTGData(ModelTcgPlayerToken token) async {
    await _jsonStore.setItem('tcgplayerToken', token.toJson());
  }

  void deleteMTGData() async {
    await _jsonStore.deleteItem('tcgplayerToken');
  }
}
