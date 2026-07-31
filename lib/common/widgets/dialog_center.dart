import 'package:feng_pei/common/utils/screen.dart';
import 'package:feng_pei/common/values/colors.dart';
import 'package:feng_pei/common/widgets/toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

dialogSheet({
  required BuildContext context,
  required VoidCallback onCancel,
  required VoidCallback onConfirm,
}) {
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

dialogSheetContent(
    {required BuildContext context,
    required VoidCallback onCancel,
    required VoidCallback onConfirm,
    required String content,
    required String title}) {
  showCupertinoDialog(
    context: context,
    barrierDismissible: true, // 点击空白处关闭
    builder: (context) {
      return CupertinoAlertDialog(
        title: Text(
          title,
          style: TextStyle(fontSize: duSetFontSize(16)),
        ),
        content: Padding(
          padding: EdgeInsets.only(top: duSetHeight(15)),
          child: Container(
            width: double.infinity, // 占满宽度
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.transparency),
            ),
            child: Text(
              content,
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontSize: duSetFontSize(14), height: duSetHeight(2)),
            ),
          ),
        ),
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

dialogInput({
  required BuildContext context,
  required VoidCallback onCancel,
  required String contentHint,
  required int maxMoneyCont,
  required Function(int value) onConfirm,
}) {
  TextEditingController controller = TextEditingController();

  FocusNode focusNode = FocusNode();

  showCupertinoDialog(
    context: context,
    barrierDismissible: true,
    builder: (context) {
      // 自动获取焦点
      Future.delayed(
        const Duration(milliseconds: 300),
        () {
          focusNode.requestFocus();
        },
      );
      return CupertinoAlertDialog(
        title: const Text('输入借款金额'),
        content: Padding(
          padding: const EdgeInsets.only(top: 15),
          child: SizedBox(
            height: 45,
            child: CupertinoTextField(
              controller: controller,
              focusNode: focusNode,
              placeholder: contentHint,
              // 数字键盘
              keyboardType: TextInputType.number,
              // 只能输入数字
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
              style: const TextStyle(
                fontSize: 16,
                color: CupertinoColors.black,
              ),
              cursorColor: CupertinoColors.activeBlue,
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 10,
              ),
              decoration: BoxDecoration(
                color: AppColors.primaryBackground,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
        actions: [
          CupertinoDialogAction(
            onPressed: () {
              Navigator.of(context).pop();
              onCancel();
            },
            child: const Text('取消'),
            isDefaultAction: false,
          ),
          CupertinoDialogAction(
            onPressed: () {
              String value = controller.text;
              if (value == null || value == "") {
                toastInfo(msg: "请输入你需要借款金额");
              } else {
                var tryParse = int.tryParse(value);
                if (tryParse == null) {
                  toastInfo(msg: "请输入你需要借款金额");
                } else if (tryParse < 20000) {
                  toastInfo(msg: "最低借款不得低于20000");
                } else if (tryParse > maxMoneyCont) {
                  toastInfo(msg: "额度超过可借金额");
                } else {
                  Navigator.of(context).pop();
                  onConfirm(tryParse);
                }
              }
            },
            child: const Text('确定'),
            isDefaultAction: true,
            textStyle: const TextStyle(
              color: Colors.red,
            ),
          ),
        ],
      );
    },
  );
}
