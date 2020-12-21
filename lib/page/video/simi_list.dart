import 'package:flutter/material.dart';
import 'package:music_mobile/common/variable.dart';
import 'package:music_mobile/utils/format.dart';
import 'package:music_mobile/widget/image_radius.dart';

class SimiList extends StatelessWidget {
  final List itemList;
  final ValueChanged<int> callback;
  const SimiList({
    Key key,
    @required this.itemList,
    @required this.callback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 5, bottom: 10, right: 5),
      child: Container(
        height: 130,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: itemList.length,
          itemBuilder: (context, index) {
            return InkWell(
              highlightColor: Colors.transparent,
              radius: 0.0,
              onTap: () {
                callback(itemList[index]['id']);
              },
              child: ItemWidget(
                item: itemList[index],
              ),
            );
          },
        ),
      ),
    );
  }
}

class ItemWidget extends StatelessWidget {
  final Map item;
  const ItemWidget({
    Key key,
    @required this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            Container(
              margin: EdgeInsets.all(5),
              child: ImageRadius(item['cover'], 90, 90),
            ),
            Positioned(
              top: 7,
              right: 7,
              child: Row(
                children: [
                  Icon(
                    Icons.play_arrow,
                    color: Colors.white,
                    size: 20,
                  ),
                  SizedBox(
                    width: 3,
                  ),
                  Text(
                    item['playCount'] > 0 ? computePlay(item['playCount']) : '',
                    style: TextStyle(
                      color: Colors.white,
                      height: 1,
                      fontSize: AppSize.FONT_SIZE_S,
                    ),
                  )
                ],
              ),
            ),
            Positioned(
              bottom: 7,
              right: 7,
              child: Text(
                formatDuration(item['duration']),
                style: TextStyle(
                  color: Colors.white,
                  height: 1,
                  fontSize: AppSize.FONT_SIZE_S,
                ),
              ),
            )
          ],
        ),
        Container(
          width: 90,
          child: Text(
            item['name'],
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              height: 1,
            ),
          ),
        )
      ],
    );
  }
}
