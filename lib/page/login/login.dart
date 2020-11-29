import 'package:flutter/material.dart';
import 'package:music_mobile/common/variable.dart';

import 'package:music_mobile/page/home/widget/circle_logo.dart';
import 'package:music_mobile/widget/input_widget.dart';

import 'widget/login_way_title.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  int _count = 0;

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    final _width = _size.width;
    final _height = _size.height;
    return GestureDetector(
      onTap: () {
        // 收起键盘
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Container(
        width: _width,
        height: _height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
            colors: [
              Color(0xff5eb680),
              Color(0xff00acb6),
              Color(0xff5340a0),
              Color(0xff5340a7),
            ],
          ),
        ),
        child: SafeArea(
          top: true,
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
                  height: 400,
                  decoration: BoxDecoration(
                    color: Color(AppColors.BACKGROUND_COLOR),
                    borderRadius: BorderRadius.all(
                      Radius.circular(AppSize.BORDER_RADIUS_S),
                    ),
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: AppSize.PADDING_SIZE_S),
                      LoginWayTitle(
                        (value) {
                          setState(() {
                            _count = value;
                          });
                        },
                      ),
                      InputWidget(
                        (value) {
                          print(value);
                        },
                        prefixIcon: Icons.phone_android,
                        placeholder: '请输入您的手机号',
                      ),
                      InputWidget(
                        (value) {
                          print(value);
                        },
                        prefixIcon: Icons.lock,
                        placeholder: '请输入您的密码',
                        isShow: true,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
