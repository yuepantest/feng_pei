import 'package:dio/dio.dart';
import 'package:feng_pei/common/api/apis.dart';
import 'package:feng_pei/common/entity/entitys.dart';
import 'package:feng_pei/common/utils/screen.dart';
import 'package:feng_pei/common/values/colors.dart';
import 'package:feng_pei/common/widgets/widgets.dart';
import 'package:feng_pei/pages/client/client.dart';
import 'package:feng_pei/pages/client/client_wait_check.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:toast/toast.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({Key? key}) : super(key: key);

  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  Future<List<ClientDatum>?> getListData(int page) async {
    var formData = FormData.fromMap({
      'page': page,
    });
    ClientEntity res = await UserAPI.getSpecialList(params: formData);
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
          String formattedDateTime = "";
          if (data.submitTime != null) {
            formattedDateTime = formatter.format(data.submitTime!);
          }
          String statusButton = "";
          if (data.status == 0) {
            statusButton = "补交资料";
          } else if (data.status == 1) {
            statusButton = "等待审核";
          } else if (data.status == 2) {
            statusButton = "审核通过";
          } else if (data.status == 3) {
            statusButton = "审核拒绝";
          } else if (data.status == 4) {
            statusButton = "补充资料";
          }
          return Padding(
            padding: EdgeInsets.only(
                left: duSetWidth(15),
                top: duSetHeight(15),
                right: duSetWidth(15),
                bottom: duSetHeight(0)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(data.clientName,
                        style: TextStyle(
                            fontSize: duSetFontSize(20),
                            fontFamily: "Montserrat",
                            fontWeight: FontWeight.w600,
                            color: AppColors.thirdElement)),
                    const Spacer(),
                    Padding(
                      padding: EdgeInsets.only(right: duSetWidth(30)),
                      child: Text(
                        "办理状态：" + statusButton,
                        style: TextStyle(
                            fontSize: duSetFontSize(10),
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(right: duSetWidth(12)),
                      child: myButton(
                        onPressed: () {
                          if (data.status == 2) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    ClientPassPage(data: data),
                              ),
                            );
                          } else if (data.status == 3) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    ClientRefusePage(data: data),
                              ),
                            );
                          } else if (data.status == 1) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    ClientWaitCheckPage(data: data),
                              ),
                            );
                          }
                        },
                        gbColor: AppColors.buttonStatueOne,
                        fontSize: duSetFontSize(12),
                        height: duSetHeight(28),
                        title: "查看详情",
                        fontColor: AppColors.primaryBackground,
                        cornerRadius: duSetHeight(14),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(top: duSetHeight(5)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("产品：" + typeStr,
                          style: TextStyle(
                              fontFamily: "Montserrat",
                              fontSize: duSetFontSize(12),
                              color: AppColors.thirdElementText)),
                      Text("          预授信：" + data.assessMoney.toString(),
                          style: TextStyle(
                              fontFamily: "Montserrat",
                              fontSize: duSetFontSize(12),
                              color: AppColors.thirdElementText)),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: duSetHeight(5), bottom: duSetHeight(10)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("订单ID：" + data.id.toString(),
                          style: TextStyle(
                              fontFamily: "Montserrat",
                              fontSize: duSetFontSize(12),
                              color: AppColors.thirdElementText)),
                      Text("          受理时间：" + formattedDateTime,
                          style: TextStyle(
                              fontFamily: "Montserrat",
                              fontSize: duSetFontSize(12),
                              color: AppColors.thirdElementText)),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: duSetHeight(0)),
                  child: const Divider(
                    height: 1.0, // 分割线的高度
                    thickness: 1.0, // 分割线的厚度
                    color: AppColors.secondX, // 分割线的颜色
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
