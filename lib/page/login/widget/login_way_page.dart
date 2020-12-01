import 'dart:async';

import 'package:flutter/material.dart';
import 'package:music_mobile/common/variable.dart';
import 'package:music_mobile/widget/input_widget.dart';
import 'package:music_mobile/api/login_page.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginWayPage extends StatefulWidget {
  final int count;

  const LoginWayPage(this.count, {Key key}) : super(key: key);

  @override
  _LoginWayPageState createState() => _LoginWayPageState();
}

class _LoginWayPageState extends State<LoginWayPage> {
  List _way = [];
  Map _login = {};
  int _time = 60;
  Timer _timer;
  String _text = '发送验证码';
  @override
  void initState() {
    super.initState();
    _way
      ..add({
        'placeholder': '请输入您的手机号',
        'prefixIcon': Icons.phone_android,
        'isShow': null,
        'code': null,
      })
      ..add({
        'placeholder': '请输入您的密码',
        'prefixIcon': Icons.lock,
        'isShow': true,
        'code': null,
      });
  }

  @override
  void dispose() {
    super.dispose();
    _timer?.cancel();
    _timer = null;
  }

  @override
  void didUpdateWidget(LoginWayPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    setState(() {
      _way.clear();
    });
    this._changeWay();
  }

  // 切换登录方式
  _changeWay() {
    switch (widget.count) {
      case 0:
        setState(() {
          _way = _way
            ..add({
              'placeholder': '请输入您的手机号',
              'prefixIcon': Icons.phone_android,
              'isShow': null,
              'code': null,
            })
            ..add({
              'placeholder': '请输入您的密码',
              'prefixIcon': Icons.lock,
              'isShow': true,
              'code': null,
            });
        });
        break;
      case 1:
        setState(() {
          _way = _way
            ..add({
              'placeholder': '请输入您的手机号',
              'prefixIcon': Icons.phone_android,
              'isShow': null,
              'code': null,
            })
            ..add({
              'placeholder': '请输入验证码',
              'prefixIcon': Icons.lock,
              'isShow': null,
              'code': true,
            });
        });
        break;
      case 2:
        setState(() {
          _way = _way
            ..add({
              'placeholder': '请输入您的邮箱',
              'prefixIcon': Icons.email,
              'isShow': null,
              'code': null,
            })
            ..add({
              'placeholder': '请输入您的密码',
              'prefixIcon': Icons.lock,
              'isShow': true,
              'code': null,
            });
        });
        break;
      default:
        return;
    }
  }

  // 登陆
  Future _loginFunc() async {
    var res;
    switch (widget.count) {
      case 0:
        res = await ApiLogin().loginPhone(_login);
        break;
      case 1:
        Fluttertoast.showToast(
          msg: "接口限制，请使用密码登录",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black87,
          textColor: Colors.white,
          fontSize: 14.0,
        );
        return;
        // ignore: dead_code
        res = await ApiLogin().verify(_login);
        break;
      case 2:
        Fluttertoast.showToast(
          msg: "接口限制，请使用密码登录",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black87,
          textColor: Colors.white,
          fontSize: 14.0,
        );
        return;
        // ignore: dead_code
        res = await ApiLogin().login(_login);
        break;
      default:
    }

    print(res.data);
  }

  // 发送验证码
  Future _sendCode(value) async {
    if (_timer != null) return;

    var res = await ApiLogin().sendCode({'phone': _login['phone']});

    if (res.data['data']) {
      Fluttertoast.showToast(
        msg: "发送成功",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black87,
        textColor: Colors.white,
        fontSize: 14.0,
      );
      setState(() {
        _timer = Timer.periodic(Duration(milliseconds: 1000), (timer) {
          setState(() {
            if (_time > 0) {
              _time = _time - 1;
              _text = '剩余$_time秒';
            } else {
              _time = 60;
              _text = '重新获取';
              timer?.cancel();
              _timer = null;
            }
          });
        });
      });
    } else {
      Fluttertoast.showToast(
        msg: "发送失败",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black87,
        textColor: Colors.white,
        fontSize: 14.0,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    final _width = _size.width;
    return Container(
      margin: EdgeInsets.all(AppSize.PADDING_SIZE),
      child: Column(
        children: [
          InputWidget(
            (value) {
              if (widget.count == 2) {
                setState(() {
                  _login['email'] = value;
                });
              } else {
                setState(() {
                  _login['phone'] = value;
                });
              }
            },
            prefixIcon: _way[0]['prefixIcon'],
            placeholder: _way[0]['placeholder'],
            isShow: _way[0]['isShow'],
            code: _way[0]['code'] == true ? _text : null,
          ),
          SizedBox(
            height: 10,
          ),
          InputWidget(
            (value) {
              if (widget.count == 1) {
                setState(() {
                  _login['verify'] = value;
                });
              } else {
                setState(() {
                  _login['password'] = value;
                });
              }
            },
            prefixIcon: _way[1]['prefixIcon'],
            placeholder: _way[1]['placeholder'],
            isShow: _way[1]['isShow'],
            code: _way[1]['code'] == true ? _text : null,
            codeFun: _sendCode,
          ),
          SizedBox(
            height: 50,
          ),
          MaterialButton(
            color: Color(AppColors.IMPORTANT_COLOR),
            shape: RoundedRectangleBorder(
              side: BorderSide.none,
              borderRadius: BorderRadius.all(
                Radius.circular(50),
              ),
            ),
            textColor: Colors.white,
            child: Text('登 录'),
            minWidth: _width - 120,
            onPressed: _loginFunc,
          )
        ],
      ),
    );
  }
}
