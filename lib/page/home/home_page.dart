import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:music_mobile/api/home_page.dart';
import 'package:music_mobile/page/audio/audio_widget.dart';
import 'package:music_mobile/store/login_info.dart';
import 'package:music_mobile/store/theme_model.dart';
import 'package:provider/provider.dart';
// 引入子页面
import 'my_page.dart';
import 'mv_page.dart';
import 'find_page.dart';
import 'video_page.dart';
// 引入样式
import '../../common/variable.dart' show AppSize;
// 引入home widget
import 'widget/title_widget.dart';
import 'widget/circle_logo.dart';
import 'widget/drawer.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  List<BottomNavigationBarItem> _bottomNavigationBarItems = [];

  List<Widget> _page;

  List<Map> _bottomIcon = [
    {
      'icon': Icon(Icons.account_circle_outlined),
      'activeIcon': Icon(Icons.account_circle),
      'text': '我的'
    },
    {
      'icon': Icon(Icons.search),
      'activeIcon': Icon(Icons.search_rounded),
      'text': '发现'
    },
    {
      'icon': Icon(Icons.group_work_outlined),
      'activeIcon': Icon(Icons.group_work),
      'text': 'MV'
    },
    {
      'icon': Icon(Icons.play_circle_outline),
      'activeIcon': Icon(Icons.play_circle_fill),
      'text': '视频'
    },
  ];

  Map _loginInfo;

  int _currentIndex;

  PageController _controller;
  GlobalKey _key = GlobalKey();

  @override
  void initState() {
    super.initState();

    setState(() {
      _loginInfo = Provider.of<LoginInfo>(context, listen: false).loginGet;
      _page = [
        MyPage(),
        FindPage(),
        MvPage(),
        VideoPage(),
      ];
    });
    _currentIndex = 1;
    _controller = PageController(initialPage: 1);
    this._createBottom();
  }

  _createBottom() {
    _bottomIcon.forEach((element) {
      setState(() {
        _bottomNavigationBarItems.add(
          BottomNavigationBarItem(
            icon: element['icon'],
            activeIcon: element['activeIcon'],
            // ignore: deprecated_member_use
            title: Text(element['text']),
          ),
        );
      });
    });
  }

  // ignore: unused_element
  _refresh() {
    ApiHome().refreshLogin().then((res) {
      print(res);
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  // ignore: must_call_super
  Widget build(BuildContext context) {
    return WillPopScopeTestRoute(
      // 处理异形屏幕 以及状态栏显示颜色
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          // brightness: Brightness.dark,
          title: TitleWidget(),
          actions: [
            CircleLogo(
              _loginInfo['profile']['avatarUrl'],
            ),
            const SizedBox(
              width: AppSize.BOX_SIZE_WIDTH_B,
            )
          ],
        ),
        drawer: DrawerWidget(),
        body: Column(
          children: [
            Expanded(
              child: SafeArea(
                top: true,
                child: _buildBodyWidget(),
              ),
            ),
            // 播放条
            MusicWidget(),
          ],
        ),
        bottomNavigationBar: Theme(
          // 去除bottombar水波纹点击效果
          data: ThemeData(
            // brightness: Brightness.light,
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
          ),
          child: _buildBottomNavigationBarWidget(),
        ),
      ),
    );
  }

  // 使用PageView 做页面状态保持
  Widget _buildBodyWidget() {
    return PageView.builder(
      physics: NeverScrollableScrollPhysics(), // 禁止页面左右滑动
      controller: _controller,
      onPageChanged: (int index) {
        setState(() {
          if (_currentIndex != index) _currentIndex = index;
        });
      },
      itemCount: _page.length,
      itemBuilder: (context, index) => _page[index],
    );
  }

  Widget _buildBottomNavigationBarWidget() {
    return BottomNavigationBar(
      key: _key,
      elevation: 0.0,
      items: _bottomNavigationBarItems,
      currentIndex: _currentIndex,
      type: BottomNavigationBarType.fixed,
      selectedItemColor:
          Color(Provider.of<ThemeModel>(context, listen: true).getColor),
      selectedFontSize: AppSize.FONT_SIZE_S,
      onTap: (index) {
        setState(() {
          _currentIndex = index;
          _controller.jumpToPage(index);
        });
      },
    );
  }
}

class WillPopScopeTestRoute extends StatefulWidget {
  final Widget child;

  const WillPopScopeTestRoute({Key key, this.child}) : super(key: key);

  @override
  WillPopScopeTestRouteState createState() {
    return WillPopScopeTestRouteState();
  }
}

class WillPopScopeTestRouteState extends State<WillPopScopeTestRoute> {
  DateTime _lastPressedAt; //上次点击时间

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Fluttertoast.showToast(
          msg: "再按一次退出",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black87,
          textColor: Colors.white,
          fontSize: 14.0,
        );
        if (_lastPressedAt == null ||
            DateTime.now().difference(_lastPressedAt) > Duration(seconds: 1)) {
          //两次点击间隔超过1秒则重新计时
          _lastPressedAt = DateTime.now();
          return false;
        }
        return true;
      },
      child: widget.child,
    );
  }
}
