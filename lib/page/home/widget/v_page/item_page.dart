import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:music_mobile/api/home_page.dart';
import 'package:music_mobile/common/variable.dart';
import 'package:music_mobile/store/theme_model.dart';
import 'package:music_mobile/utils/format.dart';
import 'package:provider/provider.dart';

import 'video_Item_widget.dart';

class ItemPage extends StatefulWidget {
  final Map size;
  final title;

  const ItemPage({Key key, @required this.size, @required this.title})
      : super(key: key);

  @override
  _ItemPageState createState() => _ItemPageState();
}

class _ItemPageState extends State<ItemPage>
    with AutomaticKeepAliveClientMixin {
  int _limit = 8;
  int _offset = 0;
  List _list = [];
  bool noMore = false; // 是否显示 没有更多
  bool loading = true;
  ScrollController _controller = new ScrollController();

  @override
  void initState() {
    super.initState();
    if (widget.title is String) {
      if (widget.title == '最新') {
        this._getMv();
      } else if (widget.title == '推荐') {
        this._getPerMv();
      } else if (widget.title == '网易出品') {
        this._getRcmd();
      } else {
        this._getMvTitile();
      }
    } else {
      this._getVideoList();
    }
    // 监听滚动事件
    _controller.addListener(() {
      if ((_controller.offset > _controller.position.maxScrollExtent - 10) &&
          noMore) {
        setState(() {
          _offset++;
          loading = false;
        });

        if (widget.title is String) {
          this._getMvTitile();
        } else {
          this._getVideoList();
        }
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future _refresh() async {
    setState(() {
      _list.clear();
      _offset = 0;
    });
    if (widget.title is String) {
      if (widget.title == '最新') {
        this._getMv();
      } else if (widget.title == '推荐') {
        this._getPerMv();
      } else if (widget.title == '网易出品') {
        this._getRcmd();
      } else {
        this._getMvTitile();
      }
    } else {
      this._getVideoList();
    }
    await Future.delayed(Duration(seconds: 1), () {
      print('我刷新了');
    });
    return;
  }

  // 获取最新mv
  Future _getMv() async {
    var res = await ApiHome().getMvFirst({'limit': 50});
    List count = createArr(8, 50);
    List arr = [];
    count.forEach((element) {
      arr.add(res.data['data'][element]);
    });
    setState(() {
      _list = arr;
    });
  }

  // 全部mv
  Future _getMvTitile() async {
    var res = await ApiHome()
        .getMvAll({'offset': _offset, 'limit': _limit, 'area': widget.title});
    setState(() {
      _list.addAll(res.data['data']);
      noMore = res.data['hasMore'];
      loading = true;
    });
  }

  // 获取网易出品MV
  Future _getRcmd() async {
    var res = await ApiHome().getRcmdMv({'limit': _limit});
    print(res.data['data'].length);
    setState(() {
      _list = res.data['data'];
    });
  }

  // 获取推荐MV
  Future _getPerMv() async {
    var res = await ApiHome().getPersonalizedMv();
    setState(() {
      _list.addAll(res.data['result']);
    });
  }

  // 获取视频
  Future _getVideoList() async {
    var res = await ApiHome()
        .getGroupMv({'id': widget.title['id'], 'offset': _offset});
    setState(() {
      _list.addAll(res.data['datas']);
      noMore = res.data['hasmore'];
      loading = true;
    });
  }

  List<Widget> _createItem() {
    List<Widget> arr = [];
    _list.forEach((element) {
      int index = _list.indexOf(element);
      arr.add(VideoItemWidget(
        type: widget.title is String ? 'mv' : null,
        width: widget.size['width'],
        heigth: widget.size['heigth'],
        paddingLeft: index % 2 == 0
            ? widget.size['paddingMax']
            : widget.size['paddingSmall'],
        paddingRight: index % 2 == 0
            ? widget.size['paddingSmall']
            : widget.size['paddingMax'],
        data: element,
      ));
    });
    return arr;
  }

  @override
  // ignore: must_call_super
  Widget build(BuildContext context) {
    if (_list.length == 0) {
      return Container(
        alignment: Alignment.center,
        child: Image.asset('assets/images/loading.gif'),
      );
    } else {
      return RefreshIndicator(
        child: Container(
          padding: EdgeInsets.only(
            top: AppSize.PADDING_SIZE_S,
            bottom: AppSize.PADDING_SIZE_S,
          ),
          child: ListView(
            controller: _controller,
            children: [
              Wrap(
                children: _createItem(),
              ),
              Offstage(
                offstage: loading,
                child: Container(
                  height: 40,
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/loading_more.gif',
                        width: 30,
                        height: 30,
                      ),
                      const SizedBox(width: AppSize.PADDING_SIZE_S),
                      const Text(
                        '加载中...',
                        style: TextStyle(
                          color: Color(AppColors.FONT_COLOR),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Offstage(
                offstage: noMore,
                child: Container(
                  height: 40,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.only(
                    top: AppSize.PADDING_SIZE_S,
                    bottom: AppSize.PADDING_SIZE_S,
                  ),
                  child: const Text(
                    '没有更多了',
                    style: TextStyle(
                      color: Color(AppColors.FONT_COLOR),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        color: Color(Provider.of<ThemeModel>(context, listen: true).getColor),
        onRefresh: _refresh,
      );
    }
  }

  @override
  bool get wantKeepAlive => true;
}
