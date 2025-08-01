import 'package:feng_pei/pages/application/application.dart';
import 'package:feng_pei/pages/login_in/login_in.dart';
import 'package:feng_pei/pages/welcome/welcome.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../global.dart';

class IndexPage extends StatefulWidget {
  const IndexPage({Key? key}) : super(key: key);

  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //设置尺寸（填写设计中设备的屏幕尺寸）
    return ScreenUtilInit(
      designSize: const Size(375, 812 - 44 - 34),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return Scaffold(
          body: Global.isFirstOpen == true
              ? const WelcomePage()
              : Global.isOfflineLogin == true
                  ? const ApplicationPage()
                  : const LoginInPage(),
        );
      },
    );
  }
}
