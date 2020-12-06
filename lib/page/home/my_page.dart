import 'package:flutter/material.dart';
import 'package:music_mobile/api/home_page.dart';
import 'package:music_mobile/store/login_info.dart';
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
  int _level;

  @override
  void initState() {
    super.initState();
    this._getLevel();
  }

  _getLevel() {
    ApiHome().getLevel().then((res) {
      setState(() {
        _level = res.data['data']['level'];
      });
    });
  }

  @override
  // ignore: must_call_super
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: [
        AvatarToLogin(level: _level),
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

class AvatarToLogin extends StatelessWidget {
  final int level;

  const AvatarToLogin({Key key, this.level}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppSize.PADDING_SIZE),
      child: Consumer<LoginInfo>(
        builder: (context, t, child) {
          return Container(
            color: Color(AppColors.APP_THEME),
            child: Row(
              children: [
                CircleLogo(
                  t.loginGet['profile']['avatarUrl'],
                  type: 'me',
                ),
                SizedBox(width: AppSize.BOX_SIZE_WIDTH_M),
                Text(
                  t.loginGet['profile']['nickname'],
                  style: TextStyle(
                      color: Color(AppColors.FONT_EM_COLOR),
                      fontSize: AppSize.FONT_SIZE,
                      fontWeight: FontWeight.w500,
                      height: 1),
                ),
                Expanded(
                  child: Text('当前等级: ', textAlign: TextAlign.right),
                ),
                Text(
                  'lv.$level',
                  style: TextStyle(
                    color: Color(Provider.of<ThemeModel>(context, listen: true)
                        .getColor),
                    fontSize: AppSize.FONT_SIZE,
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
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
        Consumer<ThemeModel>(builder: (context, t, child) {
          return Icon(
            icon,
            color: Color(t.getColor),
          );
        }),
        const SizedBox(
          height: AppSize.BOX_SIZE_HEIGHT_S,
        ),
        Text(
          text,
          style: const TextStyle(color: Color(AppColors.FONT_MAIN_COLOR)),
        ),
      ],
    );
  }
}
