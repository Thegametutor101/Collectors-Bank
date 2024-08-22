import 'package:get_storage/get_storage.dart';

class CollectorsBankTempStorage {
  static final CollectorsBankTempStorage _instance =
      CollectorsBankTempStorage._internal();

  factory CollectorsBankTempStorage() {
    return _instance;
  }

  CollectorsBankTempStorage._internal();

  final _storage = GetStorage();

  Future<void> saveData<T>(String key, T value) async {
    await _storage.write(key, value);
  }

  T? readMtgCollectionData<T>(String key) {
    return _storage.read<T>(key);
  }

  Future<void> removeMtgCollectionData(String key) async {
    await _storage.remove(key);
  }

  Future<void> clearAll() async {
    await _storage.erase();
  }
}
