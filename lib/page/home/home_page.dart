import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
// 引入子页面
import 'my_page.dart';
import 'cloud_page.dart';
import 'find_page.dart';
import 'video_page.dart';
// 引入样式
import '../../common/variable.dart' show AppColors, AppSize;
// 引入home widget
import 'widget/title_widget.dart';
import 'widget/circle_logo.dart';
import 'widget/drawer.dart';

// import '../../api/home_page.dart';
// import '../../api/api.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  List<BottomNavigationBarItem> _bottomNavigationBarItems;

  List<Widget> _page;

  int _currentIndex;

  PageController _controller;
  @override
  void initState() {
    super.initState();
    _bottomNavigationBarItems = [
      BottomNavigationBarItem(
        icon: Icon(Icons.account_circle_outlined),
        activeIcon: Icon(
          Icons.account_circle,
          color: Color(AppColors.IMPORTANT_COLOR),
        ),
        // ignore: deprecated_member_use
        title: Text('我的'),
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.search),
        activeIcon: Icon(
          Icons.search_rounded,
          color: Color(AppColors.IMPORTANT_COLOR),
        ),
        // ignore: deprecated_member_use
        title: Text('发现'),
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.cloud_queue),
        activeIcon: Icon(
          Icons.cloud,
          color: Color(AppColors.IMPORTANT_COLOR),
        ),
        // ignore: deprecated_member_use
        title: Text('云村'),
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.play_circle_outline),
        activeIcon: Icon(
          Icons.play_circle_fill,
          color: Color(AppColors.IMPORTANT_COLOR),
        ),
        // ignore: deprecated_member_use
        title: Text('视频'),
      ),
    ];

    _page = [
      MyPage(),
      FindPage(),
      CloudPage(),
      VideoPage(),
    ];
    _currentIndex = 1;
    _controller = PageController(initialPage: 1);
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
          brightness: Brightness.light,
          title: TitleWidget(),
          actions: [
            CircleLogo(
              "http://images.shejidaren.com/wp-content/uploads/2014/09/0215109hx.jpg",
            ),
            SizedBox(
              width: AppSize.BOX_SIZE_WIDTH_B,
            )
          ],
        ),
        drawer: DrawerWidget(),
        body: SafeArea(
          top: true,
          child: _buildBodyWidget(),
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
      // physics: NeverScrollableScrollPhysics(), // 禁止页面左右滑动
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
      elevation: 0.0,
      items: _bottomNavigationBarItems.map((e) => e).toList(),
      currentIndex: _currentIndex,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Color(AppColors.IMPORTANT_COLOR),
      selectedFontSize: AppSize.FONT_SIZE_S,
      onTap: (index) {
        setState(() {
          // _currentIndex = index;
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
    return new WillPopScopeTestRouteState();
  }
}

class WillPopScopeTestRouteState extends State<WillPopScopeTestRoute> {
  DateTime _lastPressedAt; //上次点击时间

  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
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
