import 'package:flutter/material.dart';

class CircleLogo extends StatefulWidget {
  @override
  _CircleLogoState createState() => _CircleLogoState();
}

class _CircleLogoState extends State<CircleLogo>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  String logoUrl;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 10),
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _controller.reset();
          _controller.forward();
        }
      });
    _controller.forward();
    logoUrl =
        'http://images.shejidaren.com/wp-content/uploads/2014/09/0215109hx.jpg';
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: _controller,
      child: CircleAvatar(
        backgroundImage: NetworkImage(logoUrl),
      ),
    );
  }
}
