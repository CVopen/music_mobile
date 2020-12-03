import 'package:flutter/material.dart';
import 'package:music_mobile/store/theme_model.dart';
import 'package:provider/provider.dart';
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
        GridIconWidget(),
        LikeMusic(),
        const SetSongList(
          title: '创建歌单',
          total: '暂无创建的歌单',
        ),
        const SetSongList(
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
            const CircleLogo(
              "http://images.shejidaren.com/wp-content/uploads/2014/09/0215109hx.jpg",
              type: 'me',
            ),
            SizedBox(width: AppSize.BOX_SIZE_WIDTH_M),
            const Text(
              '立即登录',
              style: TextStyle(
                color: Color(AppColors.FONT_EM_COLOR),
                fontSize: AppSize.FONT_SIZE,
                fontWeight: FontWeight.w500,
              ),
            ),
            const Icon(
              Icons.arrow_forward,
              size: 20,
            )
          ],
        ),
      ),
    ),
  );
}

// ignore: must_be_immutable
class GridIconWidget extends StatelessWidget {
  List list = [
    {'icon': Icons.cloud_download, 'text': '本地音乐'},
    {'icon': Icons.cloud_upload, 'text': '云盘'},
    {'icon': Icons.check_circle, 'text': '已购'},
    {'icon': Icons.play_circle_fill, 'text': '最近播放'},
    {'icon': Icons.people_alt, 'text': '我的好友'},
    {'icon': Icons.star, 'text': '收藏'},
    {'icon': Icons.my_library_music_sharp, 'text': '我的电台'},
  ];

  List _iconItem() {
    List<Widget> widget = [];

    for (var i = 0; i < list.length; i++) {
      widget.add(IconWidget(
        icon: list[i]['icon'],
        text: list[i]['text'],
      ));
    }

    return widget;
  }

  @override
  Widget build(BuildContext context) {
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
        children: _iconItem(),
      ),
    );
  }
}

class IconWidget extends StatelessWidget {
  final icon;
  final text;

  const IconWidget({Key key, this.icon, this.text}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          icon,
          color: Color(Provider.of<ThemeModel>(context, listen: true).getColor),
        ),
        SizedBox(
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
