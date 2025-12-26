import 'package:dio/dio.dart';
import 'package:feng_pei/common/entity/entitys.dart';
import 'package:flutter/material.dart';

import '../../common/api/apis.dart';
import '../../common/utils/utils.dart';
import '../../common/values/values.dart';
import '../../common/widgets/widgets.dart';
import 'kxd_evaluate_result_second.dart';

class KXDEvaluateResult extends StatefulWidget {
  final ClientDatum data;

  const KXDEvaluateResult({Key? key, required this.data}) : super(key: key);

  @override
  _KXDEvaluateResultState createState() => _KXDEvaluateResultState();
}

class _KXDEvaluateResultState extends State<KXDEvaluateResult> {
  @override
  Widget build(BuildContext context) {
    var data = widget.data;
    return Scaffold(
      appBar: transparentAppBar(
        color: AppColors.primaryBackground,
        title: Padding(
            padding: EdgeInsets.only(right: duSetWidth(40)),
            child: const Text(
              "快享贷申请",
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
                      colors: [AppColors.buttonStatueKXD, AppColors.secondY],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start, // 水平方向靠左
                mainAxisAlignment: MainAxisAlignment.start, // 垂直方向靠上
                children: [
                  Padding(
                      padding: EdgeInsets.only(
                          left: duSetWidth(15), top: duSetWidth(30)),
                      child: Row(
                        children: [
                          Text(
                            data.clientName,
                            style: TextStyle(
                                color: AppColors.primaryText,
                                fontSize: duSetFontSize(duSetFontSize(20))),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: duSetWidth(10)),
                            child: Text(
                              "恭喜你，额度审批通过!",
                              style: TextStyle(
                                  color: AppColors.primaryBackground,
                                  fontSize: duSetFontSize(duSetFontSize(20))),
                            ),
                          ),
                        ],
                      )),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: AppColors.primaryBackground,
                        borderRadius: BorderRadius.circular(duSetWidth(10))),
                    margin: EdgeInsets.only(
                      top: duSetWidth(30),
                      left: duSetWidth(15),
                      right: duSetWidth(15),
                      bottom: duSetWidth(30),
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              top: duSetHeight(20), bottom: duSetHeight(8)),
                          child: const Text(
                            "预审额度(元)",
                          ),
                        ),
                        Text(
                          data.assessMoney.toString(),
                          style: TextStyle(
                              color: AppColors.primaryText,
                              fontSize: duSetFontSize(50)),
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
                                  dialogSheet(
                                      context: context,
                                      onCancel: () {},
                                      onConfirm: () {
                                        toastInfo(msg: '取消成功...');
                                        //reviseStatus(widget.data);
                                      });
                                },
                                gbColor: AppColors.transparency,
                                fontSize: duSetFontSize(15),
                                height: duSetHeight(38),
                                sideColor: Colors.grey.shade400,
                                title: "取消申请",
                                fontColor: AppColors.primaryText,
                                cornerRadius: duSetHeight(19),
                              ),
                              myButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          KXDEvaluateResultSecond(data: data),
                                    ),
                                  );
                                },
                                gbColor: AppColors.buttonStatueKXD,
                                fontSize: duSetFontSize(15),
                                height: duSetHeight(38),
                                title: "查看详情",
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
            Padding(
              padding: EdgeInsets.only(
                  left: duSetWidth(18),
                  top: duSetWidth(10),
                  bottom: duSetHeight(3)),
              child: const Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "额度不够？申请提额",
                    style: TextStyle(fontWeight: FontWeight.w600),
                  )
                ],
              ),
            ),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  color: AppColors.primaryBackground,
                  borderRadius: BorderRadius.circular(duSetWidth(5))),
              margin: EdgeInsets.only(
                top: duSetWidth(10),
                left: duSetWidth(10),
                right: duSetWidth(10),
                bottom: duSetWidth(10),
              ),
              padding: EdgeInsets.only(
                top: duSetWidth(10),
                left: duSetWidth(10),
                right: duSetWidth(10),
                bottom: duSetWidth(10),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image.asset(
                    "assets/images/money-rmb-fill.png",
                    fit: BoxFit.contain,
                    width: duSetWidth(35),
                    height: duSetHeight(35),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: duSetWidth(10)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "可提供资产及其他增信材料提升额度",
                          style: TextStyle(
                              color: AppColors.thirdElementText,
                              fontSize: duSetFontSize(12)),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: duSetHeight(5)),
                          child: Text(
                            "最高可以获得20万额度",
                            style: TextStyle(
                                color: AppColors.thirdElementText,
                                fontSize: duSetFontSize(12)),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: duSetWidth(12),
                  top: duSetHeight(5),
                  right: duSetWidth(12)),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    color: AppColors.tabCellSeparator,
                    borderRadius: BorderRadius.circular(duSetWidth(0))),
                padding: EdgeInsets.all(duSetWidth(8)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("你已经通过预审，",
                        style: TextStyle(color: AppColors.buttonStatueZero)),
                    GestureDetector(
                      onTap: () {
                        centerSheet(context: context);
                      },
                      child: const Text(
                        "查看办理流程>>",
                        style: TextStyle(color: AppColors.buttonStatueOne),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }

  Future<void> reviseStatus(ClientDatum data) async {
    toastInfo(msg: '正在取消请稍等...');
    var formData = FormData.fromMap({
      'clientId': data.id,
      'refuseReasonOne': "",
      'refuseReasonTwo': "",
    });
    CalculateDataEntity res =
        await UserAPI.modifyRefuseClientData(params: formData);
    if (res.code == 1) {
      Navigator.pop(context);
    } else {
      toastInfo(msg: '取消失败');
    }
  }
}
