import 'dart:math';

import 'package:flutter/material.dart';
import 'package:music_mobile/api/video_page.dart';
import 'package:music_mobile/page/scroll/play_widget.dart';

class ScrollVideo extends StatefulWidget {
  final Map arguments;

  const ScrollVideo({Key key, this.arguments}) : super(key: key);
  @override
  _ScrollVideoState createState() => _ScrollVideoState();
}

class _ScrollVideoState extends State<ScrollVideo> {
  List<String> _list = [];
  List<Widget> _listWidget = [];

  @override
  void initState() {
    super.initState();
    setState(() {
      _list.add(widget.arguments['id']);
      _listWidget.add(PlayWidget(id: widget.arguments['id']));
    });
    _getRelatedVideo(widget.arguments['id']);
  }

  _getRelatedVideo(id) async {
    var res = await ApiVideo().getRelated({'id': id});
    String _id =
        res.data['data'][Random().nextInt(res.data['data'].length - 1)]['vid'];
    setState(() {
      _listWidget.add(PlayWidget(id: _id));
      _list.add(_id);
    });
  }

  @override
  Widget build(BuildContext context) {
    print(_listWidget.length);
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        top: true,
        child: _listWidget.length >= 2
            ? PageView(
                scrollDirection: Axis.vertical,
                onPageChanged: (int index) {
                  if (index == _list.length - 1) {
                    _getRelatedVideo(_list[index]);
                  }
                },
                children: _listWidget,
              )
            : Container(),
      ),
    );
  }
}
