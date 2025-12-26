import 'package:flutter/material.dart';
import 'package:wheel_picker/wheel_picker.dart';
import '../utils/utils.dart';

bottomSheet(
    {required BuildContext context,
    required ValueChanged<int> onChanged, int? initialIndex=1,
    required List<String> listWeek}) {
  var selectIndex = 1;
  if(initialIndex!=null){
    selectIndex=initialIndex;
  }
  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return SizedBox(
        height: duSetHeight(200),
        child: Stack(
          children: [
            WheelPicker(
              itemCount: listWeek.length,
              initialIndex: initialIndex,
              builder: (context, index) => Text(listWeek[index]),
              selectedIndexColor: Colors.orange,
              looping: false,
              onIndexChanged:
                  (int index, WheelPickerInteractionType interactionType) {
                selectIndex = index;
              },
            ),
            Positioned(
              child: Row(
                children: [
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: SizedBox(
                      width: duSetWidth(80),
                      height: duSetHeight(50),
                      child: const Center(
                        child: Text("取消"),
                      ),
                    ),
                  ),
                  const Spacer(),
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      onChanged(selectIndex);
                      Navigator.pop(context);
                    },
                    child: SizedBox(
                      width: duSetWidth(80),
                      height: duSetHeight(50),
                      child: const Center(
                        child: Text("确定"),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    },
  );
}
