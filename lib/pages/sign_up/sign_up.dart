import 'package:feng_pei/common/utils/utils.dart';
import 'package:feng_pei/common/values/values.dart';
import 'package:feng_pei/common/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  // fullName email password 的控制器
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final TextEditingController _passAgainController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);
    return Scaffold(
      appBar: transparentAppBar(
        context: context,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: AppColors.primaryText,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: <Widget>[],
      ),
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _imageLogo("regist"),
            _titleText("注册"),
            _buildInputForm(),
            _loginButton(),
          ],
        ),
      ),
    );
  }

  Widget _titleText(String str) {
    return Container(
      margin: EdgeInsets.only(top: duSetHeight(15)),
      child: Text(
        str,
        style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: duSetFontSize(24),
            fontFamily: "Montserrat"),
      ),
    );
  }

  Widget _imageLogo(String str) {
    return Container(
      margin: EdgeInsets.only(top: duSetHeight(20)),
      width: duSetWidth(60),
      height: duSetHeight(60),
      child: Image.asset(
        "assets/images/$str.png",
      ),
    );
  }

// 登录表单
  Widget _buildInputForm() {
    return Container(
      width: duSetWidth(295),
      // height: 204,
      margin: EdgeInsets.only(top: duSetHeight(49)),
      child: Column(
        children: [
          // email input
          inputTextEdit(
            controller: _nameController,
            keyboardType: TextInputType.text,
            hintText: "请输入你的姓名",
            marginTop: 0,
            // autofocus: true,
          ),
          // password input
          inputTextEdit(
            controller: _passController,
            keyboardType: TextInputType.visiblePassword,
            hintText: "请输入你的密码",
            isPassword: true,
          ),
          // password input
          inputTextEdit(
            controller: _passAgainController,
            keyboardType: TextInputType.visiblePassword,
            hintText: "请再次输入你的密码",
            isPassword: true,
          ),
        ],
      ),
    );
  }

  Widget _loginButton() {
    return Container(
      margin: EdgeInsets.only(top: duSetHeight(30)),
      child: btnFlatButtonWidget(
        onPressed: () => _handleSignIn(),
        gbColor: AppColors.primaryElement,
        title: "注册",
      ),
    );
  }

  _handleSignIn() {
    toastInfo(msg: '由于该功能涉及信息安全，因此暂未开发！');
  }
}
