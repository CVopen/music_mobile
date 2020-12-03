import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:music_mobile/common/variable.dart';

import 'package:music_mobile/page/home/widget/circle_logo.dart';
import 'package:music_mobile/page/login/widget/login_way_page.dart';

import 'widget/login_way_title.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  int _count = 0;
  List<Color> _colors = [
    Color(0xff5eb680),
    Color(0xff10a996),
    Color(0xff1eacb6),
    Color(0xff5340a7),
    Color(0xff223590),
    Color(0xff5e0680),
  ];

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    final _width = _size.width;
    final _height = _size.height;
    final _keyHeight = MediaQuery.of(context).viewInsets.bottom; // 获取键盘高度
    final _barHeight = MediaQueryData.fromWindow(window).padding.top; // 获取状态栏高度
    return GestureDetector(
      onTap: () {
        // 收起键盘
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Container(
        width: _width,
        height: _keyHeight + _height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
            colors: _colors,
          ),
        ),
        child: SafeArea(
          top: true,
          child: ListView(
            children: [
              Container(
                height: _keyHeight + _height - _barHeight,
                child: Center(
                  child: Column(
                    children: [
                      CircleLogo(
                        '',
                        type: 'logo',
                        size: 50.0,
                      ),
                      Container(
                        width: _width - 80,
                        height: 330,
                        decoration: BoxDecoration(
                          color: Color(AppColors.BACKGROUND_COLOR),
                          borderRadius: BorderRadius.all(
                            Radius.circular(AppSize.BORDER_RADIUS_S),
                          ),
                        ),
                        child: Column(
                          children: [
                            const SizedBox(height: AppSize.PADDING_SIZE_S),
                            LoginWayTitle(
                              (value) {
                                setState(() {
                                  _count = value;
                                });
                              },
                            ),
                            LoginWayPage(_count),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
