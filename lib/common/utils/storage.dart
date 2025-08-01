import 'package:feng_pei/common/values/values.dart';
import 'package:localstorage/localstorage.dart';

/// 本地存储
/// 单例 StorageUtil().getItem('key')
class StorageUtil {
  static final StorageUtil _singleton = StorageUtil._internal();

  final LocalStorage _storage = LocalStorage(STORAGE_APP_INFORMATION);

  factory StorageUtil() {
    return _singleton;
  }

  StorageUtil._internal();

  initReady() async {
    await _storage.ready;
  }

  String getItem(String key)  {
    var item = _storage.getItem(key);
    if (item == null) {
      return "";
    } else {
      return item;
    }
  }

  Future<void> setItem(String key, String val) async {
    await _storage.setItem(key, val);
  }
}
