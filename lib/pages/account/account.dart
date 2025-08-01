import 'package:feng_pei/common/entity/user.dart';
import 'package:feng_pei/common/utils/utils.dart';
import 'package:feng_pei/common/values/values.dart';
import 'package:feng_pei/common/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';
import '../../global.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);
    var profile = Global.profile;
    return Container(child: Column(
        children: [_buildLogo(profile), contentBack(), contentView()]),
      color: AppColors.secondaryElement,);
  }

  Widget contentBack() {
    return Container(
      height: duSetHeight(50),
    );
  }

  Widget contentView() {
    return Container(
      margin: EdgeInsets.only(top: duSetHeight(30)),
      child: Column(
        children: [
          itemView("个人信息", false, "more", "person_information"),
          itemView("软件升级", false, "more", "up_grade"),
          itemView("软件介绍", false, "more", "introduce"),
          itemView("退出登录", true, "more", "exit")
        ],
      ),
    );
  }

  Widget itemView(String title, bool isShowBottom, String str, String icon) {
    Color color =
    isShowBottom ? AppColors.tabBarElement : AppColors.primaryBackground;
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        toastInfo(msg: '由于该功能涉及信息安全，因此暂未开发！');
      },
      child: Container(
        color: AppColors.primaryBackground,
        height: duSetHeight(50),
        child: Column(
          children: [
            const Divider(
              height: 1.0, // 分割线的高度
              thickness: 1.0, // 分割线的厚度
              color: AppColors.secondaryElement, // 分割线的颜色
            ),
            Container(
              margin: EdgeInsets.only(
                  top: duSetHeight(10),
                  left: duSetHeight(10),
                  right: duSetHeight(10)),
              child: Row(
                children: [
                  Image.asset(
                    "assets/images/$icon.png",
                    fit: BoxFit.contain,
                    width: duSetWidth(25),
                  ),
                  Padding(
                    child: Text(
                      title,
                      style: TextStyle(
                        fontWeight: FontWeight.w300,
                        color: AppColors.primaryText,
                        fontSize: duSetFontSize(15),
                      ),
                    ),
                    padding: EdgeInsets.only(left: duSetWidth(15)),
                  ),
                  const Spacer(),
                  Image.asset(
                    "assets/images/$str.png",
                    width: duSetWidth(20),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLogo(UserInform profile) {
    return Container(
      width: duSetWidth(110),
      margin: EdgeInsets.only(top: duSetHeight(0)), // 顶部系统栏 44px
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            height: duSetWidth(76),
            width: duSetWidth(76),
            margin: EdgeInsets.symmetric(horizontal: duSetWidth(15)),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Positioned(
                  left: 0,
                  top: 0,
                  right: 0,
                  child: Container(
                    height: duSetWidth(76),
                    decoration: BoxDecoration(
                      color: AppColors.primaryBackground,
                      boxShadow: const [
                        Shadows.primaryShadow,
                      ],
                      borderRadius: BorderRadius.all(
                          Radius.circular(duSetWidth(76 * 0.5))), // 父容器的50%
                    ),
                    child: Container(),
                  ),
                ),
                Positioned(
                  child: Container(
                    margin: EdgeInsets.only(
                        top: duSetHeight(10), bottom: duSetHeight(10)),
                    child: Image.asset(
                      "assets/images/employee.png",
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: duSetHeight(15)),
            child: Text(
              profile.name,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.primaryText,
                fontFamily: "Montserrat",
                fontWeight: FontWeight.w600,
                fontSize: duSetFontSize(24),
                height: 1,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
