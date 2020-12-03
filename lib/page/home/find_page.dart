import 'package:flutter/material.dart';
import 'package:music_mobile/api/home_page.dart';

import 'dart:async';

import 'package:music_mobile/common/variable.dart';
import 'package:music_mobile/store/theme_model.dart';
import 'package:provider/provider.dart';

import 'widget/find_page/find_swiper.dart';
import 'widget/find_page/container_title.dart';

import 'package:music_mobile/utils/format.dart';

class FindPage extends StatefulWidget {
  @override
  _FindPageState createState() => _FindPageState();
}

class _FindPageState extends State<FindPage>
    with AutomaticKeepAliveClientMixin {
  List swiperList = [];
  List personalizedList = [];
  List albumList = [];
  List topList = [];

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    this._getSwiper();
    this._getPersonalizedList();
    this._getAlbumList();
    this._getTopList();
  }

  Future _refresh() async {
    setState(() {
      swiperList.clear();
      personalizedList.clear();
      albumList.clear();
      topList.clear();
    });
    this._getSwiper();
    this._getPersonalizedList();
    this._getAlbumList();
    this._getTopList();
    await Future.delayed(Duration(seconds: 1), () {
      print('我刷新了');
    });
    return;
  }

  // 获取banner
  Future _getSwiper() async {
    var res = await ApiHome().getBanner(data: {"type": 2});
    setState(() {
      swiperList = res.data['banners'];
    });
  }

  // 获取推荐歌单
  Future _getPersonalizedList() async {
    List count = createArr(10, 30);
    List arr = [];
    var res = await ApiHome().getPersonalized({"limit": 30});
    res.data['result'].forEach((item) {
      item['playCount'] = computePlay(item['playCount']);
    });
    count.forEach((element) {
      arr.add(res.data['result'][element]);
    });
    setState(() {
      personalizedList = arr;
    });
  }

  // 获取新碟
  Future _getAlbumList() async {
    List count = createArr(9, 12);
    List arr = [];
    var res = await ApiHome().getAlbumNewest({"limit": 30});
    count.forEach((item) {
      arr.add(res.data['albums'][item]);
    });
    setState(() {
      albumList = arr;
    });
  }

  // 获取排行榜
  Future _getTopList() async {
    var res = await ApiHome().getTopList();
    List count = createArr(5, 32);
    List arr = [];
    count.forEach((element) {
      arr.add(res.data['list'][element]);
    });
    setState(() {
      topList = arr;
    });
  }

  @override
  // ignore: must_call_super
  Widget build(BuildContext context) {
    return RefreshIndicator(
      child: ListView(
        children: [
          FindSwiper(swiperList: swiperList),
          GridIconWidget(),
          ContainerTitle(
            list: personalizedList,
            title: '推荐歌单',
          ),
          ContainerTitle(
            list: albumList,
            title: '新碟上架',
          ),
          ContainerTitle(
            list: topList,
            title: '排行榜',
          ),
          SizedBox(
            height: 20,
          )
        ],
      ),
      color: Color(Provider.of<ThemeModel>(context, listen: true).getColor),
      onRefresh: _refresh,
    );
  }
}

// ignore: must_be_immutable
class GridIconWidget extends StatelessWidget {
  List list = [
    {'icon': Icons.event_available, 'text': '每日推荐'},
    {'icon': Icons.assignment, 'text': '歌单'},
    {'icon': Icons.list_alt, 'text': '排行榜'},
    {'icon': Icons.wifi_tethering, 'text': '电台'},
  ];
  List _iconItem() {
    List<Widget> widget = [];

    for (var i = 0; i < list.length; i++) {
      widget.add(IconFind(icon: list[i]['icon'], text: list[i]['text']));
    }

    return widget;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GridView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4, //横轴四个子widget
            childAspectRatio: 1.0 //宽高比为1时，子widget
            ),
        children: _iconItem(),
      ),
    );
  }
}

class IconFind extends StatelessWidget {
  final icon;
  final text;

  const IconFind({Key key, this.icon, this.text}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.all(AppSize.PADDING_SIZE_S),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color:
                Color(Provider.of<ThemeModel>(context, listen: true).getColor),
          ),
          child: Icon(
            icon,
            color: Colors.white,
          ),
        ),
        const SizedBox(
          height: AppSize.BOX_SIZE_HEIGHT_S,
        ),
        Text(
          text,
          style: TextStyle(color: Color(AppColors.FONT_MAIN_COLOR)),
        ),
      ],
    );
  }
}
