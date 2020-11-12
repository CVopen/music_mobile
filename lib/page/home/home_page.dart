import 'package:flutter/material.dart';

import 'my_page.dart';
import 'cloud_page.dart';
import 'find_page.dart';
import 'video_page.dart';
import '../../common/variable.dart' show AppColors, AppSize;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  List<BottomNavigationBarItem> _bottomNavigationBarItems;
  List<Widget> _page;
  var _currentIndex = 0;

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
  }

  @override
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
          body: Center(
            child: _page[_currentIndex],
          ),
          bottomNavigationBar: BottomNavigationBar(
            elevation: 0.0,
            items: _bottomNavigationBarItems.map((e) => e).toList(),
            currentIndex: _currentIndex,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: Color(AppColors.IMPORTANT_COLOR),
            selectedFontSize: AppSize.FONT_SIZE_S,
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
          ),
        ),
      ),
    );
  }
}

class TitleWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        print(123);
      },
      child: Container(
        height: 40.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppSize.BORDERRADIUS),
          color: Colors.white,
        ),
        child: Row(
          // crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.search,
              color: Color(AppColors.FONT_COLOR),
              size: 18.0,
            ),
            SizedBox(
              width: AppSize.BOX_SIZE_WIDTH_S,
            ),
            Text(
              '音乐/视频',
              style: TextStyle(
                fontSize: AppSize.FONT_SIZE_M,
                color: Color(AppColors.FONT_COLOR),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CircleLogo extends StatefulWidget {
  @override
  _CircleLogoState createState() => _CircleLogoState();
}

class _CircleLogoState extends State<CircleLogo>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  String logoUrl;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 10),
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _controller.reset();
          _controller.forward();
        }
      });
    _controller.forward();
    logoUrl =
        'http://images.shejidaren.com/wp-content/uploads/2014/09/0215109hx.jpg';
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: _controller,
      child: CircleAvatar(
        backgroundImage: NetworkImage(logoUrl),
      ),
    );
  }
}

class DrawerWidget extends StatefulWidget {
  @override
  _DrawerWidgetState createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;
    return Container(
      color: Colors.red,
      width: width * 0.85,
      height: height,
      child: Text('34534534'),
    );
  }
}
