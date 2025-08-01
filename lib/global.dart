import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'common/entity/entitys.dart';
import 'common/utils/utils.dart';
import 'common/values/values.dart';

/// 全局配置
class Global {
  /// 是否第一次打开
  static bool isFirstOpen = false;

  /// 是否离线登录
  static bool isOfflineLogin = false;

  /// 用户配置
  static UserInform profile = UserInform(
    token: "",
    name: "",
    password: "",
  );

  /// 是否 release
  static bool get isRelease => const bool.fromEnvironment("dart.vm.product");

  /// init
  static Future init() async {
    // 运行初始
    WidgetsFlutterBinding.ensureInitialized();
    // 工具初始
    await StorageUtil().initReady();
    HttpUtil();
    // 读取离线用户信息
    var str = StorageUtil().getItem(STORAGE_USER_INFORMATION_KEY);
    if (str.isNotEmpty) {
      var jsonStr = jsonDecode(str);
      profile = UserInform.fromJson(jsonStr);
      if (profile.name.isNotEmpty && profile.name != "") {
        isOfflineLogin = true;
      }
    }
    // http 缓存
    // android 状态栏为透明的沉浸
    if (Platform.isAndroid) {
      SystemUiOverlayStyle systemUiOverlayStyle =
          const SystemUiOverlayStyle(statusBarColor: Colors.transparent);
      SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
    }

    // 读取设备第一次打开
    var openStatus = StorageUtil().getItem(STORAGE_DEVICE_ALREADY_OPEN_KEY);
    if (openStatus.isNotEmpty && openStatus == "1") {
      isFirstOpen = false;
    } else {
      isFirstOpen = true;
      StorageUtil().setItem(STORAGE_DEVICE_ALREADY_OPEN_KEY, "1");
    }
  }

  // 持久化 用户信息
  static Future<void> saveProfile(UserInform userResponse) {
    profile = userResponse;
    String jsonString = jsonEncode(userResponse.toJson());
    return StorageUtil().setItem(STORAGE_USER_INFORMATION_KEY, jsonString);
  }
}
