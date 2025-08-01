import 'dart:async';
import 'package:dio/dio.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:feng_pei/common/utils/utils.dart';
import 'package:feng_pei/common/values/values.dart';

class HttpUtil {
  static final HttpUtil _instance = HttpUtil._internal();

  factory HttpUtil() => _instance;
  late Dio dio;
  CancelToken cancelToken = CancelToken();

  HttpUtil._internal() {
    // BaseOptions、Options、RequestOptions 都可以配置参数，优先级别依次递增，且可以根据优先级别覆盖参数
    BaseOptions options = BaseOptions(
      // 请求基地址,可以包含子路径
      baseUrl: "http://47.109.33.172:8081/",
      // baseUrl: storage.read(key: STORAGE_KEY_APIURL) ?? SERVICE_API_BASEURL,
      //连接服务器超时时间，单位是毫秒.
      connectTimeout: 10000,
      // 响应流上前后两次接受到数据的间隔，单位为毫秒。
      receiveTimeout: 5000,
      headers: {
        "Content-Type": "application/json",
      },
    );
    dio = Dio(options);
    // Cookie管理
    CookieJar cookieJar = CookieJar();
    dio.interceptors.add(CookieManager(cookieJar));
    // 添加拦截器
    dio.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) {
      return handler.next(options); //continue
    }, onResponse: (response, handler) {
      return handler.next(response); // continue
    }, onError: (DioError e, handler) {
      ErrorEntity eInfo = createErrorEntity(e);
      //toastInfo(msg: eInfo.message);
      return handler.next(e); //continue
    }));
  }

  /*
   * error统一处理
   */
  // 错误信息
  ErrorEntity createErrorEntity(DioError error) {
    switch (error.type) {
      case DioErrorType.cancel:
        {
          return ErrorEntity(code: -1, message: "请求取消");
        }
      case DioErrorType.connectTimeout:
        {
          return ErrorEntity(code: -1, message: "连接超时");
        }
      case DioErrorType.sendTimeout:
        {
          return ErrorEntity(code: -1, message: "请求超时");
        }
      case DioErrorType.receiveTimeout:
        {
          return ErrorEntity(code: -1, message: "响应超时");
        }
      case DioErrorType.response:
        {
          try {
            var errCode = error.response?.statusCode;
            var errMsg = error.response?.statusMessage;
            switch (errCode) {
              case 400:
                {
                  return ErrorEntity(code: 400, message: "请求语法错误");
                }
              case 401:
                {
                  return ErrorEntity(code: 401, message: "没有权限");
                }
              case 403:
                {
                  return ErrorEntity(code: 403, message: "服务器拒绝执行");
                }
              case 404:
                {
                  return ErrorEntity(code: 404, message: "无法连接服务器");
                }
              case 405:
                {
                  return ErrorEntity(code: 405, message: "请求方法被禁止");
                }
              case 500:
                {
                  return ErrorEntity(code: 500, message: "服务器内部错误");
                }
              case 502:
                {
                  return ErrorEntity(code: 502, message: "无效的请求");
                }
              case 503:
                {
                  return ErrorEntity(code: 503, message: "服务器挂了");
                }
              case 505:
                {
                  return ErrorEntity(code: 505, message: "不支持HTTP协议请求");
                }
              default:
                {
                  return ErrorEntity(code: -999, message: errMsg ?? "未知错误");
                }
            }
          } on Exception catch (_) {
            return ErrorEntity(code: -1, message: "未知错误");
          }
        }
      default:
        {
          return ErrorEntity(code: -1, message: error.message);
        }
    }
  }

  /*
   * 取消请求
   *
   * 同一个cancel token 可以用于多个请求，当一个cancel token取消时，所有使用该cancel token的请求都会被取消。
   * 所以参数可选
   */
  void cancelRequests(CancelToken token) {
    token.cancel("cancelled");
  }



  /// restful get 操作
  Future get(String path,
      {dynamic params, Options? options, CancelToken? cancelToken}) async {
    try {
      var response = await dio.get(path,
          queryParameters: params,
          cancelToken: cancelToken);
      return response.data;
    } on DioError catch (e) {
      throw createErrorEntity(e);
    }
  }

  /// restful post 操作
  Future post(String path,
      {dynamic params, Options? options, CancelToken? cancelToken}) async {
    try {
      var response = await dio.post(path, data: params);
      return response.data;
    } on DioError catch (e) {
      throw createErrorEntity(e);
    }
  }

  /// restful put 操作
  Future put(String path,
      {dynamic params, Options? options, CancelToken? cancelToken}) async {
    try {
      var response = await dio.put(path,
          data: params,  cancelToken: cancelToken);
      return response.data;
    } on DioError catch (e) {
      throw createErrorEntity(e);
    }
  }

  /// restful delete 操作
  Future delete(String path,
      {dynamic params, Options? options, CancelToken? cancelToken}) async {
    try {

      var response = await dio.delete(path,
          data: params, cancelToken: cancelToken);
      return response.data;
    } on DioError catch (e) {
      throw createErrorEntity(e);
    }
  }

  /// restful post form 表单提交操作
  Future postForm(String path,
      {dynamic params, Options? options, CancelToken? cancelToken}) async {
    try {

      var response = await dio.post(path,
          data: FormData.fromMap(params),

          cancelToken: cancelToken);
      return response.data;
    } on DioError catch (e) {
      throw createErrorEntity(e);
    }
  }
}

// 异常处理
class ErrorEntity implements Exception {
  int code;
  String? message;

  ErrorEntity({required this.code, this.message});

  @override
  String toString() {
    if (message == null) return "Exception";
    return "Exception: code $code, $message";
  }
}
