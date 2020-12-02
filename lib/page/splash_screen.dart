import 'dart:convert' as convert;

import 'package:flutter/material.dart';
import 'package:music_mobile/store/login_info.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation _animation;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    _animation = Tween(begin: 0.7, end: 1.0).animate(_controller);

    _animation.addStatusListener(
      (status) async {
        if (status == AnimationStatus.completed) {
          String _url = '/login_page';

          SharedPreferences prefs = await SharedPreferences.getInstance();
          // ignore: await_only_futures
          String infos = await prefs.getString('userInfo');
          print(infos);
          if (infos != null) {
            _url = '/home_page';
            Provider.of<LoginInfo>(context, listen: false).loginSet = infos;
          }

          Navigator.pushNamedAndRemoveUntil(
            context,
            _url,
            (Route<dynamic> route) => false,
          );
        }
      },
    );

    _controller.forward(); //播放动画
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animation,
      child: Image.asset(
        'assets/images/logo.png',
        scale: 2.0,
        fit: BoxFit.cover,
      ),
    );
  }
}
