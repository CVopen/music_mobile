import 'dart:ui';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:music_mobile/api/video_page.dart';
import 'package:music_mobile/common/variable.dart';
import 'package:music_mobile/page/video/simi_list.dart';
import 'package:music_mobile/page/video/video_comment.dart';
import 'package:music_mobile/page/video/video_ui.dart';
import 'package:flutter/material.dart';
import 'package:music_mobile/store/theme_model.dart';
import 'package:provider/provider.dart';

class VideoPage extends StatefulWidget {
  final Map arguments;

  const VideoPage({Key key, this.arguments}) : super(key: key);
  @override
  _VideoPageState createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  bool _show = false;
  Map _router = {};
  List _list = [];

  int _id;

  @override
  void initState() {
    super.initState();
    setState(() {
      _id = widget.arguments['id'];
      _router['name'] = widget.arguments['name'];
    });
    _getUrl(widget.arguments['id']);
  }

  //获取url
  _getUrl(id) async {
    var res = await ApiVideo().getMvUrl({'id': id});
    setState(() {
      _id = id;
      if (res.data['data']['url'] != null) {
        _router['url'] = res.data['data']['url'];
        _getSimi(id);
      } else {
        Fluttertoast.showToast(
          msg: res.data['data']['msg'],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black87,
          textColor: Colors.white,
          fontSize: 14.0,
        );
      }
    });
  }

  // 获取相似
  _getSimi(id) async {
    var res = await ApiVideo().getSimiMv({'mvid': id});
    setState(() {
      _list = res.data['mvs'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _show
          ? Colors.black
          : Color(Provider.of<ThemeModel>(context, listen: false).getColor)
              .withOpacity(.9),
      body: SafeArea(
        top: true,
        left: true,
        bottom: true,
        right: true,
        child: Stack(
          children: [
            Column(
              children: [
                _router['url'] != null
                    ? VideoUi(
                        callback: (show) {
                          setState(() {
                            _show = show;
                          });
                        },
                        router: _router,
                      )
                    : Container(),
                Expanded(
                  child: Offstage(
                    offstage: _show,
                    child: Container(
                      width: double.infinity,
                      color: Colors.white,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(10),
                            child: Text(
                              '相关推荐',
                              style: TextStyle(
                                  color: Color(AppColors.FONT_MAIN_COLOR),
                                  fontWeight: FontWeight.bold,
                                  height: 1),
                            ),
                          ),
                          SimiList(
                            itemList: _list,
                            callback: (int value) {
                              if (_id != value) {
                                _getUrl(value);
                              }
                            },
                          ),
                          Padding(
                            padding: EdgeInsets.only(bottom: 10, left: 10),
                            child: Text(
                              '评论',
                              style: TextStyle(
                                  color: Color(AppColors.FONT_MAIN_COLOR),
                                  fontWeight: FontWeight.bold,
                                  height: 1),
                            ),
                          ),
                          Expanded(child: Comment())
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
