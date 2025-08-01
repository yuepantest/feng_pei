// To parse this JSON data, do
//
//     final loginEntity = loginEntityFromJson(jsonString);

import 'dart:convert';

LoginEntity loginEntityFromJson(String str) =>
    LoginEntity.fromJson(json.decode(str));

String loginEntityToJson(LoginEntity data) => json.encode(data.toJson());

class LoginEntity {
  int code;
  String msg;
  UserInform data;

  LoginEntity({
    required this.code,
    required this.msg,
    required this.data,
  });

  factory LoginEntity.fromJson(Map<String, dynamic> json) => LoginEntity(
        code: json["code"],
        msg: json["msg"],
        data: UserInform.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "msg": msg,
        "data": data.toJson(),
      };
}

class UserInform {
  String token;
  String name;
  String? password;

  UserInform({
    required this.token,
    required this.name,
    this.password,
  });

  factory UserInform.fromJson(Map<String, dynamic> json) => UserInform(
        token: json["token"],
        name: json["name"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "token": token,
        "name": name,
        "password": password,
      };
}
