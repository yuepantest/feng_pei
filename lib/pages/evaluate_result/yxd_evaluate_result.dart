import 'package:feng_pei/common/entity/entitys.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:liquid_progress_indicator_v2/liquid_progress_indicator.dart';
import '../../common/utils/utils.dart';
import '../../common/values/values.dart';
import '../../common/widgets/widgets.dart';
import 'yxd_evaluate_result_second.dart';

class YXDEvaluateResult extends StatefulWidget {
  final ClientDatum data;

  const YXDEvaluateResult({Key? key, required this.data}) : super(key: key);

  @override
  _YXDEvaluateResultState createState() => _YXDEvaluateResultState();
}

class _YXDEvaluateResultState extends State<YXDEvaluateResult> {
  @override
  Widget build(BuildContext context) {
    var data = widget.data;
    return Scaffold(
      appBar: transparentAppBar(
        color: AppColors.primaryBackground,
        title: Padding(
            padding: EdgeInsets.only(right: duSetWidth(40)),
            child: const Text(
              "优享贷申请",
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
              Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                        'assets/images/yxd_background.jpg'), // 背景图片路径
                    fit: BoxFit.fill, // 调整图片以覆盖整个容器，保持图片比例
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center, // 水平方向靠左
                  mainAxisAlignment: MainAxisAlignment.center, // 垂直方向靠上
                  children: [
                    Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: duSetHeight(28)),
                          child: SizedBox(
                            child: LiquidCircularProgressIndicator(
                                value: setMoneyRate(data),
                                // 填充值 0.0~1.0
                                valueColor: const AlwaysStoppedAnimation(
                                    AppColors.yxdContent),
                                // 波浪颜色
                                backgroundColor: AppColors.yxdBlack,
                                borderColor: AppColors.yxdCycle,
                                borderWidth: duSetWidth(15),
                                center: Center(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        setMoney(data),
                                        style: TextStyle(
                                          color: AppColors.primaryBackground,
                                          fontSize: duSetFontSize(30),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        "当前可借（元）",
                                        style: TextStyle(
                                          color: AppColors.primaryBackground,
                                          fontSize: duSetFontSize(12),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                )),
                            width: duSetWidth(200),
                            height: duSetWidth(200),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: duSetHeight(28)),
                          child: Text(
                            "预授信：" + setMoney(data) + "元",
                            style: TextStyle(
                                color: AppColors.primaryBackground,
                                fontSize: duSetFontSize(20)),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: duSetHeight(8), bottom: duSetHeight(80)),
                          child: Text(
                            "有效期至：" + setTimeData(data.applyTime) + "（可循环使用）",
                            style: TextStyle(
                                color: AppColors.primaryBackground,
                                fontSize: duSetFontSize(12)),
                          ),
                        )
                        //   DateFormat formatter = DateFormat('yyyy-MM-dd HH:mm');
                        // String formattedDateTime = formatter.format(data.applyTime);
                      ],
                    ),
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
                      "温馨提示:",
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
                  top: duSetWidth(5),
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
                child: Padding(
                  padding: EdgeInsets.only(left: duSetWidth(10)),
                  child: Text(
                    "您的额度审批已通过，请三个工作日内进行确认并补充进件材料，超过三日未确认需要重新进行额度测算。放款结果以最终审批为准。",
                    style: TextStyle(
                        color: AppColors.thirdElementText,
                        fontSize: duSetFontSize(12)),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: duSetHeight(15)),
                child: myButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            YXDEvaluateResultSecond(data: data),
                      ),
                    );
                  },
                  height: duSetHeight(39),
                  width: duSetWidth(300),
                  cornerRadius: duSetWidth(50),
                  gbColor: AppColors.yxdBackgroundEnd,
                  title: "开始借款",
                  fontColor: AppColors.primaryBackground,
                  fontSize: duSetFontSize(16),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: duSetHeight(15)),
                child: Text(
                  "进度查询  | 资质测算 | 认证限额",
                  style: TextStyle(
                      fontSize: duSetFontSize(15),
                      color: AppColors.yxdBelowButtonColor),
                ),
              )
            ]),
          ),
        ),
      ),
    );
  }
}

setMoney(ClientDatum date) {
  return formatNumber(date.assessMoney).toString();
}

setMoneyRate(ClientDatum date) {
  return date.assessMoney / 300000;
}

setTimeData(DateTime applyTime) {
  DateTime futureDate = applyTime.add(const Duration(days: 3 * 365));
  DateFormat formatter = DateFormat('yyyy-MM-dd');
  return formatter.format(futureDate);
}
