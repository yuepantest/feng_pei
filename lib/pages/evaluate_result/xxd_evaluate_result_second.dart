import 'package:dio/dio.dart';
import 'package:feng_pei/common/api/apis.dart';
import 'package:feng_pei/common/entity/entitys.dart';
import 'package:feng_pei/common/utils/screen.dart';
import 'package:feng_pei/common/utils/time_formation.dart';
import 'package:feng_pei/common/values/colors.dart';
import 'package:feng_pei/common/widgets/widgets.dart';
import 'package:flutter/material.dart';

import '../webview/webview.dart';

class JYDEvaluateResultSecond extends StatefulWidget {
  final ClientDatum data;

  const JYDEvaluateResultSecond({Key? key, required this.data})
      : super(key: key);

  @override
  _JYDEvaluateResultSecondState createState() =>
      _JYDEvaluateResultSecondState();
}

class _JYDEvaluateResultSecondState extends State<JYDEvaluateResultSecond> {
  Data? calculateData;
  String selectTime = "";
  String selectValue = "";
  String selectReason = "日常消费";

  Future<void> getListData(ClientDatum data) async {
    var formData = FormData.fromMap({
      'assessMoney': data.assessMoney,
      'bankId': data.bankId,
      'identityCard': data.identityCard,
      'clientId': data.id,
      'type': data.type,
    });
    CalculateDataEntity res = await UserAPI.getCalculateDate(params: formData);
    if (res.code == 1) {
      setState(() {
        calculateData = res.data;
        selectTime=calculateData!.titleFive;
        selectValue=calculateData!.contentFive;
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
    return Scaffold(
      appBar: transparentAppBar(
        color: AppColors.primaryBackground,
        title: Padding(
            padding: EdgeInsets.only(right: duSetWidth(40)),
            child: const Text(
              "薪享贷申请",
              style: TextStyle(
                  color: AppColors.primaryText, fontWeight: FontWeight.w600),
            )),
        context: context,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: AppColors.fourElement,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: <Widget>[],
      ),
      body: DecoratedBox(
        decoration: const BoxDecoration(
          color: AppColors.secondY,
        ),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                margin: EdgeInsets.only(
                    top: duSetHeight(15),
                    left: duSetWidth(15),
                    right: duSetWidth(15),
                    bottom: duSetHeight(15)),
                padding: EdgeInsets.only(
                    top: duSetHeight(15),
                    left: duSetWidth(15),
                    right: duSetWidth(15),
                    bottom: duSetHeight(10)),
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      AppColors.primaryBackground,
                      AppColors.primaryBackground
                    ],
                  ),
                  borderRadius: BorderRadius.circular(10.0), // 圆角半径
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "预授信额度（元）",
                      style: TextStyle(
                          fontSize: duSetFontSize(20),
                          fontWeight: FontWeight.w600),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: duSetHeight(10)),
                      child: Text(
                        data.assessMoney.toString(),
                        style: TextStyle(
                            color: AppColors.buttonStatueZero,
                            fontSize: duSetFontSize(30),
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                    top: duSetHeight(15),
                    left: duSetHeight(15),
                    right: duSetHeight(15),
                    bottom: duSetHeight(15)),
                padding: EdgeInsets.only(
                    top: duSetHeight(5),
                    left: duSetWidth(15),
                    right: duSetWidth(15),
                    bottom: duSetHeight(5)),
                height: duSetHeight(360),
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      AppColors.primaryBackground,
                      AppColors.primaryBackground
                    ],
                  ),
                  borderRadius: BorderRadius.circular(10.0), // 圆角半径
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "借款详情",
                      style: TextStyle(fontSize: duSetFontSize(14)),
                    ),
                    Divider(
                      color: AppColors.secondX,
                      thickness: duSetHeight(1),
                      height: duSetHeight(1),
                    ),
                    lineItemMore("选择分期", selectTime, () {
                      _showBottomSheet(context, calculateData);
                    }),
                    lineItem("每月还款", selectValue),
                    lineItem("还款方式", "每月等额本息"),
                    lineItem(
                        "还款账号",
                        calculateData == null
                            ? ""
                            : calculateData!.bankIdContent),
                    lineItem("申请日期", setTime(data.applyTime)),
                    lineItem(
                        "申请编号",
                        calculateData == null
                            ? ""
                            : calculateData!.applicationNumber),
                    lineItem("联系电话", data.phone),
                    lineItem(
                        "身份证号码",
                        calculateData == null
                            ? ""
                            : calculateData!.identityCardContent),
                    lineItemMore("资金用途", selectReason, () {
                      _showBottomReasonSheet(context);
                    }),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: duSetHeight(10), bottom: duSetHeight(30)),
                child: myButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => WebViewPage(data: data),
                      ),
                    );
                  },
                  height: duSetHeight(39),
                  width: duSetWidth(300),
                  cornerRadius: duSetWidth(50),
                  gbColor: AppColors.buttonStatueZero,
                  title: "下一步",
                  fontColor: AppColors.primaryBackground,
                  fontSize: duSetFontSize(16),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: Divider(
                      color: Colors.black26,
                      thickness: duSetHeight(2), // 控制分割线厚度
                      indent: duSetWidth(50), // 控制开始位置的偏移量
                      endIndent: duSetWidth(20), // 控制结束位置的偏移量
                    ),
                  ),
                  const Text("后续流程"),
                  Expanded(
                    child: Divider(
                      color: Colors.black26,
                      thickness: duSetHeight(2), // 控制分割线厚度
                      indent: duSetWidth(20), // 控制开始位置的偏移量
                      endIndent: duSetWidth(50), // 控制结束位置的偏移量
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: duSetWidth(25),
                    right: duSetWidth(25),
                    bottom: duSetHeight(50),
                    top: duSetHeight(15)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "1. 完善资料：请补充详细的工作信息，近三天开具的工作收入证明，联系人信息",
                      style: TextStyle(
                          color: AppColors.thirdElementText,
                          fontSize: duSetFontSize(12)),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: duSetHeight(15)),
                      child: Text(
                        "2. 审核：资料提交后两个工作日内会有审核人员受理审批，中途可能会致电本人、单位或联系人核实情况",
                        style: TextStyle(
                            color: AppColors.thirdElementText,
                            fontSize: duSetFontSize(12)),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: duSetHeight(15)),
                      child: Text(
                        "3. 签约：审核通过后通过线上/线下方式签订借款合同，确认放款信息",
                        style: TextStyle(
                            color: AppColors.thirdElementText,
                            fontSize: duSetFontSize(12)),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: duSetHeight(15)),
                      child: Text(
                        "4. 成功放款",
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
      ),
    );
  }

  void _showBottomSheet(BuildContext context, Data? data) {
    var daysOfWeek = <String>[];
    if (data?.titleOne != null && data?.titleOne != "") {
      daysOfWeek.add(data!.titleOne);
    }
    if (data?.titleTwo != null && data?.titleTwo != "") {
      daysOfWeek.add(data!.titleTwo);
    }
    if (data?.titleThree != null && data?.titleThree != "") {
      daysOfWeek.add(data!.titleThree);
    }
    if (data?.titleFour != null && data?.titleFour != "") {
      daysOfWeek.add(data!.titleFour);
    }
    if (data?.titleFive != null && data?.titleFive != "") {
      daysOfWeek.add(data!.titleFive);
    }
    bottomSheet(
        context: context,
        onChanged: (selectIndex) {
          if (selectIndex == 0) {
            setState(() {
              selectValue = data!.contentOne;
              selectTime = data.titleOne;
            });
          } else if (selectIndex == 1) {
            setState(() {
              selectValue = data!.contentTwo;
              selectTime = data.titleTwo;
            });
          } else if (selectIndex == 2) {
            setState(() {
              selectValue = data!.contentTree;
              selectTime = data.titleThree;
            });
          } else if (selectIndex == 3) {
            setState(() {
              selectValue = data!.contentFour;
              selectTime = data.titleFour;
            });
          } else if (selectIndex == 4) {
            setState(() {
              selectValue = data!.contentFive;
              selectTime = data.titleFive;
            });
          }
        },
        listWeek: daysOfWeek);
  }

  void _showBottomReasonSheet(BuildContext context) {
    var listReaseon = <String>[
      "日常消费",
      "家居家装",
      "旅游消费",
      "婚庆服务",
      "教育进修",
      "医疗服务",
      "购车消费",
      "其他消费"
    ];
    bottomSheet(
        context: context,
        onChanged: (selectIndex) {
          setState(() {
            selectReason = listReaseon[selectIndex];
          });
        },
        listWeek: listReaseon);
  }
}
