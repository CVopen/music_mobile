import 'package:flutter/material.dart';
import '../../../../common/variable.dart';

// 底部弹出框
// ignore: missing_return
Function myShowModalBottomSheet(context, double height, count, callback) {
  showModalBottomSheet(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(AppSize.BORDER_RADIUS),
        topRight: Radius.circular(AppSize.BORDER_RADIUS),
      ),
    ),
    context: context,
    builder: (BuildContext context) {
      return SizedBox(
        height: height,
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(AppSize.PADDING_SIZE_B),
              child: Text(
                '歌单$count首',
                style: const TextStyle(
                  color: Color(AppColors.FONT_COLOR),
                ),
              ),
              width: double.infinity,
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    width: 1,
                    style: BorderStyle.solid,
                    color: Color(0xffEDEDED),
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                return showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      content: Text('确认删除'),
                      actions: <Widget>[
                        FlatButton(
                          child: Text('取消'),
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                        FlatButton(
                          child: Text('确认'),
                          onPressed: () {
                            callback();
                            Navigator.of(context).pop();
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  },
                );
              },
              child: Container(
                padding: const EdgeInsets.only(
                  top: AppSize.PADDING_SIZE_S,
                  bottom: AppSize.PADDING_SIZE_S,
                  left: AppSize.PADDING_SIZE,
                ),
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      width: 1,
                      style: BorderStyle.solid,
                      color: Color(0xffEDEDED),
                    ),
                  ),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.delete,
                      size: 28,
                    ),
                    const SizedBox(width: AppSize.PADDING_SIZE),
                    const Text('删除'),
                  ],
                ),
              ),
            )
          ],
        ),
      );
    },
  );
}
