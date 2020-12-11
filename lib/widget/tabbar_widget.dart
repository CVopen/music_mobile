import 'package:flutter/material.dart';
import 'package:music_mobile/common/variable.dart';

class TabbarWidget extends StatefulWidget {
  final ValueChanged<int> callback;
  final int color;
  final List title;
  final int index;
  const TabbarWidget({
    Key key,
    @required this.callback,
    @required this.color,
    @required this.title,
    @required this.index,
  }) : super(key: key);

  @override
  _TabbarWidgetState createState() => _TabbarWidgetState();
}

class _TabbarWidgetState extends State<TabbarWidget>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation _animation;
  Color _indexColor = Colors.red;

  Animation _animation2;
  Color _indexColor2 = Colors.red;
  int _end;

  int _count = 0;
  ScrollController _controllerScorll = ScrollController();
  GlobalKey _key = GlobalKey();
  double _itemWidth;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    this._setAnimation();
    _controllerScorll.addListener(() {
      // print(_controllerScorll.offset); //打印滚动位置
    });
  }

  @override
  void didUpdateWidget(TabbarWidget oldWidget) {
    super.didUpdateWidget(oldWidget);

    this._srcollTab();
    if (widget.color == _end) {
      setState(() {
        _count = widget.index;
        _controller.forward(from: 0.0);
      });
    } else {
      this._setAnimation();
    }
  }

  _setAnimation() {
    setState(() {
      _end = widget.color;
      _indexColor2 = Color(widget.color);
    });
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

    _animation2 = ColorTween(
      begin: Color(AppColors.APP_THEME),
      end: Color(_end),
    ).animate(_controller);
    _animation2.addListener(() {
      this.setState(() {
        _indexColor2 = _animation2.value;
      });
    });
    _animation2.addStatusListener(
      (status) {},
    );
    _controller.forward();
  }

  _srcollTab() {
    // 通过key拿到widget
    RenderBox box = _key.currentContext.findRenderObject();
    if (_itemWidth == null) {
      // 获得平均单个tab的宽度
      setState(() {
        _itemWidth =
            (box.size.width + _controllerScorll.position.maxScrollExtent) /
                widget.title.length;
      });
    }

    if (widget.index > _count) {
      // 当向右滑动时
      // 当前widget应在位置减去视口位置 = 滑动量
      if (widget.index * _itemWidth > box.size.width / 2) {
        _controllerScorll.animateTo(
          widget.index * _itemWidth - box.size.width / 2,
          duration: Duration(milliseconds: 300),
          curve: Curves.ease,
        );
      }
    } else {
      // 左滑
      // 当前widget应在lv中位置减去 lv的一半等于滑动量
      if ((box.size.width + _controllerScorll.position.maxScrollExtent) / 2 >
          widget.index * _itemWidth) {
        _controllerScorll.animateTo(
          widget.index * _itemWidth -
              (box.size.width + _controllerScorll.position.maxScrollExtent) / 2,
          duration: Duration(milliseconds: 300),
          curve: Curves.ease,
        );
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      child: ListView.builder(
        key: _key,
        scrollDirection: Axis.horizontal,
        itemCount: widget.title.length,
        controller: _controllerScorll,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            child: Stack(
              children: [
                Opacity(
                  opacity: .3,
                  child: Container(
                    margin: const EdgeInsets.all(AppSize.PADDING_SIZE_S),
                    padding: const EdgeInsets.all(AppSize.PADDING_SIZE_B),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color:
                          _count == index ? _indexColor2 : Colors.transparent,
                    ),
                    child: Center(
                      child: Text(
                        widget.title[index],
                        style: TextStyle(
                          fontSize: AppSize.FONT_SIZE_B,
                          color: Colors.transparent,
                          height: 1,
                          decoration: TextDecoration.none,
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(AppSize.PADDING_SIZE_S),
                  padding: const EdgeInsets.all(AppSize.PADDING_SIZE_B),
                  child: Center(
                    child: Text(
                      widget.title[index],
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
                )
              ],
            ),
            onTap: () {
              _controller.forward(from: 0.0);
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
