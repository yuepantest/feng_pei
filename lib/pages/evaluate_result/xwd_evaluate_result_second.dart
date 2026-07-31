import 'package:dio/dio.dart';
import 'package:feng_pei/common/entity/entitys.dart';
import 'package:flutter/material.dart';
import '../../common/api/apis.dart';
import '../../common/utils/utils.dart';
import '../../common/values/values.dart';
import '../../common/widgets/widgets.dart';
import '../webview/webview.dart';

class XwDEvaluateResultSecond extends StatefulWidget {
  final ClientDatum data;

  const XwDEvaluateResultSecond({Key? key, required this.data})
      : super(key: key);

  @override
  _XWDEvaluateResultSecondState createState() =>
      _XWDEvaluateResultSecondState();
}

class _XWDEvaluateResultSecondState extends State<XwDEvaluateResultSecond> {
  String selectReason = "个人消费";
  Data? calculateData;
  String repayType = "";
  var money = 0.00;
  var rate = 1.00;
  var maxMoney = 0.00;

  Future<void> getListData(ClientDatum data) async {
    var formData = FormData.fromMap({
      'clientId': data.id,
    });
    CalculateDataEntity res = await UserAPI.getCalculateDate(params: formData);
    if (res.code == 1) {
      setState(() {
        calculateData = res.data;
        repayType = calculateData == null ? "" : calculateData!.titleOne;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    maxMoney = widget.data.assessMoney.toDouble();
    money = widget.data.assessMoney.toDouble();
    getListData(widget.data);
  }

  @override
  Widget build(BuildContext context) {
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
          decoration: const BoxDecoration(color: AppColors.secondY),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      top: duSetHeight(15),
                      bottom: duSetHeight(5),
                      left: duSetHeight(10)),
                  child: Text(
                    "借多少",
                    style: TextStyle(
                        color: AppColors.fourElement,
                        fontSize: duSetFontSize(14)),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.primaryBackground,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(top: duSetWidth(10)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: duSetWidth(10)),
                          child: Row(
                            children: [
                              Image.asset(
                                "assets/images/rmb.png",
                                width: duSetWidth(30),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: duSetWidth(10)),
                                child: Text(
                                  formatNumber(money).toString(),
                                  style: TextStyle(
                                    fontSize: duSetFontSize(36),
                                    color: AppColors.primaryText,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: duSetWidth(10)),
                                child: GestureDetector(
                                  onTap: () {
                                    dialogInput(
                                      context: context,
                                      contentHint: "当前可借20000~" +
                                          widget.data.assessMoney.toString(),
                                      maxMoneyCont: widget.data.assessMoney,
                                      onCancel: () {},
                                      onConfirm: (value) {
                                        setState(() {
                                          money = value.toDouble();
                                          rate = money / maxMoney;
                                        });
                                      },
                                    );
                                  },
                                  child: Image.asset(
                                    "assets/images/xwkd_fix.png",
                                    width: duSetWidth(30),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: duSetWidth(15),
                              top: duSetHeight(0),
                              bottom: duSetHeight(15)),
                          child: Text.rich(
                            TextSpan(
                              style: TextStyle(
                                  fontSize: duSetFontSize(12),
                                  color: AppColors.thirdElement),
                              children: [
                                const TextSpan(
                                    text: '最高可申请额度 ',
                                    style: TextStyle(
                                        color: AppColors.thirdElementText)),
                                // 黑色
                                TextSpan(
                                  text: formatNumber(widget.data.assessMoney)
                                      .toString(),
                                  style: const TextStyle(
                                      color: AppColors.yxdBelowButtonColor),
                                ),
                                // 红色
                                const TextSpan(
                                    text: ' 元。 按日计息，随借随还',
                                    style: TextStyle(
                                        color: AppColors.thirdElementText)),
                                // 黑色
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: duSetHeight(10)),
                  decoration: BoxDecoration(
                    color: AppColors.primaryBackground,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(
                        top: duSetHeight(5), bottom: duSetHeight(5)),
                    child: Column(
                      children: [
                        itemViewBigLine(
                            title: "还款方案",
                            contentOne: repayType,
                            isShowTop: false,
                            isMore: true,
                            onPressed: () {
                              _showBottomRepayStyleSheet(context);
                            }),
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: duSetHeight(10)),
                  decoration: BoxDecoration(
                    color: AppColors.primaryBackground,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(
                        top: duSetHeight(0), bottom: duSetHeight(0)),
                    child: Column(
                      children: [
                        itemView(
                            title: "年化利率（单利）",
                            content: calculateYearRate(calculateData),
                            isShowTop: true),
                        itemViewTwoLine(
                          title: "还款计划",
                          contentOne: "每月10日",
                          contentTwo: "应还¥" +
                              (calculateData == null
                                  ? ""
                                  : calculateRepayMoney(
                                      rate, repayType, calculateData!)),
                          isShowTop: true,
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: duSetHeight(10)),
                  decoration: BoxDecoration(
                    color: AppColors.primaryBackground,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(
                        top: duSetHeight(0), bottom: duSetHeight(5)),
                    child: Column(
                      children: [
                        itemView(
                            title: "还款账户",
                            content: calculateData == null
                                ? ""
                                : calculateData!.bankIdContent,
                            isShowTop: true),
                        itemView(
                            title: "资金用途",
                            content: selectReason,
                            isShowTop: true,
                            isMore: true,
                            onPressed: () {
                              _showBottomReasonSheet(context);
                            }),
                        itemView(
                            title: "申请编号",
                            content: calculateData == null
                                ? ""
                                : calculateData!.applicationNumber,
                            isShowTop: true),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      bottom: duSetHeight(40), top: duSetHeight(50)),
                  child: Align(
                    alignment: Alignment.center,
                    child: myButton(
                      onPressed: () {
                        dialogSheetContent(
                            content: "姓名：" +
                                widget.data.clientName +
                                "\n贷款金额：" +
                                money.toInt().toString() +
                                "\n借款期限：" +
                                "\n还款方式：" +
                                "\n月还款：" +
                                (calculateData == null
                                    ? ""
                                    : calculateRepayMoney(
                                        rate, repayType, calculateData!)) +
                                "\n收/还款账号：" +
                                (calculateData == null
                                    ? ""
                                    : calculateData!.bankIdContent),
                            title: "请确认",
                            context: context,
                            onCancel: () {},
                            onConfirm: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      WebViewPage(data: widget.data),
                                ),
                              );
                            });
                      },
                      height: duSetHeight(39),
                      width: duSetWidth(300),
                      cornerRadius: duSetWidth(50),
                      gbColor: AppColors.xwdColorTheme,
                      title: "下一步",
                      fontColor: AppColors.primaryBackground,
                      fontSize: duSetFontSize(16),
                    ),
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
                    const Text("办理流程"),
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
                        "1. 客户资信评估/额度测算",
                        style: TextStyle(
                            color: AppColors.thirdElementText,
                            fontSize: duSetFontSize(12)),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: duSetHeight(15)),
                        child: Text(
                          "2. 准备申请资料",
                          style: TextStyle(
                              color: AppColors.thirdElementText,
                              fontSize: duSetFontSize(12)),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: duSetHeight(15)),
                        child: Text(
                          "3. 审核",
                          style: TextStyle(
                              color: AppColors.thirdElementText,
                              fontSize: duSetFontSize(12)),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: duSetHeight(15)),
                        child: Text(
                          "4. 签约",
                          style: TextStyle(
                              color: AppColors.thirdElementText,
                              fontSize: duSetFontSize(12)),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: duSetHeight(15)),
                        child: Text(
                          "5. 成功放款",
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
      ),
    );
  }

  Widget itemViewBigLine(
      {required String title,
      required String contentOne,
      bool? isShowTop,
      bool? isMore,
      VoidCallback? onPressed}) {
    Color colorTop = AppColors.primaryBackground;
    if (isShowTop != null && isShowTop == true) {
      colorTop = AppColors.secondaryElement;
    }
    String icon = "";
    if (isMore != null && isMore == true) {
      icon = "assets/images/more.png";
    }
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        if (onPressed != null) {
          onPressed();
        }
      },
      child: Container(
        color: AppColors.primaryBackground,
        height: duSetHeight(50),
        child: Column(
          children: [
            Divider(
              height: 1.0, // 分割线的高度
              thickness: 1.0, // 分割线的厚度
              color: colorTop, // 分割线的颜色
            ),
            Container(
              margin: EdgeInsets.only(
                  top: duSetHeight(4),
                  left: duSetHeight(10),
                  right: duSetHeight(10)),
              child: Row(
                children: [
                  Padding(
                      padding: EdgeInsets.only(left: duSetWidth(5)),
                      child: SizedBox(
                        width: duSetWidth(150),
                        child: Text(
                          title,
                          style: TextStyle(
                            fontWeight: FontWeight.w300,
                            color: AppColors.thirdElementText,
                            fontSize: duSetFontSize(13),
                          ),
                        ),
                      )),
                  Padding(
                      padding: EdgeInsets.only(left: duSetWidth(0)),
                      child: Column(
                        children: [
                          Text(
                            contentOne,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontWeight: FontWeight.w300,
                              color: AppColors.primaryText,
                              fontSize: duSetFontSize(12),
                            ),
                          ),
                        ],
                      )),
                  const Spacer(),
                  if (icon != "")
                    Image.asset(
                      icon,
                      width: duSetWidth(20),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget itemViewTwoLine(
      {required String title,
      required String contentOne,
      required String contentTwo,
      bool? isShowTop,
      bool? isMore,
      VoidCallback? onPressed}) {
    Color colorTop = AppColors.primaryBackground;
    if (isShowTop != null && isShowTop == true) {
      colorTop = AppColors.secondaryElement;
    }
    String icon = "";
    if (isMore != null && isMore == true) {
      icon = "assets/images/more.png";
    }
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        if (onPressed != null) {
          onPressed();
        }
      },
      child: Container(
        color: AppColors.primaryBackground,
        height: duSetHeight(50),
        child: Column(
          children: [
            Divider(
              height: 1.0, // 分割线的高度
              thickness: 1.0, // 分割线的厚度
              color: colorTop, // 分割线的颜色
            ),
            Container(
              margin: EdgeInsets.only(
                  top: duSetHeight(4),
                  left: duSetHeight(10),
                  right: duSetHeight(10)),
              child: Row(
                children: [
                  Padding(
                      padding: EdgeInsets.only(left: duSetWidth(5)),
                      child: SizedBox(
                        width: duSetWidth(150),
                        child: Text(
                          title,
                          style: TextStyle(
                            fontWeight: FontWeight.w300,
                            color: AppColors.thirdElementText,
                            fontSize: duSetFontSize(13),
                          ),
                        ),
                      )),
                  Padding(
                      padding: EdgeInsets.only(left: duSetWidth(0)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            contentOne,
                            style: TextStyle(
                              fontWeight: FontWeight.w300,
                              color: AppColors.primaryText,
                              fontSize: duSetFontSize(12),
                            ),
                          ),
                          Text(
                            contentTwo,
                            style: TextStyle(
                              fontWeight: FontWeight.w300,
                              color: AppColors.primaryText,
                              fontSize: duSetFontSize(12),
                            ),
                          ),
                        ],
                      )),
                  const Spacer(),
                  if (icon != "")
                    Image.asset(
                      icon,
                      width: duSetWidth(20),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget itemView(
      {required String title,
      required String content,
      bool? isShowTop,
      bool? isMore,
      VoidCallback? onPressed}) {
    Color colorTop = AppColors.primaryBackground;
    if (isShowTop != null && isShowTop == true) {
      colorTop = AppColors.secondaryElement;
    }
    String icon = "";
    if (isMore != null && isMore == true) {
      icon = "assets/images/more.png";
    }
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        if (onPressed != null) {
          onPressed();
        }
      },
      child: Container(
        color: AppColors.primaryBackground,
        height: duSetHeight(42),
        child: Column(
          children: [
            Divider(
              height: 1.0, // 分割线的高度
              thickness: 1.0, // 分割线的厚度
              color: colorTop, // 分割线的颜色
            ),
            Container(
              margin: EdgeInsets.only(
                  top: duSetHeight(10),
                  left: duSetHeight(10),
                  right: duSetHeight(10)),
              child: Row(
                children: [
                  Padding(
                      padding: EdgeInsets.only(left: duSetWidth(5)),
                      child: SizedBox(
                        width: duSetWidth(150),
                        child: Text(
                          title,
                          style: TextStyle(
                            fontWeight: FontWeight.w300,
                            color: AppColors.thirdElementText,
                            fontSize: duSetFontSize(13),
                          ),
                        ),
                      )),
                  Padding(
                    padding: EdgeInsets.only(left: duSetWidth(0)),
                    child: Text(
                      content,
                      style: TextStyle(
                        fontWeight: FontWeight.w300,
                        color: AppColors.primaryText,
                        fontSize: duSetFontSize(13),
                      ),
                    ),
                  ),
                  const Spacer(),
                  if (icon != "")
                    Image.asset(
                      icon,
                      width: duSetWidth(20),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget itemViewBottom(
      {required String title,
      required String content,
      required String bottomText,
      bool? isShowTop,
      bool? isMore,
      VoidCallback? onPressed}) {
    Color colorTop = AppColors.primaryBackground;
    if (isShowTop != null && isShowTop == true) {
      colorTop = AppColors.secondaryElement;
    }
    String icon = "";
    if (isMore != null && isMore == true) {
      icon = "assets/images/more.png";
    }
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        if (onPressed != null) {
          onPressed();
        }
      },
      child: Container(
        color: AppColors.primaryBackground,
        height: duSetHeight(42),
        child: Column(
          children: [
            Divider(
              height: 1.0, // 分割线的高度
              thickness: 1.0, // 分割线的厚度
              color: colorTop, // 分割线的颜色
            ),
            Container(
              margin: EdgeInsets.only(
                  top: duSetHeight(5),
                  left: duSetHeight(10),
                  right: duSetHeight(10)),
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: duSetWidth(5)),
                    child: Text(
                      title,
                      style: TextStyle(
                        fontWeight: FontWeight.w300,
                        color: AppColors.thirdElementText,
                        fontSize: duSetFontSize(13),
                      ),
                    ),
                  ),
                  const Spacer(),
                  Padding(
                    padding: EdgeInsets.only(
                      right: duSetWidth(10),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(right: duSetWidth(0)),
                          child: Text(
                            content,
                            style: TextStyle(
                              fontWeight: FontWeight.w300,
                              color: AppColors.primaryText,
                              fontSize: duSetFontSize(13),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: duSetWidth(0)),
                          child: Text(
                            bottomText,
                            style: TextStyle(
                              fontWeight: FontWeight.w300,
                              fontFamily: "Montserrat",
                              color: AppColors.smallTextYellow,
                              fontSize: duSetFontSize(8),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (icon != "")
                    Image.asset(
                      icon,
                      width: duSetWidth(20),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showBottomRepayStyleSheet(BuildContext context) {
    var listReaseon = <String>[
      calculateData == null ? "" : calculateData!.titleOne,
      calculateData == null ? "" : calculateData!.titleTwo,
    ];
    bottomSheet(
        context: context,
        initialIndex: 0,
        onChanged: (selectIndex) {
          setState(() {
            repayType = listReaseon[selectIndex];
          });
        },
        listWeek: listReaseon);
  }

  calculateRepayMoney(double rate, String type, Data calculateData) {
    if (type == calculateData.titleOne) {
      return (double.parse(calculateData.contentOne) * rate).toStringAsFixed(2);
    } else if (type == calculateData.titleTwo) {
      return (double.parse(calculateData.contentTwo) * rate).toStringAsFixed(2);
    }
  }

  calculateYearRate(Data? calculateDat) {
    if (calculateDat != null && calculateDat.rate != "") {
      return (double.parse(calculateDat.rate) * 12).toStringAsFixed(2) + "%";
    } else {
      return "";
    }
  }

  calculateDayRate(Data? calculateDat) {
    if (calculateDat != null && calculateDat.rate != "") {
      return ((100 * double.parse(calculateDat.rate)) / 30).toStringAsFixed(2);
    } else {
      return "";
    }
  }

  void _showBottomReasonSheet(BuildContext context) {
    var listReaseon = <String>[
      "个人消费",
      "生产经营",
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
