import 'package:flutter/material.dart';
import 'package:music_mobile/common/variable.dart';
import 'package:music_mobile/page/home/widget/v_page/item_page.dart';

import 'package:music_mobile/store/theme_model.dart';
import 'package:music_mobile/widget/tabbar_widget.dart';
import 'package:provider/provider.dart';

class MvPage extends StatefulWidget {
  @override
  _MvPageState createState() => _MvPageState();
}

class _MvPageState extends State<MvPage> with AutomaticKeepAliveClientMixin {
  List _list = ['推荐', '最新', '全部', '内地', '港台', '欧美', '日本', '韩国', '网易出品'];
  Map _size = {};
  PageController _controller;
  int _currentIndex;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _currentIndex = 0;
    _controller = PageController(initialPage: 0);
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

  // ignore: must_call_super
  Widget build(BuildContext context) {
    if (_size.isEmpty) {
      this._calcSize(MediaQuery.of(context).size.width);
    }
    return Column(
      children: [
        Consumer<ThemeModel>(builder: (context, t, child) {
          return TabbarWidget(
            color: t.getColor,
            title: _list,
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
}
