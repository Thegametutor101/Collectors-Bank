import 'package:collectors_bank/common/profiles/mtg_profile.dart';
import 'package:get/get.dart';
import 'package:json_store/json_store.dart';

class CollectorsBankStorageMtg extends GetxController {
  static CollectorsBankStorageMtg get instance => Get.find();

  final JsonStore _jsonStore = JsonStore();

  Future<List<MtgProfile>> readMTGData() async {
    Map<String, dynamic>? json = await _jsonStore.getItem('mtgProfile');
    List<MtgProfile> result = [];
    if (json != null) {
      for (var profile in json["data"]) {
        result.add(MtgProfile.fromJson(profile));
      }
    }
    return result;
  }

  void writeMTGData(List<MtgProfile> profile) async {
    List<Map<String, dynamic>> profileString = [];
    for (var set in profile) {
      profileString.add(set.toJson());
    }
    Map<String, dynamic> json = {"data": profileString};
    await _jsonStore.setItem('mtgProfile', json);
  }

  void deleteMTGData() async {
    await _jsonStore.deleteItem('mtgProfile');
  }
}
