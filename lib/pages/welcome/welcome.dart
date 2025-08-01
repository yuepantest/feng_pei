import 'package:feng_pei/common/utils/utils.dart';
import 'package:feng_pei/common/values/values.dart';
import 'package:flutter/material.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            _buildPageHeadTitle(),
            _buildPageHeaderDetail(),
            _buildFeatureItem(
                "feature-1",
                "Compelling photography and typography provide a beautiful reading",
                86),
            _buildFeatureItem(
                "feature-2",
                "Sector news never shares your personal data with advertisers or publishers",
                40),
            _buildFeatureItem("feature-3",
                "You can get Premium to unlock hundreds of publications", 40),
            const Spacer(),
            _buildStartButton(context),
          ],
        ),
      ),
    );
  }
}

Widget _buildPageHeadTitle() {
  return Container(
      margin: EdgeInsets.only(top: duSetHeight(65)),
      child: Text(
        "丰沛金融",
        textAlign: TextAlign.center,
        style: TextStyle(
          // color: AppColors.primaryText,
          fontFamily: "Montserrat",
          fontWeight: FontWeight.w600,
          fontSize: duSetFontSize(24),
        ),
      ));
}

Widget _buildPageHeaderDetail() {
  return Container(
      width: duSetWidth(242),
      height: duSetHeight(70),
      margin: EdgeInsets.only(top: duSetHeight(14)),
      child: Text(
        "The best of news channels all in one place. Trusted sources and personalized news for you.",
        textAlign: TextAlign.center,
        style: TextStyle(
            height: 1.3,
            color: AppColors.primaryText,
            fontSize: duSetFontSize(16),
            fontFamily: "Avenir",
            fontWeight: FontWeight.normal),
      ));
}

Widget _buildFeatureItem(String imageName, String intro, double marginTop) {
  return Container(
    alignment: Alignment.center,
    width: duSetWidth(295),
    height: duSetHeight(80),
    margin: EdgeInsets.only(top: duSetHeight(marginTop)),
    child: Row(
      children: <Widget>[
        SizedBox(
          width: duSetWidth(80),
          height: duSetWidth(80),
          child: Image.asset(
            "assets/images/$imageName.png",
            fit: BoxFit.none,
          ),
        ),
        const Spacer(),
        SizedBox(
          width: duSetWidth(195),
          child: Text(
            intro,
            textAlign: TextAlign.left,
            style: TextStyle(
              color: AppColors.primaryText,
              fontFamily: "Avenir",
              fontWeight: FontWeight.normal,
              fontSize: duSetFontSize(16),
            ),
          ),
        )
      ],
    ),
  );
}

Widget _buildStartButton(BuildContext context) {
  return Container(
    width: duSetWidth(295),
    height: duSetHeight(44),
    margin: EdgeInsets.only(bottom: duSetHeight(20)),
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryElement,
        shape: const RoundedRectangleBorder(borderRadius: Radii.k6pxRadius),
        foregroundColor: AppColors.primaryElementText,
      ),
      child: const Text("开 始"),
      onPressed: () {
        Navigator.pushReplacementNamed(context, "/login-in");
      },
    ),
  );
}
