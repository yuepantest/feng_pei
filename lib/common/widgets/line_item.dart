import 'package:feng_pei/common/utils/utils.dart';
import 'package:feng_pei/common/values/values.dart';
import 'package:flutter/cupertino.dart';

Widget lineItem(String title, String content) {
  return Row(
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
    ],
  );
}
