import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:music_mobile/common/variable.dart';

class LoginWayTitle extends StatefulWidget {
  final ValueChanged callback;

  const LoginWayTitle(this.callback, {Key key}) : super(key: key);
  @override
  _LoginWayTitleState createState() => _LoginWayTitleState();
}

class _LoginWayTitleState extends State<LoginWayTitle>
    with SingleTickerProviderStateMixin {
  List _list = ['密码登录', '验证码登录', '邮箱登录'];

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

  _titleWidget() {
    List<Widget> _listWidget = [];
    _list.forEach((element) {
      _listWidget.add(
        Container(
          margin: const EdgeInsets.all(AppSize.PADDING_SIZE_B),
          child: Text.rich(
            TextSpan(
              text: element,
              style: TextStyle(
                fontSize: AppSize.FONT_SIZE_B,
                color: _count == _list.indexOf(element)
                    ? _indexColor
                    : Color(AppColors.FONT_COLOR),
                height: 1,
                decoration: TextDecoration.none,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  _controller.forward(from: 0.0);
                  setState(() {
                    _count = _list.indexOf(element);
                  });
                  widget.callback(_list.indexOf(element));
                },
            ),
          ),
        ),
      );
    });

    return _listWidget;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(LoginWayTitle oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Expanded(child: Text('')),
          ..._titleWidget(),
          Expanded(child: Text('')),
        ],
      ),
    );
  }
}
