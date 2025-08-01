import 'package:feng_pei/common/entity/entitys.dart';
import 'package:feng_pei/common/utils/utils.dart';
import 'package:feng_pei/common/values/values.dart';
import 'package:feng_pei/common/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

class ClientRefusePage extends StatefulWidget {
  final ClientDatum data;

  const ClientRefusePage({Key? key, required this.data}) : super(key: key);

  @override
  _ClientRefusePageState createState() => _ClientRefusePageState();
}

class _ClientRefusePageState extends State<ClientRefusePage> {
  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);
    return Scaffold(
      appBar: transparentAppBar(
        title: Padding(
            padding: EdgeInsets.only(right: duSetWidth(40)),
            child: const Text(
              "审核结果",
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
            const Divider(
              height: 1.0, // 分割线的高度
              thickness: 1.0, // 分割线的厚度
              color: AppColors.tabBarElement, // 分割线的颜色
            ),
            Padding(
              padding: EdgeInsets.only(top: duSetHeight(30)),
              child: Text(
                widget.data.clientName +
                    "  预审额度" +
                    widget.data.assessMoney.toString(),
                style: TextStyle(
                  color: AppColors.primaryText,
                  fontFamily: "Avenir",
                  fontSize: duSetFontSize(15),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: duSetHeight(30)),
              child: Image.asset(
                "assets/images/order_refuse.png",
                fit: BoxFit.contain,
                width: duSetWidth(100),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: duSetHeight(30)),
              child: Text(
                "审核拒绝",
                style: TextStyle(
                  color: AppColors.buttonStatueThree,
                  fontFamily: "Avenir",
                  fontWeight: FontWeight.w600,
                  fontSize: duSetFontSize(20),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: duSetHeight(15),
                  left: duSetWidth(25),
                  right: duSetWidth(25)),
              child: Text(
                "拒绝原因：" + widget.data.refuseReasonOne,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.fourElement,
                  fontFamily: "Avenir",
                  fontSize: duSetFontSize(13),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: duSetHeight(10),
                left: duSetWidth(25),
                right: duSetWidth(25),
              ),
              child: Text(
                widget.data.refuseReasonTwo,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.fourElement,
                  fontFamily: "Avenir",
                  fontSize: duSetFontSize(13),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: duSetHeight(30),
                left: duSetWidth(25),
                right: duSetWidth(25),
              ),
              child: Text(
                "很遗憾，经评估你暂时未通过审核，可过段时间再来申请！",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.thirdElementText,
                  fontFamily: "Avenir",
                  fontSize: duSetFontSize(10),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: duSetWidth(50)),
              child: myButton(
                  onPressed: () {
                    toastInfo(msg: '感谢你的申请！');
                  },
                  gbColor: AppColors.buttonStatueZero,
                  fontSize: duSetFontSize(16),
                  height: duSetHeight(38),
                  title: "我知道了",
                  fontColor: AppColors.primaryBackground,
                  cornerRadius: duSetHeight(20)),
            ),
          ],
        ),
      ),
    );
  }
}
