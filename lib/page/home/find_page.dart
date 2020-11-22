import 'package:flutter/material.dart';
import 'package:music_mobile/api/home_page.dart';

import 'dart:async';

import 'package:music_mobile/common/variable.dart';

import 'widget/find_page/find_swiper.dart';
import 'widget/find_page/recommend_music.dart';

import 'package:music_mobile/utils/format.dart';

class FindPage extends StatefulWidget {
  @override
  _FindPageState createState() => _FindPageState();
}

class _FindPageState extends State<FindPage>
    with AutomaticKeepAliveClientMixin {
  List swiperList = [];
  List personalizedList = [];

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    // this._getSwiper();
    this._refresh();
  }

  Future _refresh() async {
    setState(() {
      swiperList.clear();
      personalizedList.clear();
    });
    await this._getSwiper();
    await this._getPersonalizedList();
    await Future.delayed(Duration(seconds: 1), () {
      print('我刷新了');
    });
    return;
  }

  Future _getSwiper() async {
    var res = await ApiHome().getBanner(data: {"type": 2});
    setState(() {
      swiperList = res.data['banners'];
    });
  }

  Future _getPersonalizedList() async {
    var res = await ApiHome().getPersonalized({"limit": 10});
    res.data['result'].forEach((item) {
      item['playCount'] = computePlay(item['playCount']);
    });
    setState(() {
      personalizedList = res.data['result'];
    });
  }

  @override
  // ignore: must_call_super
  Widget build(BuildContext context) {
    return RefreshIndicator(
      child: ListView(
        children: [
          // Offstage(
          //   offstage: swiperList.length > 0 ? false : true,
          //   child: FindSwiper(swiperList: swiperList),
          // ),
          FindSwiper(swiperList: swiperList),
          gridIcon(),
          RecommendMusic(personalizedList: personalizedList),
        ],
      ),
      color: Color(AppColors.IMPORTANT_COLOR),
      onRefresh: _refresh,
    );
  }
}

// 中间icon
Widget gridIcon() {
  return Container(
    child: GridView(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 5, //横轴四个子widget
          childAspectRatio: 1.0 //宽高比为1时，子widget
          ),
      children: iconItem(),
    ),
  );
}

// 生成icon
List iconItem() {
  List list = [
    Icons.event_available,
    Icons.assignment,
    Icons.list_alt,
    Icons.wifi_tethering,
    Icons.movie,
  ];
  List text = [
    '每日推荐',
    '歌单',
    '排行榜',
    '电台',
    'MV',
  ];
  List<Widget> widget = [];

  for (var i = 0; i < list.length; i++) {
    widget.add(
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(AppSize.PADDING_SIZE_S),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Color(AppColors.IMPORTANT_COLOR),
            ),
            child: Icon(
              list[i],
              color: Color(AppColors.BACKGROUND_COLOR),
            ),
          ),
          SizedBox(
            height: AppSize.BOX_SIZE_HEIGHT_S,
          ),
          Text(
            text[i],
            style: TextStyle(color: Color(AppColors.FONT_MAIN_COLOR)),
          ),
        ],
      ),
    );
  }

  return widget;
}
