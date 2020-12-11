import 'package:flutter/material.dart';
import 'package:music_mobile/widget/image_radius.dart';

import 'mv_page/mv_back_filter.dart';

class VideoItemWidget extends StatelessWidget {
  final String type;
  final double width;
  final double heigth;
  final double paddingMax;
  final double paddingSmall;

  const VideoItemWidget({
    Key key,
    this.type,
    @required this.width,
    @required this.heigth,
    @required this.paddingMax,
    @required this.paddingSmall,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _list = [];
    if (type != null) {
      _list = backFilter(
        width,
        'https://p1.music.126.net/rNohKmVCeTlCdQ89R3N9AQ==/109951165465159841.jpg',
      );
    }
    return Container(
      padding: EdgeInsets.only(
        left: paddingMax,
        right: paddingSmall,
      ),
      child: InkWell(
        onTap: () {
          print('该跳转播放了');
        },
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  child: ImageRadius(
                    'https://p1.music.126.net/rNohKmVCeTlCdQ89R3N9AQ==/109951165465159841.jpg',
                    width,
                    heigth,
                    topLeft: 10,
                    topRight: 10,
                  ),
                ),
                ..._list,
                Positioned(
                  bottom: 10,
                  left: 0,
                  child: Container(
                    width: width - 10,
                    margin: const EdgeInsets.only(left: 5, right: 5),
                    child: Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white, width: 2),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: ImageRadius(
                            'https://p1.music.126.net/rNohKmVCeTlCdQ89R3N9AQ==/109951165465159841.jpg',
                            20,
                            20,
                            radius: 20,
                          ),
                        ),
                        const Expanded(child: Text('')),
                        Container(
                          alignment: Alignment.bottomCenter,
                          height: 24,
                          child: Text(
                            '01:47',
                            style: const TextStyle(
                              color: Color.fromRGBO(255, 255, 255, .5),
                              fontSize: 12.0,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
            // 底部名称信息
            Container(
              width: width,
              height: 60,
              padding: const EdgeInsets.all(5),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
                color: Colors.white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'datadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadata',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: const TextStyle(height: 1, fontSize: 14),
                  ),
                  const Expanded(child: Text('')),
                  Row(
                    children: [
                      const Icon(
                        Icons.play_arrow_outlined,
                        color: Colors.black54,
                        size: 16,
                      ),
                      Text(
                        '46.5万',
                        style: const TextStyle(
                            height: 1, fontSize: 12, color: Colors.black54),
                      ),
                      const SizedBox(width: 5),
                      const Icon(
                        Icons.thumb_up_outlined,
                        color: Colors.black54,
                        size: 12,
                      ),
                      const SizedBox(width: 3),
                      Text(
                        '46.5万',
                        style: const TextStyle(
                            height: 1, fontSize: 12, color: Colors.black54),
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
