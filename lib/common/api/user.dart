

import 'package:dio/dio.dart';
import 'package:feng_pei/common/entity/entitys.dart';
import 'package:feng_pei/common/utils/utils.dart';

/// 用户
class UserAPI {
  /// 登录
  static Future<LoginEntity> login({required FormData params}) async {
    var response = await HttpUtil().post('/userLogin', params: params);
    return LoginEntity.fromJson(response);
  }

  /// getList
  static Future<ClientEntity> getList({required FormData params}) async {
    var response = await HttpUtil().post('/getAllClientList', params: params);
    return ClientEntity.fromJson(response);
  }

  /// getSpecialList
  static Future<ClientEntity> getSpecialList({required FormData params}) async {
    var response = await HttpUtil().post('/getSpacialClientList', params: params);
    return ClientEntity.fromJson(response);
  }


  /// getCalculateDate
  static Future<CalculateDataEntity> getCalculateDate({required FormData params}) async {
    var response = await HttpUtil().post('/getCalculateDate', params: params);
    return CalculateDataEntity.fromJson(response);
  }
}
