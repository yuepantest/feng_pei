import 'package:dio/dio.dart';
import 'package:feng_pei/common/entity/entitys.dart';
import 'package:flutter/material.dart';
import '../../common/api/apis.dart';
import '../../common/utils/utils.dart';
import '../../common/values/values.dart';
import '../../common/widgets/widgets.dart';
import '../webview/webview.dart';

class YXDEvaluateResultSecond extends StatefulWidget {
  final ClientDatum data;

  const YXDEvaluateResultSecond({Key? key, required this.data})
      : super(key: key);

  @override
  _YXDEvaluateResultSecondState createState() =>
      _YXDEvaluateResultSecondState();
}

class _YXDEvaluateResultSecondState extends State<YXDEvaluateResultSecond> {
  final List<double> _periods = [1, 0.5, 0.25];
  Data? calculateData;
  double selectMoneyRate = 1;
  String repayType = "";

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
    getListData(widget.data);
  }

  @override
  Widget build(BuildContext context) {
    var data = widget.data;
    var moneyAll = data.assessMoney;
    var money = moneyAll * selectMoneyRate;

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
                    "申请额度",
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
                    padding: EdgeInsets.only(left: duSetWidth(10)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            top: duSetHeight(10),
                          ),
                          child: Text.rich(
                            TextSpan(
                              style: TextStyle(
                                  fontSize: duSetFontSize(12),
                                  color: AppColors.thirdElement),
                              children: [
                                const TextSpan(text: '当前可申请额度 '),
                                // 黑色
                                TextSpan(
                                  text:
                                      formatNumber(data.assessMoney).toString(),
                                  style: const TextStyle(
                                      color: AppColors.yxdBelowButtonColor),
                                ),
                                // 红色
                                const TextSpan(text: ' 元'),
                                // 黑色
                              ],
                            ),
                          ),
                        ),
                        // Padding(
                        //   padding: EdgeInsets.only(top: duSetHeight(15),right: duSetWidth(15)),
                        //   child: Row(
                        //     mainAxisAlignment: MainAxisAlignment.end,
                        //     crossAxisAlignment: CrossAxisAlignment.center,
                        //     children: [
                        //       Text(
                        //         "想要更高贷款额度，试试提额吧！",
                        //         style: TextStyle(
                        //           color: AppColors.thirdElementText,
                        //           fontSize: duSetFontSize(10),
                        //         ),
                        //       ),
                        //       containerButton(
                        //         height: duSetHeight(20),
                        //         width: duSetWidth(60),
                        //         cornerRadius: duSetWidth(10),
                        //         gbColor: AppColors.yxdBackgroundEnd,
                        //         title: "马上提额",
                        //         fontColor: AppColors.primaryBackground,
                        //         fontSize: duSetFontSize(10),
                        //       ),],
                        //   ),
                        // ),
                        Row(
                          children: [
                            Image.asset(
                              "assets/images/rmb.png",
                              width: duSetWidth(30),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: duSetWidth(10)),
                              child: Text(
                                formatNumber(money.toInt()).toString(),
                                style: TextStyle(
                                  fontSize: duSetFontSize(50),
                                  color: AppColors.primaryText,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: duSetHeight(5), bottom: duSetHeight(15)),
                          child: Wrap(
                            spacing: duSetWidth(10), // 水平间距
                            runSpacing: duSetHeight(10), // 垂直间距
                            children: _periods.asMap().entries.map((entry) {
                              var p = entry.value;
                              final bool isSelected = selectMoneyRate == p;
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectMoneyRate = p;
                                  });
                                },
                                child: Container(
                                  width: duSetWidth(70),
                                  height: duSetHeight(30),
                                  // 👈 固定宽度，让所有按钮一样宽
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: isSelected
                                        ? Colors.brown.shade50
                                        : Colors.white,
                                    border: Border.all(
                                      color: isSelected
                                          ? Colors.brown
                                          : Colors.grey.shade400,
                                    ),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Text(
                                    formatGetMoney(p),
                                    style: TextStyle(
                                        color: isSelected
                                            ? Colors.brown
                                            : Colors.black87,
                                        fontWeight: isSelected
                                            ? FontWeight.bold
                                            : FontWeight.normal,
                                        fontSize: duSetFontSize(12)),
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: duSetHeight(15),
                      bottom: duSetHeight(5),
                      left: duSetHeight(10)),
                  child: Text(
                    "申请人信息",
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
                    padding: EdgeInsets.only(
                        top: duSetHeight(5), bottom: duSetHeight(5)),
                    child: Column(
                      children: [
                        itemView(
                            title: "申请人",
                            content: data.clientName,
                            isShowTop: false),
                        itemView(
                            title: "身份证号",
                            content: calculateData == null
                                ? ""
                                : calculateData!.identityCardContent,
                            isShowTop: true),
                        itemView(
                            title: "联系电话",
                            content: data.phone,
                            isShowTop: true),

                        itemView(
                            title: "申请编号",
                            content: data.applicationNumber + "",
                            isShowTop: true),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: duSetHeight(15),
                      bottom: duSetHeight(5),
                      left: duSetHeight(10)),
                  child: Text(
                    "借款详情",
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
                    padding: EdgeInsets.only(
                        top: duSetHeight(5), bottom: duSetHeight(5)),
                    child: Column(
                      children: [
                        itemView(
                            title: "还款方式",
                            content: repayType,
                            isShowTop: false,
                            isMore: true,
                            onPressed: () {
                              _showBottomRepayStyleSheet(context);
                            }),
                        itemViewBottom(
                            title: "借款期限",
                            content: "36期",
                            bottomText: "*支持随借随还",
                            isShowTop: true),
                        itemViewBottom(
                            title: "年化利率",
                            content: calculateYearRate(calculateData),
                            bottomText: "*折算成万元日利息为"+calculateDayRate(calculateData),
                            isShowTop: true),
                        itemView(
                            title: "月还款",
                            content: calculateData == null
                                ? ""
                                : calculateRepayMoney(
                                    repayType, selectMoneyRate, calculateData!),
                            isShowTop: true),
                        itemView(
                            title: "放款/还款账号",
                            content: calculateData == null
                                ? ""
                                : calculateData!.bankIdContent,
                            isShowTop: true),
                        itemView(
                            title: "还款日",
                            content: "每月15日",
                            isShowTop: true),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      bottom: duSetHeight(60), top: duSetHeight(50)),
                  child: Align(
                    alignment: Alignment.center,
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
                      gbColor: AppColors.yxdBackgroundEnd,
                      title: "下一步",
                      fontColor: AppColors.primaryBackground,
                      fontSize: duSetFontSize(16),
                    ),
                  ),
                ),
              ],
            ),
          ),
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
                    padding: EdgeInsets.only(right: duSetWidth(10)),
                    child: Text(
                      content,
                      style: TextStyle(
                        fontWeight: FontWeight.w300,
                        color: AppColors.primaryText,
                        fontSize: duSetFontSize(13),
                      ),
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

  formatGetMoney(double rate) {
    String strRate = "全额申请";
    if (rate == 1) {
      strRate = "全额申请";
    } else if (rate == 0.50) {
      strRate = "1/2";
    } else if (rate == 0.25) {
      strRate = "1/4";
    }
    return strRate;
  }

  calculateRepayMoney(String type, double rate, Data calculateData) {
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
  calculateDayRate(Data? calculateDat){
    if (calculateDat != null && calculateDat.rate != "") {
      return  ((100* double.parse(calculateDat.rate))/30).toStringAsFixed(2);
    } else {
      return "";
    }

  }
}
