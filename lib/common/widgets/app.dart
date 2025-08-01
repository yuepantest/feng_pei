import 'package:feng_pei/common/utils/utils.dart';
import 'package:feng_pei/common/values/values.dart';
import 'package:flutter/material.dart';

/// 透明背景 AppBar
PreferredSizeWidget transparentAppBar({
  Color? color,
  required BuildContext context,
  Widget? title,
  Widget? leading,
  required List<Widget> actions,
}) {
  return AppBar(
    backgroundColor: color ?? AppColors.buttonStatueZero,
    elevation: 0,
    title: title != null
        ? Center(
            child: title,
          )
        : null,
    leading: leading,
    actions: actions,
  );
}

/// 10像素 Divider
Widget divider10Px({Color bgColor = AppColors.secondaryElement}) {
  return Container(
    height: duSetWidth(10),
    decoration: BoxDecoration(
      color: bgColor,
    ),
  );
}
