import 'package:feng_pei/common/utils/screen.dart';
import 'package:flutter/cupertino.dart';

Widget textBack({
  required double width,
  required double height,
  required Color bgColor,
  required double borderR,
  required Color borderColor,
  double borderWidth = 1,
  required String title,
  required Color fontColor,
}) {
  return Container(
    decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(borderR),
        border: Border.all(
          color: borderColor, // 边框颜色
          width: width,
        )),
    child: Center(
      child: Text(
        title,
        style: TextStyle(fontWeight: FontWeight.w600, color: fontColor),
      ),
    ),
  );
}
