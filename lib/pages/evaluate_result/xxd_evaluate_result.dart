import 'package:feng_pei/common/entity/entitys.dart';
import 'package:feng_pei/common/utils/screen.dart';
import 'package:feng_pei/common/values/colors.dart';
import 'package:feng_pei/common/widgets/widgets.dart';
import 'package:flutter/material.dart';

import 'xxd_evaluate_result_second.dart';

class XXDEvaluateResult extends StatefulWidget {
  final ClientDatum data;

  const XXDEvaluateResult({Key? key, required this.data}) : super(key: key);

  @override
  _XXDEvaluateResultState createState() => _XXDEvaluateResultState();
}

class _XXDEvaluateResultState extends State<XXDEvaluateResult> {
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
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(
                  top: duSetHeight(15),
                  left: duSetHeight(15),
                  right: duSetHeight(15)),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    AppColors.shapeJYDBannerBackgroundStart,
                    AppColors.shapeJYDBannerBackgroundEnd
                  ], // 渐变颜色
                ),
                borderRadius: BorderRadius.circular(10.0), // 圆角半径
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(
                          top: duSetHeight(10),
                          left: duSetWidth(10),
                        ),
                        child: const Text("薪享贷-消费贷"),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            top: duSetHeight(10), left: duSetHeight(5)),
                        height: duSetHeight(20),
                        width: duSetWidth(46),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14.0),
                          border: Border.all(
                            color: AppColors.buttonStatueZero, // 边框颜色
                            width: 1, // 边框宽度
                          ),
                        ),
                        child: Center(
                          // 水平和垂直居中
                          child: Text(
                            "信用贷",
                            style: TextStyle(
                                color: AppColors.buttonStatueZero,
                                fontWeight: FontWeight.w600,
                                fontSize: duSetFontSize(10)),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: duSetHeight(10),
                        left: duSetWidth(10),
                        right: duSetWidth(10)),
                    child: const Divider(
                      height: 1.0, // 分割线的高度
                      thickness: 1.0, // 分割线的厚度
                      color: AppColors.secondaryElement, // 分割线的颜色
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: duSetHeight(15), left: duSetWidth(10)),
                    child: Row(
                      children: [
                        Text(
                          data.clientName,
                          style: TextStyle(
                              color: AppColors.buttonStatueZero,
                              fontWeight: FontWeight.w600,
                              fontSize: duSetFontSize(18)),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: duSetWidth(6)),
                          child: const Text("恭喜你通过预审"),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: duSetHeight(10), left: duSetWidth(10)),
                    child: const Row(
                      children: [
                        Text(
                          "最高可借（元）",
                          textAlign: TextAlign.left,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: duSetHeight(10), left: duSetWidth(10)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          data.assessMoney.toString(),
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: duSetFontSize(36)),
                        ),
                        const Spacer(),
                        Container(
                          margin: EdgeInsets.only(right: duSetWidth(12)),
                          child: Padding(
                            padding: EdgeInsets.only(
                              left: duSetWidth(10),
                            ),
                            child: myButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          JYDEvaluateResultSecond(data: data),
                                    ),
                                  );
                                },
                                gbColor: AppColors.buttonStatueZero,
                                fontSize: duSetFontSize(14),
                                height: duSetHeight(30),
                                title: "查看详细",
                                fontColor: AppColors.primaryBackground,
                                cornerRadius: duSetWidth(18)),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: duSetHeight(10), left: duSetWidth(10)),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                right: duSetWidth(60),
                              ),
                              child: const Text("总额度"),
                            ),
                            const Text("3000000"),
                          ],
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                top: duSetHeight(5),
                                right: duSetWidth(10),
                              ),
                              child: const Text("月利率（单利）"),
                            ),
                            const Text("0.8%"),
                          ],
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: duSetHeight(10),
                        left: duSetWidth(10),
                        bottom: duSetHeight(10)),
                    child: Row(
                      children: <Widget>[
                        Container(
                          height: duSetHeight(22),
                          padding: EdgeInsets.only(
                              left: duSetWidth(6), right: duSetWidth(6)),
                          decoration: BoxDecoration(
                            color: AppColors.secondaryElement, // 背景颜色
                            borderRadius: BorderRadius.circular(14.0), // 圆角半径
                          ),
                          child: Center(
                            child: Text(
                              "借款一万日利息低至2.66元",
                              style: TextStyle(
                                  color: AppColors.buttonStatueZero,
                                  fontSize: duSetFontSize(10)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding:
                  EdgeInsets.only(top: duSetHeight(15), left: duSetWidth(20)),
              child: Row(
                children: [
                  Text(
                    "产品优势",
                    style: TextStyle(
                        fontSize: duSetFontSize(20),
                        fontWeight: FontWeight.w600),
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
              height: duSetHeight(112),
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
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            top: duSetHeight(10),
                            left: duSetWidth(10),
                            right: duSetWidth(0),
                            bottom: duSetHeight(0)),
                        child: Row(
                          children: [
                            Image.asset(
                              "assets/images/jyd_evaluate_result_one.png",
                              fit: BoxFit.contain,
                              width: duSetWidth(30),
                              height: duSetHeight(30),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(
                                      top: duSetHeight(5),
                                      left: duSetWidth(10)),
                                  child: Text(
                                    "超长期限",
                                    style: TextStyle(
                                        fontSize: duSetFontSize(14),
                                        color: AppColors.buttonStatueZero,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      top: duSetHeight(5),
                                      left: duSetWidth(10)),
                                  child: Text(
                                    "最长可分60期，慢慢还",
                                    style: TextStyle(
                                        fontSize: duSetFontSize(10),
                                        color: AppColors.thirdElementText),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      Padding(
                        padding: EdgeInsets.only(
                            top: duSetHeight(6),
                            left: duSetWidth(0),
                            right: duSetWidth(50),
                            bottom: duSetHeight(0)),
                        child: Row(
                          children: [
                            Image.asset(
                              "assets/images/jyd_evaluate_result_three.png",
                              fit: BoxFit.contain,
                              width: duSetWidth(30),
                              height: duSetHeight(30),
                            ),
                            Column(
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(
                                      top: duSetHeight(0), left: duSetWidth(5)),
                                  child: Text(
                                    "急速审批",
                                    style: TextStyle(
                                        fontSize: duSetFontSize(14),
                                        color: AppColors.buttonStatueZero,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            top: duSetHeight(10),
                            left: duSetWidth(8),
                            right: duSetWidth(0),
                            bottom: duSetHeight(0)),
                        child: Row(
                          children: [
                            Image.asset(
                              "assets/images/jyd_evaluate_result_two.png",
                              fit: BoxFit.contain,
                              width: duSetWidth(35),
                              height: duSetHeight(35),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(
                                      top: duSetHeight(5), left: duSetWidth(6)),
                                  child: Text(
                                    "用款灵活",
                                    style: TextStyle(
                                        fontSize: duSetFontSize(14),
                                        color: AppColors.buttonStatueZero,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      top: duSetHeight(5), left: duSetWidth(6)),
                                  child: Text(
                                    "支持全额或者部分提前还款",
                                    style: TextStyle(
                                        fontSize: duSetFontSize(10),
                                        color: AppColors.thirdElementText),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      Padding(
                        padding: EdgeInsets.only(
                            top: duSetHeight(10),
                            left: duSetWidth(0),
                            right: duSetWidth(50),
                            bottom: duSetHeight(0)),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.asset(
                              "assets/images/jyd_evaluate_result_four.png",
                              fit: BoxFit.contain,
                              width: duSetWidth(36),
                              height: duSetHeight(36),
                            ),
                            Column(
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(
                                      top: duSetHeight(8), left: duSetWidth(2)),
                                  child: Text(
                                    "安全保障",
                                    style: TextStyle(
                                        fontSize: duSetFontSize(14),
                                        color: AppColors.buttonStatueZero,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding:
                  EdgeInsets.only(left: duSetWidth(35), right: duSetWidth(35)),
              child: Center(
                child: Text(
                  "提示信息：借款有风险，请根据自己情况合理选择，量入为出，理性借贷。借款资金仅用于个人消费，不得用于投资、归还其他贷款，严禁流入房市、股市，或者从事非法活动。",
                  style: TextStyle(
                      color: AppColors.thirdElementText,
                      fontSize: duSetFontSize(10)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
