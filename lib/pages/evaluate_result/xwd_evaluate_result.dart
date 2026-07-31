import 'package:feng_pei/common/entity/entitys.dart';
import 'package:feng_pei/pages/evaluate_result/xwd_evaluate_result_second.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:liquid_progress_indicator_v2/liquid_progress_indicator.dart';
import '../../common/utils/utils.dart';
import '../../common/values/values.dart';
import '../../common/widgets/widgets.dart';
import 'yxd_evaluate_result_second.dart';

class XWDEvaluateResult extends StatefulWidget {
  final ClientDatum data;

  const XWDEvaluateResult({Key? key, required this.data}) : super(key: key);

  @override
  _XWDEvaluateResultState createState() => _XWDEvaluateResultState();
}

class _XWDEvaluateResultState extends State<XWDEvaluateResult> {
  @override
  Widget build(BuildContext context) {
    var data = widget.data;
    return Scaffold(
      appBar: transparentAppBar(
        color: AppColors.primaryBackground,
        title: Padding(
            padding: EdgeInsets.only(right: duSetWidth(40)),
            child: const Text(
              "小微快贷申请",
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
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(children: [
              Padding(
                padding: EdgeInsets.only(top: duSetHeight(50)),
                child: Image.asset(
                  "assets/images/correct.png",
                  fit: BoxFit.contain,
                  width: duSetWidth(60),
                  height: duSetHeight(60),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: duSetHeight(20),
                    left: duSetWidth(15),
                    right: duSetWidth(15)),
                child: Text(
                  "测算成功",
                  style: GoogleFonts.zenMaruGothic(
                      fontSize: duSetFontSize(20),
                      color: AppColors.primaryText),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: duSetHeight(20),
                    left: duSetWidth(35),
                    right: duSetWidth(35)),
                child: Text.rich(
                  TextSpan(
                    style: TextStyle(
                        fontSize: duSetFontSize(12),
                        color: AppColors.thirdElement),
                    children: [
                      TextSpan(
                        text: " "+data.clientName,
                        style: GoogleFonts.ibmPlexSans(
                          fontSize: duSetFontSize(16),
                          color: AppColors.primaryText,
                        ),
                      ),
                      // 黑色  您的申请已收到
                      TextSpan(
                        text: "，已为您测算并已获得个人信用借款，预计额度为" +
                            data.assessMoney.toString() +
                            "，年化利率（单利）5.88%.请三个工作日内准备好材料，联系客户经理进件。最终结果以实际审批为准。",
                        style: GoogleFonts.ibmPlexSans(
                            fontSize: duSetFontSize(14),
                            color: AppColors.thirdElementText),

                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: duSetHeight(30), bottom: duSetHeight(15)),
                child: Column(
                  // 垂直方向靠上
                  children: [
                    myButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                XwDEvaluateResultSecond(data: data),
                          ),
                        );
                      },
                      gbColor: AppColors.xwdColorTheme,
                      fontSize: duSetFontSize(15),
                      height: duSetHeight(50),
                      width: duSetWidth(300),
                      title: "马上去借",
                      fontColor: AppColors.primaryBackground,
                      cornerRadius: duSetHeight(10),
                    ),
                    Padding(
                      padding: EdgeInsetsGeometry.only(top: duSetHeight(10)),
                      child: myButton(
                        onPressed: () {
                          dialogSheet(
                              context: context,
                              onCancel: () {},
                              onConfirm: () {
                                toastInfo(msg: '撤销您的申请成功...');
                              });
                        },
                        gbColor: AppColors.tabCellSeparator,
                        fontSize: duSetFontSize(15),
                        height: duSetHeight(50),
                        width: duSetWidth(300),
                        sideColor: AppColors.primaryText,
                        title: "撤销申请",
                        fontColor: AppColors.primaryText,
                        cornerRadius: duSetHeight(10),
                      ),
                    ),
                  ],
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
