import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:music_mobile/common/variable.dart';
import 'package:music_mobile/widget/image_radius.dart';

class MusicListItem extends StatelessWidget {
  final Map item;
  const MusicListItem({
    Key key,
    @required this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppSize.PADDING_SIZE_B),
      child: InkWell(
        highlightColor: Colors.transparent,
        radius: 0.0,
        onTap: () {
          print('播放');
        },
        child: Row(
          children: [
            ImageRadius(item['al']['picUrl'], 50, 50),
            const SizedBox(width: AppSize.PADDING_SIZE_S),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(AppSize.PADDING_SIZE_S),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item['name'],
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: const TextStyle(
                        fontSize: AppSize.FONT_SIZE_B,
                        height: 1,
                        color: Color(AppColors.FONT_MAIN_COLOR),
                      ),
                    ),
                    Text(
                      item['ar'][0]['name'],
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: const TextStyle(
                        fontSize: AppSize.FONT_SIZE_M,
                        color: Color(AppColors.FONT_COLOR),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            InkWell(
              highlightColor: Colors.transparent,
              radius: 0.0,
              child: const Icon(
                Icons.live_tv,
                color: Color(AppColors.FONT_COLOR),
              ),
              onTap: () {},
            ),
            const SizedBox(width: AppSize.BOX_SIZE_WIDTH_B),
            InkWell(
              highlightColor: Colors.transparent,
              radius: 0.0,
              child: const Icon(
                Icons.more_vert,
                color: Color(AppColors.FONT_COLOR),
              ),
              onTap: () {
                showCupertinoModalBottomSheet(
                  context: context,
                  builder: (context) => BottomSheetWidget(
                    item: item,
                    context: context,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class BottomSheetWidget extends StatelessWidget {
  final context;
  final Map item;

  const BottomSheetWidget({
    Key key,
    @required this.item,
    @required this.context,
  }) : super(key: key);

  static List<Map> _mode = [
    {'icon': Icons.slow_motion_video, 'text': '下一首播放'},
    {'icon': Icons.add_circle_outline, 'text': '收藏到歌单'},
    {'icon': Icons.message_outlined, 'text': '评论'},
  ];

  List<Widget> _createItem() {
    List<Widget> arr = [];
    _mode.forEach((element) {
      arr.add(InkWell(
        highlightColor: Colors.transparent,
        radius: 0.0,
        onTap: () {
          print('播放');
          Navigator.pop(context);
        },
        child: Container(
          height: 50,
          padding: EdgeInsets.all(10),
          child: Row(
            children: [
              Icon(element['icon'], color: Color(AppColors.FONT_MAIN_COLOR)),
              SizedBox(width: AppSize.BOX_SIZE_WIDTH_M),
              Text(
                element['text'],
                style: TextStyle(
                    color: Color(AppColors.FONT_MAIN_COLOR), height: 1),
              )
            ],
          ),
        ),
      ));
    });
    return arr;
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        height: 240,
        padding: EdgeInsets.all(AppSize.PADDING_SIZE_B),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(bottom: AppSize.PADDING_SIZE_B),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    width: 0.5,
                    color: Color(AppColors.FONT_MAIN_COLOR),
                  ),
                ),
              ),
              child: Row(
                children: [
                  ImageRadius(item['al']['picUrl'], 40, 40),
                  SizedBox(width: AppSize.BOX_SIZE_WIDTH_S),
                  Expanded(
                    child: Text(
                      '歌曲: ${item['name']}',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: const TextStyle(
                        fontSize: AppSize.FONT_SIZE_B,
                        decoration: TextDecoration.none,
                        height: 1,
                        fontWeight: FontWeight.bold,
                        color: Color(AppColors.FONT_MAIN_COLOR),
                      ),
                    ),
                  )
                ],
              ),
            ),
            ..._createItem()
          ],
        ),
      ),
    );
  }
}
