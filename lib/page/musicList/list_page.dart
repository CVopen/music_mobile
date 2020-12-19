import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:music_mobile/api/music_list_page.dart';
import 'package:music_mobile/common/variable.dart';
import 'package:music_mobile/page/audio/audio_widget.dart';
import 'package:music_mobile/page/musicList/all_mask.dart';
import 'package:music_mobile/page/musicList/list_item.dart';
import 'package:music_mobile/widget/Header.dart';

import 'list_info.dart';

class MusicListPage extends StatefulWidget {
  final Map arguments;

  const MusicListPage({Key key, this.arguments}) : super(key: key);
  @override
  _MusicListPageState createState() => _MusicListPageState();
}

class _MusicListPageState extends State<MusicListPage> {
  Map _playListInfo = {
    'coverImgUrl':
        'http://p1.music.126.net/fWQ5EX9BDCvuaKqtZoYs3A==/109951165425855499.jpg'
  };
  List _list = [];

  @override
  void initState() {
    super.initState();
    if (widget.arguments['id'] == null) {
      this._getRecommendList();
    } else {
      this._getMusicList();
    }
  }

  _getMusicList() async {
    var res = await ApiList().getListDetail({'id': widget.arguments['id']});
    setState(() {
      _playListInfo['name'] = res.data['playlist']['name'];
      _playListInfo['coverImgUrl'] = res.data['playlist']['coverImgUrl'];
      _playListInfo['description'] = res.data['playlist']['description'];
      _playListInfo['playCount'] = res.data['playlist']['playCount'];
      _playListInfo['commentCount'] = res.data['playlist']['commentCount'];
      _playListInfo['subscribedCount'] =
          res.data['playlist']['subscribedCount'];
      _playListInfo['creator'] = res.data['playlist']['creator'];

      _list = res.data['playlist']['tracks'];
    });
  }

  _getRecommendList() async {
    var res = await ApiList().getListRecommend();
    setState(() {
      _list = res.data['data']['dailySongs'];
    });
  }

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
                width: _size.width,
                height: _size.width / 1.5,
                child: _playListInfo['coverImgUrl'] != null
                    ? FadeInImage.assetNetwork(
                        placeholder: 'assets/images/audio_bg.jpg',
                        image: _playListInfo['coverImgUrl'],
                        fit: BoxFit.fill,
                      )
                    : null,
              ),
              Mask(),
              Positioned(
                top: _barHeight,
                child: HeaderWidget(
                  back: Icons.keyboard_backspace,
                  content: Text(
                    widget.arguments['title'],
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: AppSize.FONT_SIZE_B,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: _barHeight + 60,
                height: _size.width / 1.5 - 75 - _barHeight,
                width: _size.width,
                child: _playListInfo['playCount'] == null
                    ? const DayInfo()
                    : ListInfo(info: _playListInfo),
              ),
            ],
          ),
          AllPlay(count: _list.length),
          Expanded(
            child: MediaQuery.removePadding(
              context: context,
              removeTop: true,
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return MusicListItem(item: _list[index]);
                },
                itemCount: _list.length,
                itemExtent: 50.0 + AppSize.PADDING_SIZE_B * 2,
              ),
            ),
          ),
          MusicWidget()
        ],
      ),
    );
  }
}
