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

  @override
  void initState() {
    super.initState();
    _offstage = widget.title == '创建歌单' ? false : true;
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
                    myShowModalBottomSheet(context, 80.0, 123);
                  },
                ),
              )
            ],
          ),
          Center(
            child: Text(
              widget.total,
              style: TextStyle(color: Color(AppColors.FONT_COLOR)),
            ),
          )
        ],
      ),
    );
  }
}
