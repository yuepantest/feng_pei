// To parse this JSON data, do
//
//     final clientEntity = clientEntityFromJson(jsonString);

import 'dart:convert';

ClientEntity clientEntityFromJson(String str) => ClientEntity.fromJson(json.decode(str));

String clientEntityToJson(ClientEntity data) => json.encode(data.toJson());

class ClientEntity {
  int code;
  String msg;
  List<ClientDatum> data;

  ClientEntity({
    required this.code,
    required this.msg,
    required this.data,
  });

  factory ClientEntity.fromJson(Map<String, dynamic> json) => ClientEntity(
    code: json["code"],
    msg: json["msg"],
    data: List<ClientDatum>.from(json["data"].map((x) => ClientDatum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "msg": msg,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class ClientDatum {
  int id;
  String clientName;
  String city;
  String phone;
  String identityCard;
  int monthIncome;
  int socialSecurity;
  int accumulationFund;
  int estateValue;
  int loanAmount;
  int antPoints;
  int creditStatue;
  String bankId;
  int type;
  DateTime applyTime;
  int assessMoney;
  int status;
  String educationBackground;
  String maritalStatus;
  String debt;
  String presentAddress;
  String detailAddress;
  String livingModel;
  int livingSpend;
  String childrenNumber;
  String relativeOneName;
  String relativeOneBetween;
  String relativeOnePhone;
  String relativeTwoName;
  String relativeTwoBetween;
  String relativeTwoPhone;
  String colleagueOneName;
  String colleagueOnePhone;
  String colleagueTwoName;
  String colleagueTwoPhone;
  String companyname;
  String companytype;
  String companysector;
  String companyposition;
  String companytime;
  String leaderName;
  String companyScale;
  String monthSalary;
  String acquairSalaryType;
  String acquairSalaryDate;
  String companyAdress;
  String companyPhoneNumber;
  String commuteTime;
  String remark;
  String refuseReasonOne;
  String refuseReasonTwo;
  String applicationNumber;
  DateTime? submitTime;
  int sendMsg;

  ClientDatum({
    required this.refuseReasonOne,
    required this.refuseReasonTwo,
    required this.applicationNumber,
    required this.id,
    required this.clientName,
    required this.city,
    required this.phone,
    required this.identityCard,
    required this.monthIncome,
    required this.socialSecurity,
    required this.accumulationFund,
    required this.estateValue,
    required this.loanAmount,
    required this.antPoints,
    required this.creditStatue,
    required this.type,
    required this.applyTime,
    required this.assessMoney,
    required this.status,
    required this.educationBackground,
    required this.maritalStatus,
    required this.debt,
    required this.bankId,
    required this.presentAddress,
    required this.detailAddress,
    required this.livingModel,
    required this.livingSpend,
    required this.childrenNumber,
    required this.relativeOneName,
    required this.relativeOneBetween,
    required this.relativeOnePhone,
    required this.relativeTwoName,
    required this.relativeTwoBetween,
    required this.relativeTwoPhone,
    required this.colleagueOneName,
    required this.colleagueOnePhone,
    required this.colleagueTwoName,
    required this.colleagueTwoPhone,
    required this.companyname,
    required this.companytype,
    required this.companysector,
    required this.companyposition,
    required this.companytime,
    required this.leaderName,
    required this.companyScale,
    required this.monthSalary,
    required this.acquairSalaryType,
    required this.acquairSalaryDate,
    required this.companyAdress,
    required this.companyPhoneNumber,
    required this.commuteTime,
    required this.remark,
    required this.submitTime,
    required this.sendMsg,
  });

  factory ClientDatum.fromJson(Map<String, dynamic> json) => ClientDatum(
    id: json["id"],
    refuseReasonOne: json["refuseReasonOne"]??"",
    refuseReasonTwo: json["refuseReasonTwo"]??"",
    applicationNumber: json["applicationNumber"]??"",
    clientName: json["clientName"],
    city: json["city"],
    phone: json["phone"],
    identityCard: json["identityCard"],
    monthIncome: json["monthIncome"],
    socialSecurity: json["socialSecurity"],
    accumulationFund: json["accumulationFund"],
    estateValue: json["estateValue"],
    loanAmount: json["loanAmount"],
    antPoints: json["antPoints"],
    creditStatue: json["creditStatue"],
    type: json["type"],
    bankId: json["bankId"]??"",
    applyTime: DateTime.parse(json["applyTime"]),
    assessMoney: json["assessMoney"],
    status: json["status"],
    educationBackground: json["educationBackground"]??"",
    maritalStatus: json["maritalStatus"]??"",
    debt: json["debt"]??"",
    presentAddress: json["presentAddress"]??"",
    detailAddress: json["detailAddress"]??"",
    livingModel: json["livingModel"]??"",
    livingSpend: json["livingSpend"]??"",
    childrenNumber: json["childrenNumber"]??"",
    relativeOneName: json["relativeOneName"]??"",
    relativeOneBetween: json["relativeOneBetween"]??"",
    relativeOnePhone: json["relativeOnePhone"]??"",
    relativeTwoName: json["relativeTwoName"]??"",
    relativeTwoBetween: json["relativeTwoBetween"]??"",
    relativeTwoPhone: json["relativeTwoPhone"]??"",
    colleagueOneName: json["colleagueOneName"]??"",
    colleagueOnePhone: json["colleagueOnePhone"]??"",
    colleagueTwoName: json["colleagueTwoName"]??"",
    colleagueTwoPhone: json["colleagueTwoPhone"]??"",
    companyname: json["companyname"]??"",
    companytype: json["companytype"]??"",
    companysector: json["companysector"]??"",
    companyposition: json["companyposition"]??"",
    companytime: json["companytime"]??"",
    leaderName: json["leaderName"]??"",
    companyScale: json["companyScale"]??"",
    monthSalary: json["monthSalary"]??"",
    acquairSalaryType: json["acquairSalaryType"]??"",
    acquairSalaryDate: json["acquairSalaryDate"]??"",
    companyAdress: json["companyAdress"]??"",
    companyPhoneNumber: json["companyPhoneNumber"]??"",
    commuteTime: json["commuteTime"]??"",
    remark: json["remark"]??"",
    sendMsg: json["sendMsg"],
    submitTime: json["submitTime"] == null ? null : DateTime.parse(json["submitTime"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "refuseReasonOne": refuseReasonOne,
    "refuseReasonTwo": refuseReasonTwo,
    "applicationNumber": applicationNumber,
    "clientName": clientName,
    "city": city,
    "phone": phone,
    "identityCard": identityCard,
    "monthIncome": monthIncome,
    "socialSecurity": socialSecurity,
    "accumulationFund": accumulationFund,
    "estateValue": estateValue,
    "loanAmount": loanAmount,
    "antPoints": antPoints,
    "creditStatue": creditStatue,
    "type": type,
    "bankId": bankId,
    "applyTime": applyTime.toIso8601String(),
    "assessMoney": assessMoney,
    "status": status,
    "educationBackground": educationBackground,
    "maritalStatus": maritalStatus,
    "debt": debt,
    "presentAddress": presentAddress,
    "detailAddress": detailAddress,
    "livingModel": livingModel,
    "livingSpend": livingSpend,
    "childrenNumber": childrenNumber,
    "relativeOneName": relativeOneName,
    "relativeOneBetween": relativeOneBetween,
    "relativeOnePhone": relativeOnePhone,
    "relativeTwoName": relativeTwoName,
    "relativeTwoBetween": relativeTwoBetween,
    "relativeTwoPhone": relativeTwoPhone,
    "colleagueOneName": colleagueOneName,
    "colleagueOnePhone": colleagueOnePhone,
    "colleagueTwoName": colleagueTwoName,
    "colleagueTwoPhone": colleagueTwoPhone,
    "companyname": companyname,
    "companytype": companytype,
    "companysector": companysector,
    "companyposition": companyposition,
    "companytime": companytime,
    "leaderName": leaderName,
    "companyScale": companyScale,
    "monthSalary": monthSalary,
    "acquairSalaryType": acquairSalaryType,
    "acquairSalaryDate": acquairSalaryDate,
    "companyAdress": companyAdress,
    "companyPhoneNumber": companyPhoneNumber,
    "commuteTime": commuteTime,
    "remark": remark,
    "sendMsg": sendMsg,
    "submitTime": submitTime?.toIso8601String(),
  };
}
