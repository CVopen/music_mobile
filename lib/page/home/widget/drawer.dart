import 'package:flutter/material.dart';
import 'package:music_mobile/common/variable.dart';
import 'package:music_mobile/page/home/widget/circle_logo.dart';
import 'package:music_mobile/store/login_info.dart';
import 'package:music_mobile/store/theme_model.dart';
import 'package:provider/provider.dart';

// drawer 抽屉控制
class DrawerWidget extends StatefulWidget {
  @override
  _DrawerWidgetState createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  List<Map> _listColors;
  List<Widget> _listWidget = [];
  Map _loginInfo;

  @override
  void initState() {
    super.initState();
    setState(() {
      _listColors =
          Provider.of<ThemeModel>(context, listen: false).getColorList;
      _loginInfo = Provider.of<LoginInfo>(context, listen: false).loginGet;
    });
    _createTheme();
  }

  _createTheme() {
    _listColors.forEach((element) {
      setState(() {
        _listWidget
            .add(ThemeSelect(color: element['color'], name: element['name']));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;
    // final double statusBarHeight = MediaQuery.of(context).padding.top; // 状态栏高度
    return Opacity(
      opacity: 0.9,
      child: Container(
        color: Color(Provider.of<ThemeModel>(context, listen: true).getColor),
        width: width * 0.9,
        height: height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: width * 0.9,
              height: width * 0.9,
              color: Colors.white,
              child: Image.network(
                _loginInfo['profile']['avatarUrl'],
                fit: BoxFit.fill,
              ),
            ),
            Container(
              margin: EdgeInsets.all(AppSize.PADDING_SIZE_B),
              child: Row(
                children: [
                  CircleLogo(
                    _loginInfo['profile']['avatarUrl'],
                    type: 'me',
                  ),
                  const SizedBox(width: AppSize.PADDING_SIZE_B),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _loginInfo['profile']['nickname'],
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: AppSize.FONT_SIZE,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Container(
                        width:
                            width * 0.9 - 80 - AppSize.PADDING_SIZE_B * 3 - 100,
                        child: Text(
                          _loginInfo['profile']['signature'],
                          style: const TextStyle(
                            color: Colors.white54,
                            fontSize: AppSize.FONT_SIZE_S,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      )
                    ],
                  ),
                  const Expanded(child: Text('')),
                  MaterialButton(
                    color: Colors.white54,
                    textColor: Colors.white,
                    child: const Text('退出登录'),
                    minWidth: 80,
                    height: 30,
                    onPressed: () {
                      Provider.of<LoginInfo>(context, listen: false).loginSet =
                          'remove';
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        '/',
                        (Route<dynamic> route) => false,
                      );
                    },
                  )
                ],
              ),
            ),
            ListTile(
              title: const Text(
                '动态',
                style: TextStyle(
                  color: Color(AppColors.APP_THEME),
                ),
              ),
              trailing: Text(
                '${_loginInfo['profile']['eventCount']}',
                style: const TextStyle(
                  color: Color(AppColors.APP_THEME),
                ),
              ),
            ),
            ListTile(
              title: const Text(
                '关注',
                style: TextStyle(
                  color: Color(AppColors.APP_THEME),
                ),
              ),
              trailing: Text(
                '${_loginInfo['profile']['follows']}',
                style: const TextStyle(
                  color: Color(AppColors.APP_THEME),
                ),
              ),
            ),
            ListTile(
              title: const Text(
                '粉丝',
                style: TextStyle(
                  color: Color(AppColors.APP_THEME),
                ),
              ),
              trailing: Text(
                '${_loginInfo['profile']['followeds']}',
                style: const TextStyle(
                  color: Color(AppColors.APP_THEME),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(AppSize.PADDING_SIZE_B),
              child: const Text(
                '更换主题',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: AppSize.FONT_SIZE_B,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(
              height: AppSize.PADDING_SIZE_S,
            ),
            Row(children: _listWidget)
          ],
        ),
      ),
    );
  }
}

class ThemeSelect extends StatelessWidget {
  final int color;
  final String name;
  const ThemeSelect({Key key, this.color, this.name}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: Column(
          children: [
            InkWell(
              onTap: () {
                Provider.of<ThemeModel>(context, listen: false).setColor =
                    color;
              },
              child: Container(
                width: 26,
                height: 26,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(13),
                  ),
                ),
                child: Stack(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(2),
                      child: Container(
                        width: 24,
                        height: 24,
                        decoration: BoxDecoration(
                          color: Color(color),
                          borderRadius: BorderRadius.all(
                            Radius.circular(12),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4),
                      child: Consumer<ThemeModel>(
                        builder: (context, t, child) {
                          var _colors = Colors.transparent;
                          if (color == t.getColor) {
                            _colors = Colors.white;
                          }
                          return Icon(
                            Icons.done_outline,
                            size: 20,
                            color: _colors,
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(height: AppSize.PADDING_SIZE_S),
            Text(
              name,
              style: TextStyle(color: Colors.white, fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}
