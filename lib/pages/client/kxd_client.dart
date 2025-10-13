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

class KXDClient extends StatefulWidget {
  final ClientDatum data;

  const KXDClient({Key? key, required this.data}) : super(key: key);

  @override
  _KXDClientState createState() => _KXDClientState();
}

class _KXDClientState extends State<KXDClient> {
  Data? calculateData;
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
        color: AppColors.buttonStatueThree,
        title: Padding(
            padding: EdgeInsets.only(right: duSetWidth(40)),
            child: const Text(
              "审核结果",
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
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: DecoratedBox(
          decoration: const BoxDecoration(color: AppColors.secondY),
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(
                        top: duSetHeight(15),
                        left: duSetHeight(15),
                        right: duSetHeight(15),
                        bottom: duSetHeight(0)),
                    padding: EdgeInsets.only(
                        top: duSetHeight(5),
                        left: duSetWidth(15),
                        right: duSetWidth(15),
                        bottom: duSetHeight(5)),
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
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              top: duSetHeight(15), bottom: duSetHeight(10)),
                          child: Text(
                            calculateData == null
                                ? "借款信息"
                                : "借款信息",
                            style: TextStyle(fontSize: duSetFontSize(14)),
                          ),
                        ),
                        Divider(
                          color: AppColors.secondX,
                          thickness: duSetHeight(1),
                          height: duSetHeight(1),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            top: duSetHeight(10),
                          ),
                          child: lineItem("申请人", data.clientName),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: duSetHeight(10),),
                          child: lineItem(
                            "申请编号",
                            calculateData == null
                                ? "暂无"
                                : calculateData!.applicationNumber.toString(),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            top: duSetHeight(10),
                          ),
                          child: lineItem("借款金额", data.assessMoney.toString()),
                        ),
                        // Padding(
                        //   padding: EdgeInsets.only(
                        //     top: duSetHeight(10),
                        //   ),
                        //   child: lineItem("借款月利",   calculateData == null
                        //       ? "暂无"
                        //       : calculateData!.rate.toString()),
                        // ),
                        Padding(
                          padding: EdgeInsets.only(
                            top: duSetHeight(10),
                          ),
                          child: lineItem("受理时间", formattedDateTime),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            top: duSetHeight(10),
                          ),
                          child: lineItem("还款方式", "等本等息"),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: duSetWidth(0),
                              top: duSetHeight(8),
                              bottom: duSetHeight(8),
                              right: duSetWidth(12)),
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: AppColors.tabCellSeparator,
                                borderRadius:
                                    BorderRadius.circular(duSetWidth(0))),
                            padding: EdgeInsets.all(duSetWidth(3)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text("你的借款正在办理中，",
                                    style: TextStyle(
                                        color: AppColors.buttonStatueZero)),
                                GestureDetector(
                                  onTap: () {
                                    centerSheet(context: context);
                                  },
                                  child: const Text(
                                    "查看办理流程>>",
                                    style: TextStyle(
                                        color: AppColors.buttonStatueOne),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              Positioned(
                top: duSetHeight(80),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Image.asset(
                      _checkStatus(data),
                      fit: BoxFit.contain,
                      width: duSetWidth(100),
                      height: duSetHeight(100),
                    ),
                    Transform.rotate(
                        angle: -25 * math.pi / 180, // 45度转弧度
                        child: Text(
                          "",
                          style: TextStyle(
                              color: AppColors.fourElement,
                              fontSize: duSetFontSize(15)),
                        )),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _checkStatus(ClientDatum? data) {
    if (data?.status == 1) {
      return "assets/images/sign_shz.png";
    } else if (data?.status == 2) {
      return "assets/images/sign_shtg.png";
    } else if (data?.status == 3) {
      return "assets/images/sign_shjj.png";
    } else {
      return "assets/images/sign_bczl.png";
    }
  }
}
