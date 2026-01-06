import 'package:dio/dio.dart';
import 'package:feng_pei/common/api/apis.dart';
import 'package:feng_pei/common/entity/entitys.dart';
import 'package:feng_pei/common/utils/utils.dart';
import 'package:feng_pei/common/values/values.dart';
import 'package:feng_pei/common/widgets/widgets.dart';
import 'package:feng_pei/pages/evaluate_result/xxd_evaluate_result.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:toast/toast.dart';

import '../evaluate_result/kxd_evaluate_result.dart';
import '../evaluate_result/yxd_evaluate_result.dart';

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

  _handleSendMsg(ClientDatum data) async {
    var typeStr = "";
    if (data.type == 0) {
      typeStr = "【商企云信】"+data.clientName+"先生/女生：您的申请已通过初审，请联系工作人员继续办理，感谢您的信任！";
    } else if (data.type == 1) {
      typeStr = "【商企云信】"+data.clientName+"您好：您提交的申请系统已审核通过，详情请联系业务员！";
    } else if (data.type == 2) {
      typeStr = "【商企云信】尊敬的"+data.clientName+"客户：您申请的订单已经提交成功，感谢您的支持！";
    }
    var formData = FormData.fromMap({
      'clientId': data.id,
      'content': typeStr,
      'phone': data.phone,
    });
    BaseData res = await UserAPI.sendMsg(params: formData);
    if (res.code == 1) {
      toastInfo(msg: '发送消息成功');
      setState(() {
        data.sendMsg=1;
      });
    } else {
      toastInfo(msg: '发送消息失败');
    }
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
              onTap: () {
                if (data.status == 0) {
                  if (data.type == 0) {
                    //快享贷
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => KXDEvaluateResult(data: data),
                      ),
                    );
                  } else if (data.type == 1) {
                    //薪享贷
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => XXDEvaluateResult(data: data),
                      ),
                    );
                  } else if (data.type == 2) {
                    //优享贷
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => YXDEvaluateResult(data: data),
                      ),
                    );
                  }
                }
              },
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
                        if (data.status == 0 && data.sendMsg==0)
                          Container(
                            margin: EdgeInsets.only(right: duSetWidth(6)),
                            child: containerButton(
                                onPressed: () {
                                  dialogSheet(
                                      context: context,
                                      onCancel: () {},
                                      onConfirm: () {
                                        _handleSendMsg(data);
                                      });
                                },
                                gbColor: buttonColor,
                                fontSize: duSetFontSize(12),
                                height: duSetHeight(28),
                                title: "发送短信",
                                fontColor: AppColors.primaryBackground,
                                cornerRadius: duSetHeight(14),
                                width: duSetWidth(80)),
                          ),
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
                          const Spacer(),
                          Padding(
                            padding: EdgeInsets.only(right: duSetWidth(15)),
                            child: Text(
                              "状态：" + statusButton,
                              style: TextStyle(
                                  fontSize: duSetFontSize(10),
                                  fontWeight: FontWeight.w600),
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


