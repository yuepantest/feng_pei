import 'package:dio/dio.dart';
import 'package:feng_pei/common/api/apis.dart';
import 'package:feng_pei/common/entity/entitys.dart';
import 'package:feng_pei/common/utils/utils.dart';
import 'package:feng_pei/common/values/values.dart';
import 'package:feng_pei/common/widgets/widgets.dart';
import 'package:feng_pei/global.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

class LoginInPage extends StatefulWidget {
  const LoginInPage({Key? key}) : super(key: key);

  @override
  _LoginInPageState createState() => _LoginInPageState();
}

class _LoginInPageState extends State<LoginInPage> {
  // fullName email password 的控制器
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _imageLogo("login"),
            _titleText("登录"),
            _buildInputForm(),
            _loginButton(),
            regestText(),
          ],
        ),
      ),
    );
  }

  Widget _titleText(String str) {
    return Container(
      margin: EdgeInsets.only(top: duSetHeight(10)),
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
      margin: EdgeInsets.only(top: duSetHeight(80)),
      width: duSetWidth(80),
      height: duSetHeight(80),
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
        title: "登录",
      ),
    );
  }

  _handleSignIn() async {
    if (duCheckStringLength(_nameController.value.text, 10)) {
      toastInfo(msg: '用户名不能超过5位');
      return;
    }
    if (!duCheckStringLength(_passController.value.text, 6)) {
      toastInfo(msg: '密码不能小于6位');
      return;
    }
    var formData = FormData.fromMap({
      'name': _nameController.value.text,
      'password': duSHA256(_passController.value.text),
    });
    LoginEntity res = await UserAPI.login(params: formData);
    if (res.code == 1) {
      toastInfo(msg: '登录成功');
      Navigator.pushReplacementNamed(context, "/app");
      Global.saveProfile(res.data);
    } else {
      toastInfo(msg: '登录失败');
    }
  }

  Widget regestText() {
    return Container(
      margin: EdgeInsets.only(top: duSetWidth(30), right: duSetWidth(30)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          ElevatedButton(
              child: const Text(
                "点击注册账号",
                style: TextStyle(
                    color: AppColors.primaryText,
                    decoration: TextDecoration.underline),
              ),
              onPressed: () {
                Navigator.pushNamed(context, "/sign-up");
              }),
        ],
      ),
    );
  }
}
