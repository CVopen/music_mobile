import 'package:flutter/material.dart';
import '../../common/variable.dart' show AppSize, AppColors;

import 'widget/circle_logo.dart';

import 'widget/my_page/set_song_list.dart';
import 'widget/my_page/like_music.dart';

class MyPage extends StatefulWidget {
  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  // ignore: must_call_super
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: [
        avatarToLogin(),
        gridIcon(),
        LikeMusic(),
        SetSongList(
          title: '创建歌单',
          total: '暂无创建的歌单',
        ),
        SetSongList(
          title: '收藏歌单',
          total: '暂无收藏的歌单',
        ),
      ],
    );
  }
}

// logo
Widget avatarToLogin() {
  return Container(
    padding: EdgeInsets.all(AppSize.PADDING_SIZE),
    child: InkWell(
      onTap: () {
        print('我是去登录');
      },
      child: Container(
        color: Color(AppColors.APP_THEME),
        child: Row(
          children: [
            CircleLogo(type: 'my'),
            SizedBox(width: AppSize.BOX_SIZE_WIDTH_M),
            Text(
              '立即登录',
              style: TextStyle(
                color: Color(AppColors.FONT_EM_COLOR),
                fontSize: AppSize.FONT_SIZE,
                fontWeight: FontWeight.w500,
              ),
            ),
            Icon(
              Icons.arrow_forward,
              size: 20,
            )
          ],
        ),
      ),
    ),
  );
}

// 中间icon
Widget gridIcon() {
  return Container(
    margin: EdgeInsets.only(
        left: AppSize.PADDING_SIZE, right: AppSize.PADDING_SIZE),
    decoration: BoxDecoration(
      color: Color(AppColors.BACKGROUND_COLOR),
      borderRadius: BorderRadius.all(
        Radius.circular(AppSize.BORDER_RADIUS_S),
      ),
    ),
    child: GridView(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4, //横轴四个子widget
          childAspectRatio: 1.0 //宽高比为1时，子widget
          ),
      children: iconItem(),
    ),
  );
}

// 生成icon
List iconItem() {
  List list = [
    Icons.cloud_download,
    Icons.cloud_upload,
    Icons.check_circle,
    Icons.play_circle_fill,
    Icons.people_alt,
    Icons.star,
    Icons.my_library_music_sharp,
  ];
  List text = [
    '本地音乐',
    '云盘',
    '已购',
    '最近播放',
    '我的好友',
    '收藏',
    '我的电台',
  ];
  List<Widget> widget = [];

  for (var i = 0; i < list.length; i++) {
    widget.add(
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            list[i],
            color: Color(AppColors.IMPORTANT_COLOR),
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
