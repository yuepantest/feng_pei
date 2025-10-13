// To parse this JSON data, do
//
//     final calculateDataEntity = calculateDataEntityFromJson(jsonString);

import 'dart:convert';

CalculateDataEntity calculateDataEntityFromJson(String str) => CalculateDataEntity.fromJson(json.decode(str));

String calculateDataEntityToJson(CalculateDataEntity data) => json.encode(data.toJson());

class CalculateDataEntity {
  int code;
  String msg;
  Data data;

  CalculateDataEntity({
    required this.code,
    required this.msg,
    required this.data,
  });

  factory CalculateDataEntity.fromJson(Map<String, dynamic> json) => CalculateDataEntity(
    code: json["code"],
    msg: json["msg"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "msg": msg,
    "data": data.toJson(),
  };
}

class Data {
  int num;
  int type;
  String titleOne;
  String contentOne;
  String titleTwo;
  String contentTwo;
  String titleThree;
  String contentTree;
  String titleFour;
  String contentFour;
  String titleFive;
  String contentFive;
  String titleSix;
  String contentSix;
  String rate;
  String applicationNumber;
  String bankIdContent;
  String identityCardContent;
  int id;

  Data({
    required this.num,
    required this.type,
    required this.titleOne,
    required this.contentOne,
    required this.titleTwo,
    required this.contentTwo,
    required this.titleThree,
    required this.contentTree,
    required this.titleFour,
    required this.contentFour,
    required this.titleFive,
    required this.contentFive,
    required this.titleSix,
    required this.contentSix,
    required this.rate,
    required this.applicationNumber,
    required this.bankIdContent,
    required this.identityCardContent,
    required this.id,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    num: json["num"],
    type: json["type"],
    titleOne: json["title_one"],
    contentOne: json["content_one"],
    titleTwo: json["title_two"],
    contentTwo: json["content_two"],
    titleThree: json["title_three"],
    contentTree: json["content_tree"],
    titleFour: json["title_four"],
    contentFour: json["content_four"],
    titleFive: json["title_five"]??"",
    contentFive: json["content_five"]??"",
    titleSix: json["title_six"]??"",
    contentSix: json["content_six"]??"",
    rate: json["rate"],
    applicationNumber: json["applicationNumber"],
    bankIdContent: json["bankIdContent"],
    identityCardContent: json["identityCardContent"],
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "num": num,
    "type": type,
    "title_one": titleOne,
    "content_one": contentOne,
    "title_two": titleTwo,
    "content_two": contentTwo,
    "title_three": titleThree,
    "content_tree": contentTree,
    "title_four": titleFour,
    "content_four": contentFour,
    "title_five": titleFive,
    "content_five": contentFive,
    "title_six": titleSix,
    "content_six": contentSix,
    "rate": rate,
    "applicationNumber": applicationNumber,
    "bankIdContent": bankIdContent,
    "identityCardContent": identityCardContent,
    "id": id,
  };
}
