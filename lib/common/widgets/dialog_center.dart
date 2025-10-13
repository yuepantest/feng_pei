
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

dialogSheet(
    {required BuildContext context, required VoidCallback  onCancel,
      required VoidCallback  onConfirm,}) {
  showCupertinoDialog(
    context: context,
    barrierDismissible: true, // 点击空白处关闭
    builder: (context) {
      return CupertinoAlertDialog(
        title: Text('提示'),
        content: Text('你确定要执行此操作吗？'),
        actions: [
          CupertinoDialogAction(
            onPressed: () {
              Navigator.of(context).pop(false); // 取消
              onCancel(); // 触发取消回调
            },
            child: Text('取消'),
            isDefaultAction: false,
          ),
          CupertinoDialogAction(
            onPressed: () {
              Navigator.of(context).pop(true); // 确定
              onConfirm(); // 触发确定回调
            },
            child: Text('确定'),
            isDefaultAction: true,
            textStyle: TextStyle(color: Colors.red), // 红色强调操作
          ),
        ],
      );
    },
  ).then((result) {
    if (result == true) {
      print('用户点击了确定');
    }
  });
}
