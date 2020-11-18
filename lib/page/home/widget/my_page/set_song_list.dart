import 'package:flutter/material.dart';
import '../../../../common/variable.dart';

import 'show_model_bottom.dart';

// 创建歌单
class SetSongList extends StatefulWidget {
  final String title;
  final String total;

  const SetSongList({Key key, this.title, this.total}) : super(key: key);

  @override
  _SetSongListState createState() => _SetSongListState();
}

class _SetSongListState extends State<SetSongList> {
  bool _offstage;
  List<Widget> _page = [];
  @override
  void initState() {
    super.initState();
    _offstage = widget.title == '创建歌单' ? false : true;
    _page = [
      SongItem(),
      SongItem(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        left: AppSize.PADDING_SIZE,
        right: AppSize.PADDING_SIZE,
        top: AppSize.PADDING_SIZE,
      ),
      padding: EdgeInsets.all(AppSize.PADDING_SIZE_B),
      decoration: BoxDecoration(
        color: Color(AppColors.BACKGROUND_COLOR),
        borderRadius: BorderRadius.all(
          Radius.circular(AppSize.BORDER_RADIUS_S),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                widget.title,
                style: TextStyle(color: Color(AppColors.FONT_COLOR)),
              ),
              Expanded(
                child: Text(''),
              ),
              IconButton(
                icon: Icon(
                  Icons.add,
                  size: 20,
                  color: Color(AppColors.BACKGROUND_COLOR),
                ),
                onPressed: () {},
              ),
              Offstage(
                offstage: _offstage,
                child: IconButton(
                  icon: Icon(
                    Icons.add,
                    size: 20,
                    color: Color(AppColors.FONT_COLOR),
                  ),
                  onPressed: () {
                    print('add');
                  },
                ),
              )
            ],
          ),
          Offstage(
            offstage: _page.length > 0 ? true : false,
            child: Center(
              child: Text(
                widget.total,
                style: TextStyle(color: Color(AppColors.FONT_COLOR)),
              ),
            ),
          )
        ]..addAll(_page),
      ),
    );
  }
}

// 需要将歌单对象传入 还未写
class SongItem extends StatefulWidget {
  @override
  _SongItemState createState() => _SongItemState();
}

class _SongItemState extends State<SongItem> {
  bool _offstage = false;
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Color(AppColors.BACKGROUND_COLOR),
      child: InkWell(
        onTap: () {
          print('InkWell');
        },
        child: Container(
          margin: EdgeInsets.only(bottom: AppSize.PADDING_SIZE_S),
          child: Row(
            children: [
              Offstage(
                offstage: _offstage,
                child: Container(
                  width: 50.0,
                  height: 50.0,
                  margin: EdgeInsets.only(right: AppSize.PADDING_SIZE_S),
                  decoration: BoxDecoration(
                    color: Color(AppColors.BACKGROUND_COLOR_DEEP),
                    borderRadius: BorderRadius.all(
                      Radius.circular(AppSize.BORDER_RADIUS_S),
                    ),
                  ),
                  child: Center(
                    child: Icon(Icons.music_note),
                  ),
                ),
              ),
              Offstage(
                offstage: !_offstage,
                child: Container(
                  width: 50.0,
                  height: 50.0,
                  margin: EdgeInsets.only(right: AppSize.PADDING_SIZE_S),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      "http://images.shejidaren.com/wp-content/uploads/2014/09/0215109hx.jpg",
                      height: 50,
                      width: 50,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '123123321',
                    style: TextStyle(
                      fontSize: AppSize.FONT_SIZE_M,
                    ),
                  ),
                  Text(
                    '0首',
                    style: TextStyle(
                      color: Color(AppColors.FONT_COLOR),
                      fontSize: AppSize.FONT_SIZE_S,
                    ),
                  )
                ],
              ),
              Expanded(
                child: Text(''),
              ),
              IconButton(
                icon: Icon(
                  Icons.more_vert,
                  size: 20,
                  color: Color(AppColors.FONT_COLOR),
                ),
                onPressed: () {
                  myShowModalBottomSheet(context, 100.0, 123);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
