import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CircleLogo extends StatefulWidget {
  final String type;
  final String logoUrl;
  final double size;

  const CircleLogo(this.logoUrl, {Key key, this.type, this.size = 26.0})
      : super(key: key);

  @override
  _CircleLogoState createState() => _CircleLogoState();
}

class _CircleLogoState extends State<CircleLogo>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

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
  }

  @override
  Widget build(BuildContext context) {
    if (widget.type == 'me') {
      return CircleAvatar(
        radius: widget.size,
        backgroundImage: NetworkImage(widget.logoUrl),
      );
    } else if (widget.type == 'logo') {
      return RotationTransition(
        turns: _controller,
        child: Container(
          width: 100.0,
          height: 100.0,
          child: SvgPicture.asset(
            "assets/images/logo.svg",
            color: Colors.pink[300],
          ),
        ),
      );
    } else {
      return RotationTransition(
        turns: _controller,
        child: CircleAvatar(
          backgroundImage: NetworkImage(widget.logoUrl),
        ),
      );
    }
  }
}
