
class BaseData {
  int? code;
  String? msg;

  BaseData({this.code, this.msg});

  factory BaseData.fromJson(Map<String, dynamic> json) {
    return BaseData(
      code: json['code'],
      msg: json['msg'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'msg': msg,
    };
  }
}