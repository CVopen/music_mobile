import 'package:flutter/material.dart';
import 'package:music_mobile/api/home_page.dart';
import 'package:music_mobile/common/variable.dart';
import 'package:music_mobile/page/home/widget/v_page/item_page.dart';

import 'package:music_mobile/store/theme_model.dart';
import 'package:music_mobile/widget/tabbar_widget.dart';
import 'package:provider/provider.dart';

class VideoPage extends StatefulWidget {
  @override
  _VideoPageState createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage>
    with AutomaticKeepAliveClientMixin {
  List _list = [];
  List _listTitle = [];
  Map _size = {};

  PageController _controller;
  int _currentIndex;
  @override
  void initState() {
    super.initState();
    _currentIndex = 0;
    _controller = PageController(initialPage: 0);
    this._getCategory();
  }

  Future _getCategory() async {
    var res = await ApiHome().getVideoCategory();

    List arrTitle = [];
    List arr = [];
    res.data['data'].forEach((item) {
      if (item['name'] != 'MV') {
        arrTitle.add(item['name']);
        arr.add(item);
      }
    });
    setState(() {
      _list = arr;
      _listTitle = arrTitle;
    });
  }

  _calcSize(widthAll) {
    double _widthMax = widthAll / 2;
    double _heightImg = _widthMax / 0.7 - 60 - 16;
    double _widthImg = _heightImg / 1.2;
    double _paddingLeft = (_widthMax - _widthImg) / 3 * 2;
    double _paddingRight = (_widthMax - _widthImg) / 3;
    setState(() {
      _size['width'] = _widthImg;
      _size['heigth'] = _heightImg;
      _size['paddingMax'] = _paddingLeft;
      _size['paddingSmall'] = _paddingRight;
    });
  }

  @override
  // ignore: must_call_super
  Widget build(BuildContext context) {
    if (_size.isEmpty) {
      this._calcSize(MediaQuery.of(context).size.width);
    }
    return Column(
      children: [
        // 头部
        Consumer<ThemeModel>(builder: (context, t, child) {
          return TabbarWidget(
            color: t.getColor,
            title: _listTitle,
            index: _currentIndex,
            callback: (value) {
              _controller.jumpToPage(value);
            },
          );
        }),
        SizedBox(height: AppSize.BOX_SIZE_WIDTH_S),
        Expanded(
          child: PageView.builder(
            itemBuilder: (context, index) {
              return ItemPage(size: _size, title: _list[index]);
            },
            itemCount: _list.length,
            controller: _controller,
            onPageChanged: (int index) {
              setState(() {
                if (_currentIndex != index) _currentIndex = index;
              });
            },
          ),
        )
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class ScrollControllerTestRoute extends StatefulWidget {
  @override
  ScrollControllerTestRouteState createState() {
    return new ScrollControllerTestRouteState();
  }
}

class ScrollControllerTestRouteState extends State<ScrollControllerTestRoute> {
  ScrollController _controller = new ScrollController();
  bool showToTopBtn = false; //是否显示“返回到顶部”按钮

  @override
  void initState() {
    super.initState();
    //监听滚动事件，打印滚动位置
    _controller.addListener(() {
      print(_controller.offset); //打印滚动位置
      if (_controller.offset < 1000 && showToTopBtn) {
        setState(() {
          showToTopBtn = false;
        });
      } else if (_controller.offset >= 1000 && showToTopBtn == false) {
        setState(() {
          showToTopBtn = true;
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("滚动控制")),
      body: Scrollbar(
        child: ListView.builder(
            itemCount: 100,
            itemExtent: 50.0, //列表项高度固定时，显式指定高度是一个好习惯(性能消耗小)
            controller: _controller,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text("$index"),
              );
            }),
      ),
      floatingActionButton: !showToTopBtn
          ? null
          : FloatingActionButton(
              child: Icon(Icons.arrow_upward),
              onPressed: () {
                //返回到顶部时执行动画
                _controller.animateTo(200.0,
                    duration: Duration(milliseconds: 200), curve: Curves.ease);
              }),
    );
  }
}
