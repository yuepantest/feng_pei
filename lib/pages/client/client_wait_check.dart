import 'package:feng_pei/common/entity/entitys.dart';
import 'package:feng_pei/common/utils/utils.dart';
import 'package:feng_pei/common/values/values.dart';
import 'package:feng_pei/common/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ClientWaitCheckPage extends StatefulWidget {
  final ClientDatum data;

  const ClientWaitCheckPage({Key? key, required this.data}) : super(key: key);

  @override
  _ClientWaitCheckPageState createState() => _ClientWaitCheckPageState();
}

class _ClientWaitCheckPageState extends State<ClientWaitCheckPage> {
  @override
  Widget build(BuildContext context) {
    DateFormat formatter = DateFormat('yyyy-MM-dd HH:mm');
    String formattedDateTime = "";
    if (widget.data.submitTime != null) {
      formattedDateTime = formatter.format(widget.data.submitTime!);
    }
    return Scaffold(
      appBar: transparentAppBar(
        title: Padding(
            padding: EdgeInsets.only(right: duSetWidth(40)),
            child: const Text(
              "提交资料",
              style: TextStyle(
                  color: AppColors.primaryElementText,
                  fontWeight: FontWeight.w600),
            )),
        context: context,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: AppColors.primaryElementText,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: <Widget>[],
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: duSetHeight(36)),
              child: Text(
                widget.data.clientName,
                style: TextStyle(
                  color: AppColors.fourElement,
                  fontFamily: "Avenir",
                  fontSize: duSetFontSize(30),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: duSetHeight(12)),
              child: Text(
                "额度：" + widget.data.assessMoney.toString(),
                style: TextStyle(
                  color: AppColors.buttonStatueTwo,
                  fontFamily: "Avenir",
                  fontWeight: FontWeight.w600,
                  fontSize: duSetFontSize(20),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: duSetHeight(20)),
              child: Image.asset(
                "assets/images/correct.png",
                fit: BoxFit.contain,
                width: duSetWidth(100),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: duSetHeight(10)),
              child: Text(
                "提交成功",
                style: TextStyle(
                  color: AppColors.buttonStatueTwo,
                  fontFamily: "Avenir",
                  fontWeight: FontWeight.w600,
                  fontSize: duSetFontSize(20),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: duSetHeight(15)),
              child: Text(
                "正在审核中...",
                style: TextStyle(
                  color: AppColors.thirdElementText,
                  fontFamily: "Avenir",
                  fontSize: duSetFontSize(13),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: duSetHeight(10)),
              child: Text(
                "中途可能会致电本人，单位和联系人",
                style: TextStyle(
                  color: AppColors.thirdElementText,
                  fontFamily: "Avenir",
                  fontSize: duSetFontSize(13),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: duSetHeight(10)),
              child: Text(
                "核实情况，请务必接听",
                style: TextStyle(
                  color: AppColors.thirdElementText,
                  fontFamily: "Avenir",
                  fontSize: duSetFontSize(13),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: duSetHeight(10)),
              child: Text(
                "受理时间：" + formattedDateTime,
                style: TextStyle(
                  color: AppColors.thirdElementText,
                  fontFamily: "Avenir",
                  fontSize: duSetFontSize(10),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
