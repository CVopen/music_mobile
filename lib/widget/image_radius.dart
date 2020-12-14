import 'package:flutter/material.dart';

class ImageRadius extends StatelessWidget {
  final String url;
  final double width;
  final double height;
  final double radius;
  final double topLeft;
  final double topRight;
  final double bottomLeft;
  final double bottomRight;
  final bool twoOne;

  const ImageRadius(
    this.url,
    this.width,
    this.height, {
    Key key,
    this.radius = 10,
    this.topLeft = 0,
    this.topRight = 0,
    this.bottomLeft = 0,
    this.bottomRight = 0,
    this.twoOne,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius:
          topLeft > 0 || topRight > 0 || topRight > 0 || bottomRight > 0
              ? BorderRadius.only(
                  topLeft: Radius.circular(topLeft),
                  topRight: Radius.circular(topRight),
                  bottomLeft: Radius.circular(bottomLeft),
                  bottomRight: Radius.circular(bottomRight),
                )
              : BorderRadius.circular(radius),
      child: FadeInImage.assetNetwork(
        width: width,
        height: height,
        fit: BoxFit.fill,
        placeholder: "assets/images/loading.gif",
        image: url + (twoOne == null ? '?param=240y240' : '?param=200y100'),
      ),
    );
  }
}
