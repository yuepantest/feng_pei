import 'package:feng_pei/common/values/values.dart';
import 'package:flutter/material.dart';
import 'package:wheel_picker/wheel_picker.dart';
import '../utils/utils.dart';

centerSheet(
    {required BuildContext context,}) {
  showDialog(
    context: context,
    barrierDismissible: true, // 点击空白处关闭
    builder: (context) {
      return Dialog(
        backgroundColor: Colors.transparent, // 背景透明
        child: Container(
          padding: EdgeInsets.all(duSetWidth(15)),
          decoration: BoxDecoration(
            color: AppColors.secondX,
            borderRadius: BorderRadius.circular(10),
          ),
          width: duSetWidth(250),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 30),
              Text('1.客户资质评估', style: TextStyle(fontSize: 12)),
              SizedBox(height: 10),
              Image.asset(
                "assets/images/arrow-down.png",
                fit: BoxFit.contain,
                width: duSetWidth(30),
                height: duSetHeight(30),
              ),
              SizedBox(height: 10),
              Text('2.准备材料进件', style: TextStyle(fontSize: 12)),
              SizedBox(height: 10),
              Image.asset(
                "assets/images/arrow-down.png",
                fit: BoxFit.contain,
                width: duSetWidth(30),
                height: duSetHeight(30),
              ),
              SizedBox(height: 10),
              Text('3.审核（资料提交后会有审核人员受理审核）',textAlign: TextAlign.center, style: TextStyle(fontSize: 12)),
              SizedBox(height: 10),
              Image.asset(
                "assets/images/arrow-down.png",
                fit: BoxFit.contain,
                width: duSetWidth(30),
                height: duSetHeight(30),
              ),
              SizedBox(height: 10),
              Text('4.通过线上/线下签署借款合同', style: TextStyle(fontSize: 12)),
              SizedBox(height: 10),
              Image.asset(
                "assets/images/arrow-down.png",
                fit: BoxFit.contain,
                width: duSetWidth(30),
                height: duSetHeight(30),
              ),
              SizedBox(height: 10),
              Text('5.成功放款', style: TextStyle(fontSize: 12)),
              SizedBox(height: 20),
              ElevatedButton(
                style:ElevatedButton.styleFrom(
                  backgroundColor: AppColors.buttonStatueKXD, // 设置按钮的背景色

                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(duSetWidth(50))), // 形状
                  shadowColor: Colors.transparent,     // 去掉阴影
                  elevation: 0,

                ),
                onPressed: () => Navigator.of(context).pop(),
                child: Text('关闭',style: TextStyle(color: AppColors.primaryBackground),),
              ),
            ],
          ),
        ),
      );
    },
  );
}
