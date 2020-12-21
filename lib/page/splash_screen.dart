import 'package:flutter/material.dart';
import 'package:music_mobile/common/variable.dart';
import 'package:music_mobile/store/login_info.dart';
import 'package:music_mobile/store/theme_model.dart';
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
  int _color;

  @override
  void initState() {
    super.initState();
    this._getColor();
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

          if (infos != null) {
            _url = '/home_page';
            // _url = '/video_page';
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
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  _getColor() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // ignore: await_only_futures
    int color = await prefs.getInt('color');
    if (color == null) {
      Provider.of<ThemeModel>(context, listen: false).setColor =
          AppColors.IMPORTANT_COLOR;

      setState(() {
        _color = AppColors.IMPORTANT_COLOR;
      });
    } else {
      Provider.of<ThemeModel>(context, listen: false).setColor = color;

      setState(() {
        _color = color;
      });
    }
    _controller.forward(); //播放动画
  }

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    final _width = _size.width;
    final _height = _size.height;
    return _color == null
        ? Container(
            width: _width,
            height: _height,
            color: Color(AppColors.APP_THEME),
            child: null,
          )
        : FadeTransition(
            opacity: _animation,
            child: Container(
              color: Color(_color),
              child: Image.asset(
                'assets/images/logo.png',
                scale: 2.0,
                fit: BoxFit.cover,
              ),
            ),
          );
  }
}
