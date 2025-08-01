import 'package:feng_pei/common/entity/entitys.dart';
import 'package:feng_pei/common/utils/utils.dart';
import 'package:feng_pei/common/values/values.dart';
import 'package:feng_pei/common/widgets/widgets.dart';
import 'package:flutter/material.dart';

class ClientPassPage extends StatefulWidget {
  final ClientDatum data;

  const ClientPassPage({Key? key, required this.data}) : super(key: key);

  @override
  _ClientPassPageState createState() => _ClientPassPageState();
}

class _ClientPassPageState extends State<ClientPassPage> {
  @override
  Widget build(BuildContext context) {
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
            Padding(
              padding: EdgeInsets.only(top: duSetHeight(30)),
              child: Text(
                widget.data.clientName + "  恭喜你审核已通过",
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
                "assets/images/client_pass.png",
                fit: BoxFit.contain,
                width: duSetWidth(100),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: duSetHeight(30)),
              child: Text(
                "授信额度：" + widget.data.assessMoney.toString(),
                style: TextStyle(
                  color: AppColors.primaryText,
                  fontFamily: "Avenir",
                  fontWeight: FontWeight.w600,
                  fontSize: duSetFontSize(20),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: duSetHeight(15)),
              child: Text(
                "请完成后续的签约手续后放款",
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
                "放款卡号：" + widget.data.bankId,
                style: TextStyle(
                  color: AppColors.thirdElementText,
                  fontFamily: "Avenir",
                  fontSize: duSetFontSize(13),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
