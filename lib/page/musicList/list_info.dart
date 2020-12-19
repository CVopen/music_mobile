import 'package:flutter/material.dart';
import 'package:music_mobile/common/variable.dart';
import 'package:music_mobile/utils/format.dart';
import 'package:music_mobile/widget/image_radius.dart';

class ListInfo extends StatelessWidget {
  final Map info;
  const ListInfo({
    Key key,
    @required this.info,
  }) : super(key: key);

  static List<Map> _bottom = [
    {'icon': Icons.play_arrow, 'text': 'playCount'},
    {'icon': Icons.sms, 'text': 'commentCount'},
    {'icon': Icons.add, 'text': 'subscribedCount'}
  ];

  List<Widget> _createBottom(double width) {
    List<Widget> arr = [];
    _bottom.forEach((element) {
      arr.add(
        Container(
          width: width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(element['icon'], color: Colors.white),
              SizedBox(width: AppSize.BOX_SIZE_WIDTH_S),
              Text(
                computePlay(info[element['text']]),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: AppSize.FONT_SIZE_M,
                  height: 1,
                ),
              ),
            ],
          ),
        ),
      );
    });
    return arr;
  }

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20),
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.black.withOpacity(.2),
      ),
      child: Column(
        children: [
          Text(
            info['name'],
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: const TextStyle(
              color: Colors.white,
              fontSize: AppSize.FONT_SIZE,
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
            child: Container(
              alignment: Alignment.center,
              margin: EdgeInsets.all(2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ImageRadius(info['creator']['avatarUrl'], 25, 25,
                      radius: 12.5),
                  const SizedBox(width: 5),
                  Text(
                    info['creator']['nickname'],
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: AppSize.FONT_SIZE_M,
                      height: 1,
                    ),
                  ),
                  const SizedBox(width: 5),
                  InkWell(
                    highlightColor: Colors.transparent,
                    radius: 0.0,
                    onTap: () {
                      print('播放');
                    },
                    child: Container(
                      padding: EdgeInsets.only(left: 5, right: 5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.grey.withOpacity(.4),
                      ),
                      child: const Icon(
                        Icons.add,
                        size: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // 底部数据展示
          Container(
            margin: EdgeInsets.only(left: 20, right: 20, bottom: 10),
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              color: Colors.white.withOpacity(.2),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: _createBottom((_size.width - 100) / 3),
            ),
          )
        ],
      ),
    );
  }
}

class DayInfo extends StatelessWidget {
  const DayInfo({
    Key key,
  }) : super(key: key);

  static List<String> _day = ['一', '二', '三', '四', '五', '六', '七', '八', '九'];

  @override
  Widget build(BuildContext context) {
    var now = new DateTime.now();
    String month = '';
    if (now.month.toString().length == 1) {
      month = _day[now.month - 1];
    } else {
      switch (now.month % 10) {
        case 0:
          month = '十';
          break;
        case 1:
          month = '十一';
          break;
        case 2:
          month = '十二';
          break;
        default:
      }
    }

    return Column(
      children: [
        Text(
          '根据你的口味推荐',
          style: const TextStyle(
            color: Colors.white,
            fontSize: AppSize.FONT_SIZE,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: AppSize.BOX_SIZE_HEIGHT_S),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '${now.day} / ',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              '$month月',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        )
      ],
    );
  }
}
