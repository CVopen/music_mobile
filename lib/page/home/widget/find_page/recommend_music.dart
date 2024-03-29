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
    return Container(
      height: 180,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          if (index == widget.personalizedList.length - 1) {
            return Container(
              margin: EdgeInsets.all(AppSize.PADDING_SIZE_B),
              width: 120,
              height: 140,
              child: Column(
                children: [
                  MusicItem(item: widget.personalizedList[index]),
                  Text(
                    widget.personalizedList[index]['name'],
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: AppSize.FONT_SIZE_S),
                  ),
                ],
              ),
            );
          }
          return Container(
            margin: const EdgeInsets.fromLTRB(AppSize.PADDING_SIZE_B,
                AppSize.PADDING_SIZE_B, 0, AppSize.PADDING_SIZE_B),
            width: 100,
            height: 120,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MusicItem(item: widget.personalizedList[index]),
                Text(
                  widget.personalizedList[index]['name'],
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: AppSize.FONT_SIZE_S),
                ),
              ],
            ),
          );
        },
        itemCount: widget.personalizedList.length,
      ),
    );
  }
}
