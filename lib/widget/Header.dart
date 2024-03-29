import 'package:flutter/material.dart';
import 'package:music_mobile/common/variable.dart';

// 头部
class HeaderWidget extends StatelessWidget {
  final IconData back;
  final Widget content;
  final Widget rightWidget;
  final ValueChanged callback;
  const HeaderWidget({
    Key key,
    @required this.back,
    this.content,
    this.rightWidget,
    this.callback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    return Container(
      height: 50,
      child: Row(
        children: [
          Container(
            height: 50,
            width: 40,
            child: InkWell(
              highlightColor: Colors.transparent,
              radius: 0.0,
              child: Icon(
                back,
                color: Colors.white,
                size: 30,
              ),
              onTap: () {
                if (callback != null) {
                  callback('');
                } else {
                  Navigator.of(context).pop();
                }
              },
            ),
          ),
          Container(
            width: _size.width - 80,
            padding: EdgeInsets.all(AppSize.PADDING_SIZE_S),
            alignment: Alignment.center,
            height: 50,
            child: content,
          ),
          rightWidget == null ? Container(width: 40.0) : rightWidget,
        ],
      ),
    );
  }
}
