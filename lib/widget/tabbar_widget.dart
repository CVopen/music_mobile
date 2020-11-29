import 'package:flutter/material.dart';
import 'package:music_mobile/common/variable.dart';

class TabbarWidget extends StatefulWidget {
  final ValueChanged<int> callback;
  const TabbarWidget({Key key, this.callback}) : super(key: key);

  @override
  _TabbarWidgetState createState() => _TabbarWidgetState();
}

class _TabbarWidgetState extends State<TabbarWidget>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation _animation;
  Color _indexColor = Colors.red;
  int _count = 0;
  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    _animation = ColorTween(
      begin: Color(AppColors.FONT_COLOR),
      end: Color(AppColors.FONT_EM_COLOR),
    ).animate(_controller);
    _animation.addListener(() {
      this.setState(() {
        _indexColor = _animation.value;
      });
    });
    _animation.addStatusListener(
      (status) {},
    );
    _controller.forward();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 10,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            child: Container(
              margin: EdgeInsets.only(
                left: AppSize.PADDING_SIZE_B,
                right: AppSize.PADDING_SIZE_B,
              ),
              child: Center(
                child: Text(
                  '我是第$index 个儿子',
                  style: TextStyle(
                    fontSize: AppSize.FONT_SIZE_B,
                    color: _count == index
                        ? _indexColor
                        : Color(AppColors.FONT_COLOR),
                    height: 1,
                    decoration: TextDecoration.none,
                  ),
                ),
              ),
            ),
            onTap: () {
              _controller.forward(from: 0.0);
              print('点击了');
              setState(() {
                _count = index;
              });
              widget.callback(index);
            },
          );
        },
      ),
    );
  }
}
