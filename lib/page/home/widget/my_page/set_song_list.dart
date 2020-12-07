import 'package:flutter/material.dart';
import 'package:music_mobile/api/home_page.dart';
import 'package:music_mobile/store/login_info.dart';
import 'package:music_mobile/widget/image_radius.dart';
import 'package:music_mobile/widget/input_widget.dart';
import 'package:music_mobile/widget/show_dialog.dart';
import 'package:provider/provider.dart';
import '../../../../common/variable.dart';

import 'show_model_bottom.dart';

// 创建歌单
class SetSongList extends StatefulWidget {
  final String title;
  final String total;
  final List data;

  const SetSongList({Key key, this.title, this.total, this.data})
      : super(key: key);

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
  }

  @override
  void didUpdateWidget(SetSongList oldWidget) {
    super.didUpdateWidget(oldWidget);
    setState(() {
      widget.data.forEach((element) {
        _page.add(SongItem(
          item: element,
          callback: (i) {
            this._getUserBind();
          },
        ));
      });
    });
  }

  _createdMusicList() {
    var name;
    dialogWidget(
      context,
      Container(
        height: 100,
        child: Column(
          children: [
            Text('创建歌单'),
            InputWidget(
              (value) {
                name = value;
              },
              type: 'music',
            ),
          ],
        ),
      ),
      () {
        ApiHome().createPalyList({'name': name}).then((res) {
          if (res.data['code'] == 200) this._getUserBind();
        });
      },
    );
  }

  _getUserBind() async {
    Map _info = Provider.of<LoginInfo>(context, listen: false).loginGet;

    var res = await ApiHome().getPlaylist({'uid': _info['account']['id']});
    print('刷新了');
    List<Widget> _items = [];
    setState(() {
      res.data['playlist'].remove(res.data['playlist'][0]);
      _page.clear();
      res.data['playlist'].forEach((item) {
        if (!_offstage) {
          if (item['creator']['userId'] == _info['account']['id']) {
            _items.add(SongItem(
              item: item,
            ));
          }
        } else {
          if (item['creator']['userId'] != _info['account']['id']) {
            _items.add(SongItem(
              item: item,
            ));
          }
        }
      });
      _page.addAll(_items);
    });
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
                style: const TextStyle(color: Color(AppColors.FONT_COLOR)),
              ),
              Expanded(
                child: Text(''),
              ),
              IconButton(
                icon: const Icon(
                  Icons.add,
                  size: 20,
                  color: Color(AppColors.BACKGROUND_COLOR),
                ),
                onPressed: () {},
              ),
              Offstage(
                offstage: _offstage,
                child: IconButton(
                  icon: const Icon(
                    Icons.add,
                    size: 20,
                    color: Color(AppColors.FONT_COLOR),
                  ),
                  onPressed: this._createdMusicList,
                ),
              )
            ],
          ),
          Offstage(
            offstage: _page.length > 0,
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

class SongItem extends StatelessWidget {
  final Map item;
  final ValueChanged callback;
  const SongItem({Key key, this.item, this.callback}) : super(key: key);

  _delMusicList(id, call) {
    ApiHome().deletePalyList({'id': id}).then((res) {
      if (res.data['code'] == 200) call('');
    });
  }

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
              Container(
                width: 50.0,
                height: 50.0,
                margin: const EdgeInsets.only(right: AppSize.PADDING_SIZE_S),
                child: ImageRadius(item['coverImgUrl'], 50, 50),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item['name'],
                    style: TextStyle(
                      fontSize: AppSize.FONT_SIZE_M,
                    ),
                  ),
                  Text(
                    '${item['trackCount']}首',
                    style: TextStyle(
                      color: Color(AppColors.FONT_COLOR),
                      fontSize: AppSize.FONT_SIZE_S,
                    ),
                  )
                ],
              ),
              const Expanded(
                child: Text(''),
              ),
              IconButton(
                icon: const Icon(
                  Icons.more_vert,
                  size: 20,
                  color: Color(AppColors.FONT_COLOR),
                ),
                onPressed: () {
                  myShowModalBottomSheet(context, 100.0, item['trackCount'],
                      _delMusicList(item['id'], callback));
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
