import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:music_mobile/api/music_list_page.dart';
import 'package:music_mobile/common/variable.dart';
import 'package:music_mobile/page/audio/audio_widget.dart';
import 'package:music_mobile/store/theme_model.dart';
import 'package:music_mobile/utils/format.dart';
import 'package:music_mobile/widget/Header.dart';
import 'package:music_mobile/widget/image_radius.dart';
import 'package:provider/provider.dart';

class MusicListPage extends StatefulWidget {
  final Map arguments;

  const MusicListPage({Key key, this.arguments}) : super(key: key);
  @override
  _MusicListPageState createState() => _MusicListPageState();
}

class _MusicListPageState extends State<MusicListPage> {
  Map _playListInfo = {};
  List _list = [];

  @override
  void initState() {
    super.initState();
    print(widget.arguments['id']);
    this._getMusicList();
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
              Mask(size: _size),
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
                child: _playListInfo.isEmpty
                    ? Text('')
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

class AllPlay extends StatelessWidget {
  final int count;

  const AllPlay({
    Key key,
    this.count = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: Colors.transparent,
      radius: 0.0,
      onTap: () {
        print('播放');
      },
      child: Padding(
        padding: EdgeInsets.all(AppSize.PADDING_SIZE_B),
        child: Row(
          children: [
            Container(
              margin: EdgeInsets.only(right: AppSize.PADDING_SIZE_B),
              decoration: BoxDecoration(
                color: Color(
                    Provider.of<ThemeModel>(context, listen: false).getColor),
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(3),
                child: const Icon(
                  Icons.play_arrow,
                  size: 18.0,
                  color: Colors.white,
                ),
              ),
            ),
            Text(
              '播放全部 ($count)',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ListInfo extends StatelessWidget {
  final Map info;
  const ListInfo({
    Key key,
    @required this.info,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20),
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.black.withOpacity(.2),
      ),
      child: Column(
        children: [
          Text(
            info['name'],
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: const TextStyle(
              color: Colors.white,
              fontSize: AppSize.FONT_SIZE,
              fontWeight: FontWeight.bold,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ImageRadius(info['creator']['avatarUrl'], 25, 25, radius: 12.5),
              SizedBox(width: 5),
              Text(
                info['creator']['nickname'],
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: AppSize.FONT_SIZE_M,
                  height: 1,
                ),
              ),
              SizedBox(width: 5),
              InkWell(
                highlightColor: Colors.transparent,
                radius: 0.0,
                onTap: () {
                  print('播放');
                },
                child: Container(
                  padding: EdgeInsets.only(left: 5, right: 5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.grey.withOpacity(.4),
                  ),
                  child: Icon(
                    Icons.add,
                    size: 16,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: Text(
              info['description'],
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Colors.white,
                fontSize: AppSize.FONT_SIZE_M,
                height: 1,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 20, right: 20, bottom: 10),
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              color: Colors.white.withOpacity(.2),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: (_size.width - 100) / 3,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.play_arrow, color: Colors.white),
                      SizedBox(width: AppSize.BOX_SIZE_WIDTH_S),
                      Text(
                        computePlay(info['commentCount']),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: AppSize.FONT_SIZE_M,
                          height: 1,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: (_size.width - 100) / 3,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.sms, color: Colors.white),
                      SizedBox(width: AppSize.BOX_SIZE_WIDTH_S),
                      Text(
                        computePlay(info['commentCount']),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: AppSize.FONT_SIZE_M,
                          height: 1,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: (_size.width - 100) / 3,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.add, color: Colors.white),
                      SizedBox(width: AppSize.BOX_SIZE_WIDTH_S),
                      Text(
                        computePlay(info['subscribedCount']),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: AppSize.FONT_SIZE_M,
                          height: 1,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class Mask extends StatelessWidget {
  const Mask({
    Key key,
    @required Size size,
  })  : _size = size,
        super(key: key);

  final Size _size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: _size.width,
      height: _size.width / 2,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFF090e42).withOpacity(0.8),
            Color(0xFFfd5f74).withOpacity(0.6)
          ],
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
        ),
      ),
    );
  }
}

class MusicListItem extends StatelessWidget {
  final Map item;
  const MusicListItem({
    Key key,
    @required this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppSize.PADDING_SIZE_B),
      child: InkWell(
        highlightColor: Colors.transparent,
        radius: 0.0,
        onTap: () {
          print('播放');
        },
        child: Row(
          children: [
            ImageRadius(item['al']['picUrl'], 50, 50),
            const SizedBox(width: AppSize.PADDING_SIZE_S),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(AppSize.PADDING_SIZE_S),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item['name'],
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: const TextStyle(
                        fontSize: AppSize.FONT_SIZE_B,
                        height: 1,
                        color: Color(
                          AppColors.FONT_MAIN_COLOR,
                        ),
                      ),
                    ),
                    Text(
                      item['ar'][0]['name'],
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: const TextStyle(
                        fontSize: AppSize.FONT_SIZE_M,
                        color: Color(
                          AppColors.FONT_COLOR,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            InkWell(
              highlightColor: Colors.transparent,
              radius: 0.0,
              child: const Icon(
                Icons.live_tv,
                color: Color(AppColors.FONT_COLOR),
              ),
              onTap: () {},
            ),
            const SizedBox(width: AppSize.BOX_SIZE_WIDTH_B),
            InkWell(
              highlightColor: Colors.transparent,
              radius: 0.0,
              child: const Icon(
                Icons.more_vert,
                color: Color(AppColors.FONT_COLOR),
              ),
              onTap: () {
                print('点击打开歌单');
              },
            ),
          ],
        ),
      ),
    );
  }
}
