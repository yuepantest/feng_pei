import 'package:dio/dio.dart';
import 'package:feng_pei/common/entity/entitys.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../common/api/apis.dart';
import '../../common/utils/utils.dart';
import '../../common/values/values.dart';
import '../../common/widgets/widgets.dart';
import '../webview/webview.dart';

class KXDEvaluateResultSecond extends StatefulWidget {
  final ClientDatum data;

  const KXDEvaluateResultSecond({Key? key, required this.data})
      : super(key: key);

  @override
  _KXDEvaluateResultSecondState createState() =>
      _KXDEvaluateResultSecondState();
}

class _KXDEvaluateResultSecondState extends State<KXDEvaluateResultSecond> {
  Data? calculateData;
  String selectTime = "";
  String selectValue = "";
  List<SelectInstallmentEntity> _periods = [];

  Future<void> getListData(ClientDatum data) async {
    var formData = FormData.fromMap({
      'clientId': data.id,
    });
    CalculateDataEntity res = await UserAPI.getCalculateDate(params: formData);
    if (res.code == 1) {
      setState(() {
        calculateData = res.data;
        selectTime = calculateData!.titleSix;
        selectValue = calculateData!.contentSix;
        _periods = _showBottomSheet(calculateData);
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
      body: DecoratedBox(
        decoration: const BoxDecoration(color: AppColors.secondY),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.all(duSetHeight(15)),
                width: double.infinity,
                decoration: BoxDecoration(
                    color: AppColors.primaryBackground,
                    borderRadius:
                        BorderRadius.all(Radius.circular(duSetWidth(10)))),
                child: Padding(
                  padding: EdgeInsets.only(
                      left: duSetWidth(13), top: duSetHeight(15)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "申请金额",
                        style: TextStyle(fontSize: duSetFontSize(14)),
                      ),
                      Text(
                        "¥" + data.assessMoney.toString(),
                        style: TextStyle(fontSize: duSetFontSize(50)),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          bottom: duSetHeight(15),
                        ),
                        child: Text(
                          "月利率为" +
                              (calculateData == null
                                  ? ""
                                  : calculateData!.rate) +
                              "%，按单利计算",
                          style: TextStyle(
                              fontSize: duSetFontSize(10),
                              color: AppColors.thirdElementText),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.all(duSetHeight(15)),
                width: double.infinity,
                decoration: BoxDecoration(
                    color: AppColors.primaryBackground,
                    borderRadius:
                        BorderRadius.all(Radius.circular(duSetWidth(10)))),
                child: Padding(
                  padding: EdgeInsets.all(duSetWidth(10)),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            left: duSetWidth(2),
                            right: duSetWidth(10),
                            top: duSetHeight(15),
                            bottom: duSetHeight(15)),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "分期期数",
                              style: TextStyle(fontSize: duSetFontSize(14)),
                            ),
                            const Spacer(),
                            Text(
                              selectTime,
                              style: TextStyle(fontSize: duSetFontSize(14)),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: duSetHeight(5), bottom: duSetHeight(15)),
                        child: Wrap(
                          spacing: duSetWidth(10), // 水平间距
                          runSpacing: duSetHeight(10), // 垂直间距
                          children: _periods.asMap().entries.map((entry) {
                            var p = entry.value;
                            final bool isSelected = selectTime == p.title;
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectTime = p.title;
                                  selectValue = p.content;
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
                                  p.title,
                                  style: TextStyle(
                                    color: isSelected
                                        ? Colors.brown
                                        : Colors.black87,
                                    fontWeight: isSelected
                                        ? FontWeight.bold
                                        : FontWeight.normal,
                                  ),
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
              Container(
                margin: EdgeInsets.all(duSetHeight(15)),
                width: double.infinity,
                decoration: BoxDecoration(
                    color: AppColors.primaryBackground,
                    borderRadius:
                        BorderRadius.all(Radius.circular(duSetWidth(10)))),
                child: Padding(
                  padding: EdgeInsets.all(duSetWidth(13)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "还款计划",
                        style: TextStyle(fontSize: duSetFontSize(14)),
                      ),
                      const Spacer(),
                      Text(
                        selectValue,
                        style: TextStyle(fontSize: duSetFontSize(14)),
                      ),
                    ],
                  ),
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
                      "用户信息",
                      style: TextStyle(fontSize: duSetFontSize(14)),
                    ),
                    Divider(
                      color: AppColors.secondX,
                      thickness: duSetHeight(1),
                      height: duSetHeight(1),
                    ),
                    lineItem("申请人", data.clientName),
                    lineItem(
                        "身份证号码",
                        calculateData == null
                            ? ""
                            : calculateData!.identityCardContent),
                    lineItem("申请日期", setTime(data.applyTime)),
                    lineItem(
                        "申请编号",
                        calculateData == null
                            ? ""
                            : calculateData!.applicationNumber),
                    lineItem("联系电话", data.phone),
                    lineItem(
                        "还款账号",
                        calculateData == null
                            ? ""
                            : calculateData!.bankIdContent),
                  ],
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
                  const Text("温馨提示："),
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
                    Padding(
                      padding: EdgeInsets.only(top: duSetHeight(15)),
                      child: Text(
                        "本笔借款仅能用于个人消费，不得用于投资、还债或者其他不当用途，借款资金严谨流入股市、房市购买理财产品和贵金属等。",
                        style: TextStyle(
                            color: AppColors.thirdElementText,
                            fontSize: duSetFontSize(12)),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: duSetHeight(100)),
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
                    gbColor: AppColors.buttonStatueKXD,
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
    );
  }

  _showBottomSheet(Data? data) {
    var daysOfWeek = <SelectInstallmentEntity>[];
    if (data?.titleOne != null && data?.titleOne != "") {
      var entity = SelectInstallmentEntity(
          title: data!.titleOne, content: data.contentOne);
      daysOfWeek.add(entity);
    }
    if (data?.titleTwo != null && data?.titleTwo != "") {
      var entity = SelectInstallmentEntity(
          title: data!.titleTwo, content: data.contentTwo);
      daysOfWeek.add(entity);
    }
    if (data?.titleThree != null && data?.titleThree != "") {
      var entity = SelectInstallmentEntity(
          title: data!.titleThree, content: data.contentTree);
      daysOfWeek.add(entity);
    }
    if (data?.titleFour != null && data?.titleFour != "") {
      var entity = SelectInstallmentEntity(
          title: data!.titleFour, content: data.contentFour);
      daysOfWeek.add(entity);
    }
    if (data?.titleFive != null && data?.titleFive != "") {
      var entity = SelectInstallmentEntity(
          title: data!.titleFive, content: data.contentFive);
      daysOfWeek.add(entity);
    }
    if (data?.titleSix != null && data?.titleSix != "") {
      var entity = SelectInstallmentEntity(
          title: data!.titleSix, content: data.contentSix);
      daysOfWeek.add(entity);
    }
    return daysOfWeek;
  }
}
