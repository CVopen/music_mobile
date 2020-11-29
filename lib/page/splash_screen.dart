import 'package:flutter/material.dart';

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
      (status) {
        if (status == AnimationStatus.completed) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            '/login_page',
            // '/home_page',
            (Route<dynamic> route) => false,
          );
        }
      },
    );

    _controller.forward(); //播放动画
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
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
