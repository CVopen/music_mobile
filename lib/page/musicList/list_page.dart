import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:music_mobile/widget/Header.dart';

class MusicListPage extends StatefulWidget {
  final arguments;

  const MusicListPage({Key key, this.arguments}) : super(key: key);
  @override
  _MusicListPageState createState() => _MusicListPageState();
}

class _MusicListPageState extends State<MusicListPage> {
  @override
  Widget build(BuildContext context) {
    final _barHeight = MediaQueryData.fromWindow(window).padding.top; // 获取状态栏高度
    final _size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                height: 200,
                width: _size.width,
                child: FadeInImage.assetNetwork(
                  placeholder: 'assets/images/audio_bg.jpg',
                  image:
                      'http://p2.music.126.net/chniRNXvDaCCpCJZ7uVYug==/109951165541304779.jpg',
                  fit: BoxFit.fill,
                ),
              ),
              Positioned(
                top: _barHeight,
                child: HeaderWidget(
                  back: Icons.keyboard_backspace,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
