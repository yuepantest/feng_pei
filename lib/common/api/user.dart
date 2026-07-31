

import 'package:dio/dio.dart';
import 'package:feng_pei/common/entity/entitys.dart';
import 'package:feng_pei/common/utils/utils.dart';

/// 用户
class UserAPI {
  static const String LOGIN_KEY = "/2026-07-11";
  /// 登录
  static Future<LoginEntity> login({required FormData params}) async {
    var response = await HttpUtil().post('/userLogin', params: params);
    return LoginEntity.fromJson(response);
  }

  /// getList
  static Future<ClientEntity> getList({required FormData params}) async {
    var response = await HttpUtil().post(LOGIN_KEY+'/getAllClientList', params: params);
    return ClientEntity.fromJson(response);
  }

  /// getSpecialList
  static Future<ClientEntity> getSpecialList({required FormData params}) async {
    var response = await HttpUtil().post(LOGIN_KEY+'/getSpacialClientList', params: params);
    return ClientEntity.fromJson(response);
  }


  /// getCalculateDate
  static Future<CalculateDataEntity> getCalculateDate({required FormData params}) async {
    var response = await HttpUtil().post('/getCalculateDate', params: params);
    return CalculateDataEntity.fromJson(response);
  }

  /// modifyRefuseClientData
  static Future<CalculateDataEntity> modifyRefuseClientData({required FormData params}) async {
    var response = await HttpUtil().post('/modifyRefuseClientData', params: params);
    return CalculateDataEntity.fromJson(response);
  }

  /// sendMsg
  static Future<BaseData> sendMsg({required FormData params}) async {
    var response = await HttpUtil().post('/sendMsg', params: params);
    return BaseData.fromJson(response);
  }
  /// sendMsgMH
  static Future<BaseData> sendMsgMH({required FormData params}) async {
    var response = await HttpUtil().post('/sendMsgMH', params: params);
    return BaseData.fromJson(response);
  }
}
