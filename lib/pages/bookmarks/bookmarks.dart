import 'package:dio/dio.dart';
import 'package:feng_pei/common/api/apis.dart';
import 'package:feng_pei/common/entity/entitys.dart';
import 'package:feng_pei/common/utils/utils.dart';
import 'package:feng_pei/common/values/values.dart';
import 'package:feng_pei/common/widgets/widgets.dart';
import 'package:feng_pei/pages/evaluate_result/jyd_evaluate_result.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:toast/toast.dart';

import '../webview/webview.dart';

class BookmarksPage extends StatefulWidget {
  const BookmarksPage({Key? key}) : super(key: key);

  @override
  _BookmarksPageState createState() => _BookmarksPageState();
}

class _BookmarksPageState extends State<BookmarksPage> {
  Future<List<ClientDatum>?> getListData(int page) async {
    var formData = FormData.fromMap({
      'page': page,
    });
    ClientEntity res = await UserAPI.getList(params: formData);
    if (res.code == 1) {
      return res.data;
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);
    return Scaffold(
      appBar: null,
      body: LoadListView<ClientDatum>(
        refreshOnStart: true,
        emptyWidget: const Center(
          child: Padding(
            padding: EdgeInsets.only(top: 100),
            child: Text('此处空空如也'),
          ),
        ),
        onRefreshData: (pageNum, pageSize) async {
          return getListData(pageNum).then((value) => value);
        },
        onLoadData: (pageNum, pageSize) async {
          return getListData(pageNum).then((value) => value);
        },
        itemBuilder: (context, count, index, data) {
          var typeStr = "";
          if (data.type == 0) {
            typeStr = "快享贷";
          } else if (data.type == 1) {
            typeStr = "薪享贷";
          } else if (data.type == 2) {
            typeStr = "优享贷";
          }
          DateFormat formatter = DateFormat('yyyy-MM-dd HH:mm');
          String formattedDateTime = formatter.format(data.applyTime);
          String statusButton = "";
          var buttonColor = AppColors.buttonStatueZero;
          if (data.status == 0) {
            statusButton = "补交资料";
            buttonColor = AppColors.buttonStatueZero;
          } else if (data.status == 1) {
            statusButton = "等待审核";
            buttonColor = AppColors.buttonStatueOne;
          } else if (data.status == 2) {
            statusButton = "审核通过";
            buttonColor = AppColors.buttonStatueTwo;
          } else if (data.status == 3) {
            buttonColor = AppColors.buttonStatueThree;
            statusButton = "审核拒绝";
          } else if (data.status == 4) {
            buttonColor = AppColors.buttonStatueFour;
            statusButton = "补充资料";
          }
          return GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {},
              child: Padding(
                padding: EdgeInsets.only(
                    left: duSetWidth(15),
                    top: duSetHeight(15),
                    right: duSetWidth(15),
                    bottom: duSetHeight(0)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(data.clientName,
                            style: TextStyle(
                                fontSize: duSetFontSize(20),
                                fontFamily: "Montserrat",
                                fontWeight: FontWeight.w600,
                                color: AppColors.thirdElement)),
                        const Spacer(),
                        Container(
                          margin: EdgeInsets.only(right: duSetWidth(12)),
                          child: myButton(
                              onPressed: () {
                                if (data.status == 0) {
                                  if (data.type == 0) {
                                    //工薪贷
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            WebViewPage(data: data),
                                      ),
                                    );
                                  } else if (data.type == 1) {
                                    //薪享贷
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            JYDEvaluateResult(data: data),
                                      ),
                                    );
                                  } else if (data.type == 2) {
                                    //优享贷
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            WebViewPage(data: data),
                                      ),
                                    );
                                  }
                                }
                              },
                              gbColor: buttonColor,
                              fontSize: duSetFontSize(12),
                              height: duSetHeight(28),
                              title: statusButton,
                              fontColor: AppColors.primaryBackground,
                              cornerRadius: duSetHeight(14)),
                        )
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: duSetHeight(5)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "产品：" + typeStr,
                            style: TextStyle(
                                //fontFamily: "Montserrat",
                                fontSize: duSetFontSize(12),
                                color: AppColors.thirdElementText),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: duSetWidth(59)),
                            child: Text(
                              "申请金额：" + data.loanAmount.toString(),
                              style: TextStyle(
                                  //fontFamily: "Montserrat",
                                  fontSize: duSetFontSize(12),
                                  color: AppColors.thirdElementText),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: duSetHeight(3)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "订单ID：" + data.id.toString(),
                            style: TextStyle(
                                //fontFamily: "Montserrat",
                                fontSize: duSetFontSize(12),
                                color: AppColors.thirdElementText),
                          ),
                          const Spacer(),
                          Padding(
                            padding: EdgeInsets.only(right: duSetWidth(53)),
                            child: Text(
                              "申请时间：" + formattedDateTime,
                              style: TextStyle(
                                  // fontFamily: "Montserrat",
                                  fontSize: duSetFontSize(12),
                                  color: AppColors.thirdElementText),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: duSetHeight(10)),
                      child: const Divider(
                        height: 1.0, // 分割线的高度
                        thickness: 1.0, // 分割线的厚度
                        color: AppColors.secondX, // 分割线的颜色
                      ),
                    )
                  ],
                ),
              ));
        },
      ),
    );
  }
}
