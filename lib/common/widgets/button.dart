import 'package:feng_pei/common/utils/utils.dart';
import 'package:feng_pei/common/values/values.dart';
import 'package:flutter/material.dart';

/// 扁平圆角按钮
Widget btnFlatButtonWidget({
  required VoidCallback onPressed,
  double width = 140,
  double height = 44,
  Color gbColor = AppColors.primaryElement,
  String title = "button",
  Color fontColor = AppColors.primaryElementText,
  double fontSize = 18,
  String fontName = "Montserrat",
  FontWeight fontWeight = FontWeight.w400,
}) {
  return SizedBox(
    width: duSetWidth(width),
    height: duSetHeight(height),
    child: ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: gbColor,
        shape: const RoundedRectangleBorder(
          borderRadius: Radii.k6pxRadius,
        ),
      ),
      child: Text(
        title,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: fontColor,
          fontFamily: fontName,
          fontWeight: fontWeight,
          fontSize: duSetFontSize(fontSize),
          height: 1,
        ),
      ),
    ),
  );
}

Widget myButton(
    {required VoidCallback onPressed,
    required double height,
    double width = 0,
    required double cornerRadius,
    required Color gbColor,
    Color sideColor = AppColors.transparency,
    required String title,
    required Color fontColor,
    required double fontSize}) {
  return width == 0
      ? SizedBox(
          height: height,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: gbColor,
              // 设置按钮的背景色
              foregroundColor: fontColor,
              // 设置按钮的前景色（文本颜色）
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(cornerRadius)),
              // 形状
              shadowColor: Colors.transparent,
              // 去掉阴影
              elevation: 0,
              side: BorderSide(
                // 设置边框
                color: sideColor,
                width: 1,
              ),
            ),
            onPressed: onPressed,
            child: IntrinsicWidth(
              child: Text(
                title,
                style:
                    TextStyle(fontSize: fontSize, fontWeight: FontWeight.w600),
              ),
            ),
          ),
        )
      : SizedBox(
          height: height,
          width: width,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: gbColor, // 设置按钮的背景色
              foregroundColor: fontColor, // 设置按钮的前景色（文本颜色）
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(cornerRadius)), // 形状
              elevation: 2, // 阴影高度
            ),
            onPressed: onPressed,
            child: IntrinsicWidth(
              child: Text(
                title,
                style:
                    TextStyle(fontSize: fontSize, fontWeight: FontWeight.w600),
              ),
            ),
          ),
        );
}

Widget containerButton({required double width,
  required double height,
  required double cornerRadius,
  required Color gbColor,
  required String title,
  required Color fontColor,
  required double fontSize,}

) {
  return GestureDetector(
    behavior: HitTestBehavior.opaque,
    child: Container(
      alignment: Alignment.center,
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: gbColor,
        borderRadius: BorderRadius.all(Radius.circular(cornerRadius)),
      ),
      child: Text(
        title,
        style: TextStyle(color: fontColor, fontSize: fontSize,fontWeight: FontWeight.bold),
      ),
    ),
    onTap: () {},
  );
}
