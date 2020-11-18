import 'package:flutter/material.dart';
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
    return Container(
      // 处理异形屏幕 以及状态栏显示颜色
      child: SafeArea(
        left: false,
        top: false,
        right: false,
        bottom: false,
        child: Scaffold(
          appBar: AppBar(
            elevation: 0.0,
            brightness: Brightness.light,
            title: TitleWidget(),
            actions: [
              CircleLogo(),
              SizedBox(
                width: AppSize.BOX_SIZE_WIDTH_B,
              )
            ],
          ),
          drawer: DrawerWidget(),
          // body: Center(
          //   child: _page[_currentIndex],
          // ),
          body: _buildBodyWidget(),
          bottomNavigationBar: _buildBottomNavigationBarWidget(),
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
