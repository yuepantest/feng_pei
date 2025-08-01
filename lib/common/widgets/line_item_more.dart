import 'package:feng_pei/common/utils/utils.dart';
import 'package:feng_pei/common/values/values.dart';
import 'package:flutter/cupertino.dart';

Widget lineItemMore(String title, String content, VoidCallback callback) {
  return GestureDetector(
    behavior: HitTestBehavior.opaque,
    onTap: () {
      callback();
    },
    child: Row(
      children: [
        Text(
          title,
          style: TextStyle(
              color: AppColors.thirdElementText, fontSize: duSetFontSize(13)),
        ),
        const Spacer(),
        Text(
          content,
          style: TextStyle(
            color: AppColors.thirdElement,
            fontSize: duSetFontSize(13),
          ),
        ),
        Image.asset(
          "assets/images/more.png",
          fit: BoxFit.contain,
          width: duSetWidth(16),
        ),
      ],
    ),
  );
}
