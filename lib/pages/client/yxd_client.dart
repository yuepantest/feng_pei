import 'dart:async';
import 'dart:math' as math;

import 'package:dio/dio.dart';
import 'package:feng_pei/common/entity/entitys.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../common/api/apis.dart';
import '../../common/utils/utils.dart';
import '../../common/values/values.dart';
import '../../common/widgets/widgets.dart';

class YXDClient extends StatefulWidget {
  final ClientDatum data;

  const YXDClient({Key? key, required this.data}) : super(key: key);

  @override
  _YXDClientState createState() => _YXDClientState();
}

class _YXDClientState extends State<YXDClient> {
  Data? calculateData;

  Future<void> getListData(ClientDatum data) async {
    var formData = FormData.fromMap({
      'clientId': data.id,
    });
    CalculateDataEntity res = await UserAPI.getCalculateDate(params: formData);
    if (res.code == 1) {
      setState(() {
        calculateData = res.data;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getListData(widget.data);
  }

  @override
  Widget build(BuildContext context) {
    var data = widget.data;
    String formattedDateTime = "";
    DateFormat formatter = DateFormat('yyyy-MM-dd HH:mm');
    if (data.submitTime != null) {
      formattedDateTime = formatter.format(data.submitTime!);
    }
    return Scaffold(
      appBar: transparentAppBar(
        color: AppColors.yxdBlack,
        title: Padding(
            padding: EdgeInsets.only(right: duSetWidth(40)),
            child: const Text(
              "审批结果",
              style: TextStyle(
                  color: AppColors.primaryElementText,
                  fontWeight: FontWeight.w600),
            )),
        context: context,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: AppColors.primaryElementText,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: <Widget>[],
      ),
      body: SizedBox.expand(
        child: DecoratedBox(
          decoration: const BoxDecoration(
            color: AppColors.secondY,
          ),
          child: Column(children: [
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      colors: [AppColors.yxdBlack, AppColors.secondY],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start, // 水平方向靠左
                mainAxisAlignment: MainAxisAlignment.start, // 垂直方向靠上
                children: [
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: AppColors.primaryBackground,
                        borderRadius: BorderRadius.circular(duSetWidth(10))),
                    margin: EdgeInsets.only(
                      top: duSetWidth(10),
                      left: duSetWidth(15),
                      right: duSetWidth(15),
                      bottom: duSetWidth(30),
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              top: duSetHeight(30), bottom: duSetHeight(8)),
                          child: Image.asset(
                            "assets/images/shalou.png",
                            width: duSetWidth(80),
                          ),
                        ),
                        Text(
                          setApplicationStatusTitle(data),
                          style: TextStyle(
                              color: AppColors.primaryText,
                              fontWeight: FontWeight.bold,
                              fontSize: duSetFontSize(18)),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: duSetHeight(15), bottom: duSetHeight(30),right: duSetWidth(20),left: duSetWidth(20)),
                          child: Text(
                            setApplicationStatusContent(data),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: AppColors.primaryText,
                                fontSize: duSetFontSize(14)),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: duSetHeight(10), bottom: duSetHeight(15)),
                          child: Row(
                            mainAxisAlignment:
                                MainAxisAlignment.spaceEvenly, // 垂直方向靠上
                            children: [
                              myButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                gbColor: AppColors.transparency,
                                fontSize: duSetFontSize(15),
                                height: duSetHeight(38),
                                sideColor: Colors.grey.shade400,
                                title: "回到主页",
                                fontColor: AppColors.primaryText,
                                cornerRadius: duSetHeight(19),
                              ),
                              myButton(
                                onPressed: () {
                                  Future.delayed(const Duration(seconds: 1), () {
                                    toastInfo(msg: "结果已刷新");
                                  });
                                },
                                gbColor: AppColors.yxdBlack,
                                fontSize: duSetFontSize(15),
                                height: duSetHeight(38),
                                sideColor: AppColors.yxdBlack,
                                title: "刷新结果",
                                fontColor: AppColors.primaryBackground,
                                cornerRadius: duSetHeight(19),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  color: AppColors.primaryBackground,
                  borderRadius: BorderRadius.circular(duSetWidth(10))),
              margin: EdgeInsets.only(
                top: duSetWidth(10),
                left: duSetWidth(15),
                right: duSetWidth(15),
                bottom: duSetWidth(10),
              ),
              padding: EdgeInsets.only(
                top: duSetWidth(10),
                left: duSetWidth(10),
                right: duSetWidth(10),
                bottom: duSetWidth(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        top: duSetHeight(10),
                        bottom: duSetHeight(5),
                        left: duSetWidth(9),
                        right: duSetWidth(10)),
                    child: Text(
                      "借款详情",
                      style: TextStyle(
                          color: AppColors.primaryText,
                          fontSize: duSetFontSize(14),
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: duSetWidth(10), top: duSetHeight(10)),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "申请人",
                          style: TextStyle(
                              color: AppColors.thirdElementText,
                              fontSize: duSetFontSize(12)),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: duSetHeight(66)),
                          child: Text(
                            data.clientName,
                            style: TextStyle(
                                color: AppColors.thirdElementText,
                                fontSize: duSetFontSize(12)),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: duSetWidth(10), top: duSetHeight(10)),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "申请金额",
                          style: TextStyle(
                              color: AppColors.thirdElementText,
                              fontSize: duSetFontSize(12)),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: duSetHeight(50)),
                          child: Text(
                            "￥" + data.assessMoney.toString(),
                            style: TextStyle(
                                color: AppColors.thirdElementText,
                                fontSize: duSetFontSize(12)),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: duSetWidth(10), top: duSetHeight(10)),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "借款利率",
                          style: TextStyle(
                              color: AppColors.thirdElementText,
                              fontSize: duSetFontSize(12)),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: duSetHeight(50)),
                          child: Text(
                            "年利率" + calculateYearRate(calculateData),
                            style: TextStyle(
                                color: AppColors.thirdElementText,
                                fontSize: duSetFontSize(12)),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: duSetWidth(10), top: duSetHeight(10)),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "受理日期",
                          style: TextStyle(
                              color: AppColors.thirdElementText,
                              fontSize: duSetFontSize(12)),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: duSetHeight(50)),
                          child: Text(
                            dealWithSubmitTime(data.submitTime),
                            style: TextStyle(
                                color: AppColors.thirdElementText,
                                fontSize: duSetFontSize(12)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }

  dealWithSubmitTime(DateTime? submitTime) {
    DateFormat formatter = DateFormat('yyyy-MM-dd');
    String formattedDateTime = "";
    if (submitTime != null) {
      formattedDateTime = formatter.format(widget.data.submitTime!);
    }
    return formattedDateTime;
  }

  calculateYearRate(Data? calculateData) {
    if (calculateData != null && calculateData.rate != "") {
      return (double.parse(calculateData.rate) * 12).toString() + "%";
    } else {
      return "";
    }
  }

  setApplicationStatusTitle(ClientDatum data) {
    if (data.status == 1) {
      //审核中
      return "借款审批中...请耐心等候";
    } else if (data.status == 2) {
      //审核通过
      return "恭喜您！您的借款审批通过";
    } else if (data.status == 3) {
      //审核拒绝
      return "额度审核未通过...";
    } else if (data.status == 4) {
      //补充资料
      return "补充资料...";
    }
  }

  setApplicationStatusContent(ClientDatum data) {
    if (data.status == 1) {
      //审核中
      return "您的申请已提交，预计1-2个工作日完成审批！";
    } else if (data.status == 2) {
      //审核通过
      return "您的借款申请人工审核已通过，请完成后续签约手续，然后放款！";
    } else if (data.status == 3) {
      //审核拒绝
      return "很遗憾，经过我们综合评估，你暂不符合条件，请下次再试！";
    } else if (data.status == 4) {
      //补充资料
      return "请补充材料，以便对您的情况更好的综合评估！";
    }
  }
}
