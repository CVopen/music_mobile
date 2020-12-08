import 'package:flutter/material.dart';

class ImageRadius extends StatelessWidget {
  final String url;
  final double width;
  final double height;
  final double radius;

  const ImageRadius(this.url, this.width, this.height,
      {Key key, this.radius = 10})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: FadeInImage.assetNetwork(
        width: width,
        height: height,
        fit: BoxFit.fill,
        placeholder: "assets/images/loading.gif",
        image: url + '?param=150y150',
      ),
    );
  }
}
