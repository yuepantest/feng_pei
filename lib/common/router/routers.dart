import 'package:feng_pei/common/entity/entitys.dart';
import 'package:feng_pei/pages/application/application.dart';
import 'package:feng_pei/pages/client/client.dart';
import 'package:feng_pei/pages/index/index.dart';
import 'package:feng_pei/pages/login_in/login_in.dart';
import 'package:feng_pei/pages/sign_up/sign_up.dart';

var staticRouters = {
  "/login-in": (context) => const LoginInPage(), //登录
  "/sign-up": (context) => const SignUpPage(), //注册
  "/app": (context) => const ApplicationPage(), // 主程序
  "/index-page": (context) => const IndexPage(), // 主程序
};
