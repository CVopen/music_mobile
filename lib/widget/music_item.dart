import 'package:flutter/material.dart';
import 'package:music_mobile/common/variable.dart';

import 'image_radius.dart';

class MusicItem extends StatelessWidget {
  final Map item;

  const MusicItem({Key key, this.item}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      height: 120,
      child: Stack(
        children: [
          Container(
            child: ImageRadius(item['picUrl'], 120.0, 120.0),
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
                  '${item['playCount']}',
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
