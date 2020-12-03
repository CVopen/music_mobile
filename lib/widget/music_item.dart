import 'package:flutter/material.dart';
import 'package:music_mobile/common/variable.dart';

import 'image_radius.dart';

class MusicItem extends StatefulWidget {
  final Map item;

  const MusicItem({Key key, this.item}) : super(key: key);

  @override
  _MusicItemState createState() => _MusicItemState();
}

class _MusicItemState extends State<MusicItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      height: 120,
      child: Stack(
        children: [
          Container(
            child: ImageRadius(widget.item['picUrl'], 120.0, 120.0),
          ),
          Positioned(
            top: 0,
            right: 5,
            child: Row(
              children: [
                const Icon(
                  Icons.play_arrow_outlined,
                  color: Color(AppColors.BACKGROUND_COLOR),
                  size: AppSize.ICON_SIZE,
                ),
                Text(
                  '${widget.item['playCount']}',
                  style: const TextStyle(
                    color: Color(AppColors.BACKGROUND_COLOR),
                    fontSize: AppSize.FONT_SIZE_S,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
