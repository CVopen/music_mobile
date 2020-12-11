import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:music_mobile/widget/image_radius.dart';

List<Widget> backFilter(double size, String url) {
  return [
    ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(10),
        topRight: Radius.circular(10),
      ),
      child: BackdropFilter(
        //背景滤镜
        filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3), //背景模糊化
        child: Container(
          alignment: Alignment.center,
          height: size * 1.2,
          width: size,
          color: Colors.grey.withOpacity(0.1),
        ),
      ),
    ),
    Positioned(
      top: 15,
      left: size / 2 - 20,
      child: Container(
        alignment: AlignmentDirectional.center,
        width: 40,
        height: 24,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: const Color.fromRGBO(255, 255, 255, .5),
        ),
        child: const Text(
          'MV',
          style: TextStyle(
            color: Color.fromRGBO(0, 0, 0, .4),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ),
    Positioned(
      top: 54,
      left: 0,
      child: Container(
        margin: const EdgeInsets.only(left: 5, right: 5),
        child: ImageRadius(url, size - 10, (size - 10) / 2.1, radius: 5),
      ),
    ),
  ];
}
