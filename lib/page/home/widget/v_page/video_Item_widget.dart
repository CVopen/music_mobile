import 'package:flutter/material.dart';
import 'package:music_mobile/api/home_page.dart';

import 'package:music_mobile/utils/format.dart';
import 'package:music_mobile/widget/image_radius.dart';

import 'mv_back_filter.dart';

class VideoItemWidget extends StatefulWidget {
  final String type;
  final double width;
  final double heigth;
  final double paddingLeft;
  final double paddingRight;
  final Map data;

  const VideoItemWidget({
    Key key,
    this.type,
    @required this.width,
    @required this.heigth,
    @required this.paddingLeft,
    @required this.paddingRight,
    @required this.data,
  }) : super(key: key);
  @override
  _VideoItemWidgetState createState() => _VideoItemWidgetState();
}

class _VideoItemWidgetState extends State<VideoItemWidget> {
  List _list = [];
  String _like = '';
  @override
  void initState() {
    super.initState();
    if (widget.type != null) {
      setState(() {
        _list = backFilter(
          widget.width,
          widget.data['cover'] == null
              ? widget.data['picUrl']
              : widget.data['cover'],
        );
        this._getMvInfo();
      });
    }
  }

  _getMvInfo() {
    ApiHome().getDetail({'mvid': widget.data['id']}).then((res) {
      setState(() {
        _like = computePlay(res.data['likedCount']);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: widget.paddingLeft,
        right: widget.paddingRight,
        top: 8,
        bottom: 8,
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
                    widget.data['cover'] == null
                        ? widget.data['picUrl']
                        : widget.data['cover'],
                    widget.width,
                    widget.heigth,
                    topLeft: 10,
                    topRight: 10,
                  ),
                ),
                ..._list,
                Positioned(
                  bottom: 10,
                  left: 0,
                  child: Container(
                    width: widget.width - 10,
                    margin: const EdgeInsets.only(left: 5, right: 5),
                    child: Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white, width: 2),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: ImageRadius(
                            widget.data['cover'] == null
                                ? widget.data['picUrl']
                                : widget.data['cover'],
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
                            formatDuration(widget.data['duration']),
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
              width: widget.width,
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
                    widget.data['name'],
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
                        computePlay(widget.data['playCount']),
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
                        _like,
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
