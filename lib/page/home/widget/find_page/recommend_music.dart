import 'package:flutter/material.dart';
import 'package:music_mobile/widget/music_item.dart';
import '../../../../common/variable.dart';

class RecommendMusic extends StatefulWidget {
  final List personalizedList;

  const RecommendMusic({Key key, this.personalizedList}) : super(key: key);
  @override
  _RecommendMusicState createState() => _RecommendMusicState();
}

class _RecommendMusicState extends State<RecommendMusic> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(
            left: AppSize.PADDING_SIZE_B,
            right: AppSize.PADDING_SIZE_B,
          ),
          child: Row(
            children: [
              Text(
                '推荐歌单',
                style: TextStyle(
                  color: Color(AppColors.FONT_MAIN_COLOR),
                  fontSize: AppSize.FONT_SIZE_B,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Expanded(child: Text('')),
              InkWell(
                onTap: () {
                  print('查看更多');
                },
                child: Container(
                  padding: EdgeInsets.only(
                    top: 2,
                    left: 5,
                    right: 5,
                    bottom: 2,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(AppSize.BORDER_RADIUS),
                    ),
                    color: Color(AppColors.BACKGROUND_COLOR),
                    border: Border.all(
                      width: 1,
                      color: Color(AppColors.BORDER_COLOR),
                    ),
                  ),
                  child: Text(
                    '查看更多',
                    style: TextStyle(
                      color: Color(AppColors.FONT_MAIN_COLOR),
                      fontSize: AppSize.FONT_SIZE_S,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          height: 190,
          child: ListView.builder(
            // key: UniqueKey(),
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              if (index == 9) {
                return Container(
                  margin: EdgeInsets.only(
                    top: AppSize.PADDING_SIZE_B,
                    left: AppSize.PADDING_SIZE_B,
                    right: AppSize.PADDING_SIZE_B,
                    bottom: AppSize.PADDING_SIZE_B,
                  ),
                  width: 120,
                  height: 140,
                  child: Column(
                    children: [
                      MusicItem(item: widget.personalizedList[index]),
                      Text(
                        widget.personalizedList[index]['name'],
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: AppSize.FONT_SIZE_S),
                      ),
                    ],
                  ),
                );
              }
              return Container(
                margin: EdgeInsets.only(
                  top: AppSize.PADDING_SIZE_B,
                  left: AppSize.PADDING_SIZE_B,
                  bottom: AppSize.PADDING_SIZE_B,
                ),
                width: 120,
                height: 170,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MusicItem(item: widget.personalizedList[index]),
                    Text(
                      widget.personalizedList[index]['name'],
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: AppSize.FONT_SIZE_S),
                    ),
                  ],
                ),
              );
            },
            itemCount: widget.personalizedList.length,
          ),
        )
      ],
    );
  }
}
