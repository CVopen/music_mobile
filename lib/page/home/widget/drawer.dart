import 'package:flutter/material.dart';
import '../../../common/variable.dart';

// drawer 抽屉控制
class DrawerWidget extends StatefulWidget {
  @override
  _DrawerWidgetState createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;
    final double statusBarHeight = MediaQuery.of(context).padding.top; // 状态栏高度
    return Container(
      color: Color(AppColors.BACKGROUND_COLOR),
      width: width * 0.9,
      height: height,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: statusBarHeight,
          ),
          Text('sdfsdfsdfsdfs')
        ],
      ),
    );
  }
}
