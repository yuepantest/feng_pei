import 'dart:async';
import 'package:dio/dio.dart';
import 'package:feng_pei/common/entity/entitys.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../common/api/apis.dart';
import '../../common/utils/utils.dart';
import '../../common/values/values.dart';
import '../../common/widgets/widgets.dart';

class XXDClient extends StatefulWidget {
  final ClientDatum data;

  const XXDClient({Key? key, required this.data}) : super(key: key);

  @override
  _XXDClientState createState() => _XXDClientState();
}

class _XXDClientState extends State<XXDClient> {
  Data? calculateData;

  Future<void> getListData(ClientDatum data) async {
    var formData = FormData.fromMap({
      'clientId': data.id,
    });
    CalculateDataEntity res = await UserAPI.getCalculateDate(params: formData);
    if (res.code == 1) {
      setState(() {
        calculateData = res.data;
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
    String formattedDateTime = "";
    DateFormat formatter = DateFormat('yyyy-MM-dd HH:mm');
    if (data.submitTime != null) {
      formattedDateTime = formatter.format(data.submitTime!);
    }
    return Scaffold(
      appBar: transparentAppBar(
        color: AppColors.xxdClientResultBackground,
        title: Padding(
            padding: EdgeInsets.only(right: duSetWidth(40)),
            child: const Text(
              "审批结果",
              style: TextStyle(
                  color: AppColors.thirdElement, fontWeight: FontWeight.w600),
            )),
        context: context,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: AppColors.thirdElement,
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
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                AppColors.xxdClientResultBackground,
                AppColors.primaryBackground
              ])),
          child: Column(children: [
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: duSetWidth(30)),
                  child: Image.asset(
                    setTitleIcon(data),
                    fit: BoxFit.contain,
                    width: duSetWidth(50),
                    height: duSetHeight(50),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: duSetWidth(5)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        setApplicationStatusTitle(data),
                        style: TextStyle(
                            color: setTitleColor(data),
                            fontSize: duSetFontSize(18),
                            fontWeight: const FontWeight(600)),
                      ),
                      if (data.status == 1)
                        Padding(
                          padding: EdgeInsets.only(top: duSetHeight(5)),
                          child: Text(
                            setApplicationStatusContent(data),
                            style: const TextStyle(
                                color: AppColors.thirdElementText),
                          ),
                        )
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.all(duSetWidth(20)),
              child: Container(
                padding: EdgeInsets.only(
                    left: duSetWidth(15),
                    right: duSetWidth(15),
                    top: duSetHeight(15),
                    bottom: duSetHeight(15)),
                width: double.infinity,
                decoration: BoxDecoration(
                    color: AppColors.primaryBackground,
                    borderRadius: BorderRadius.circular(duSetWidth(5))),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: duSetWidth(5),top: duSetHeight(5),bottom: duSetHeight(3),right: duSetWidth(3)),
                      decoration: BoxDecoration(
                        color: AppColors.secondaryElement,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Row(
                        children: [
                          Image.asset(
                            setNotesIcon(data),
                            width: duSetHeight(30),
                            height: duSetHeight(30),
                            fit: BoxFit.contain,
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(left: duSetWidth(8)),
                              child: myText(data),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: duSetHeight(15)),
                      child: Row(
                        children: [
                          Text(
                            "借款金额",
                            style: TextStyle(fontSize: duSetFontSize(13)),
                          ),
                          const Spacer(),
                          Text(
                            data.assessMoney.toString(),
                            style: TextStyle(
                                fontWeight: const FontWeight(600),
                                fontSize: duSetFontSize(26)),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: duSetHeight(15)),
                      child: Row(
                        children: [
                          Text(
                            "申请人",
                            style: TextStyle(fontSize: duSetFontSize(13)),
                          ),
                          const Spacer(),
                          Text(
                            data.clientName,
                            style: const TextStyle(fontWeight: FontWeight(600)),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: duSetHeight(15)),
                      child: Row(
                        children: [
                          Text(
                            "收/还款账户",
                            style: TextStyle(fontSize: duSetFontSize(13)),
                          ),
                          const Spacer(),
                          Text(
                            calculateData == null
                                ? ""
                                : calculateData!.bankIdContent,
                            style: const TextStyle(fontWeight: FontWeight(600)),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: duSetHeight(15)),
                      child: Row(
                        children: [
                          Text(
                            "借款用途",
                            style: TextStyle(fontSize: duSetFontSize(13)),
                          ),
                          const Spacer(),
                          const Text(
                            "个人消费",
                            style: TextStyle(fontWeight: FontWeight(600)),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: duSetHeight(15)),
                      child: Row(
                        children: [
                          Text(
                            "还款日",
                            style: TextStyle(fontSize: duSetFontSize(13)),
                          ),
                          const Spacer(),
                          const Text(
                            "每月24日",
                            style: TextStyle(fontWeight: FontWeight(600)),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: duSetHeight(15)),
                      child: Row(
                        children: [
                          Text(
                            "受理时间",
                            style: TextStyle(fontSize: duSetFontSize(13)),
                          ),
                          const Spacer(),
                          Text(
                            dealWithSubmitTime(data.submitTime),
                            style: const TextStyle(fontWeight: FontWeight(600)),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }

  dealWithSubmitTime(DateTime? submitTime) {
    DateFormat formatter = DateFormat('yyyy-MM-dd');
    String formattedDateTime = "";
    if (submitTime != null) {
      formattedDateTime = formatter.format(widget.data.submitTime!);
    }
    return formattedDateTime;
  }

  calculateYearRate(Data? calculateData) {
    if (calculateData != null && calculateData.rate != "") {
      return (double.parse(calculateData.rate) * 12).toString() + "%";
    } else {
      return "";
    }
  }

  setApplicationStatusTitle(ClientDatum data) {
    if (data.status == 1) {
      //审核中
      return "借款正在审核中...";
    } else if (data.status == 2) {
      //审核通过
      return "审核通过...";
    } else if (data.status == 3) {
      //审核拒绝
      return "借款审核拒绝...";
    } else if (data.status == 4) {
      //补充资料
      return "补充资料...";
    }
  }

  setTitleColor(ClientDatum data) {
    if (data.status == 1) {
      //审核中
      return AppColors.thirdElement;
    } else if (data.status == 2) {
      //审核通过
      return AppColors.thirdElement;
    } else if (data.status == 3) {
      //审核拒绝
      return AppColors.thirdElement;
    } else if (data.status == 4) {
      //补充资料
      return AppColors.thirdElement;
    }
  }

  setTitleIcon(ClientDatum data) {
    if (data.status == 1) {
      //审核中
      return "assets/images/xxd_client_result_1.png";
    } else if (data.status == 2) {
      //审核通过
      return "assets/images/xxd_pass.png";
    } else if (data.status == 3) {
      //审核拒绝
      return "assets/images/xxd_refuse.png";
    } else if (data.status == 4) {
      //补充资料
      return "assets/images/xxd_client_result_1.png";
    }
  }

  setNotesIcon(ClientDatum data) {
    if (data.status == 1) {
      //审核中
      return "assets/images/phone_call.png";
    } else if (data.status == 2) {
      //审核通过
      return "assets/images/xxd_note.png";
    } else if (data.status == 3) {
      //审核拒绝
      return "assets/images/xxd_note.png";
    } else if (data.status == 4) {
      //补充资料
      return "assets/images/xxd_note.png";
    }
  }

  setApplicationStatusContent(ClientDatum data) {
    if (data.status == 1) {
      //审核中
      return "预计48小时内完成审核，请稍后...";
    } else if (data.status == 2) {
      //审核通过
      return "";
    } else if (data.status == 3) {
      //审核拒绝
      return "";
    } else if (data.status == 4) {
      //补充资料
      return "";
    }
  }

  setApplicationStatusNotesTitle(ClientDatum data) {
    if (data.status == 1) {
      //审核中
      return "我们将会在两个工作日内联系您确认借款信息，请保持手机畅通，请务必接听。";
    } else if (data.status == 2) {
      //审核通过
      return "您的借款审核已通过，预计24小时内到账，请注意查收！同时提醒您按时还款，感谢您的支持！";
    } else if (data.status == 3) {
      //审核拒绝
      return "很遗憾，经我司对您的材料人工复审，您暂未通过审核，原因是：";
    } else if (data.status == 4) {
      //补充资料
      return "请补充材料，以便我们对您的情况更好的评估！";
    }
  }

  Widget myText(data) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: setApplicationStatusNotesTitle(data),
            style: const TextStyle(
              color: AppColors.xxdClientResultText,
              fontSize: 11,
            ),
          ),
          if (data.status == 3)
            TextSpan(
              text: data.refuseReasonOne,
              style: const TextStyle(
                color: Colors.red,
                fontSize: 11,
                fontWeight: FontWeight.bold,
              ),
            ),
          if (data.status == 3)
            const TextSpan(
              text: "。可过段时间再来申请。",
              style: TextStyle(
                color: AppColors.xxdClientResultText,
                fontSize: 11,
              ),
            ),
        ],
      ),
    );
  }
}
