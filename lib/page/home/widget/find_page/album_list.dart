import 'package:flutter/material.dart';
import 'package:music_mobile/common/variable.dart';
import 'package:music_mobile/widget/music_item_listview.dart';
import 'package:carousel_slider/carousel_slider.dart';

class AlbumList extends StatefulWidget {
  final List albumListList;

  const AlbumList({Key key, this.albumListList}) : super(key: key);

  @override
  _AlbumListState createState() => _AlbumListState();
}

class _AlbumListState extends State<AlbumList> {
  List _list = [];

  @override
  void didUpdateWidget(AlbumList oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.albumListList.length > 0) {
      final int count = (widget.albumListList.length / 3).round();
      for (var i = 0; i < count; i++) {
        _list.add([
          widget.albumListList[i * 3],
          widget.albumListList[i * 3 + 1],
          widget.albumListList[i * 3 + 2],
        ]);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: CarouselSlider(
        items: _list.map(
          (index) {
            return Container(
              margin: EdgeInsets.only(
                top: AppSize.PADDING_SIZE_B,
                bottom: AppSize.PADDING_SIZE_B,
              ),
              height: 280,
              child: Column(
                children: [
                  MusicItemListView(item: index[0]),
                  Container(
                    margin: EdgeInsets.only(
                      top: AppSize.PADDING_SIZE_B,
                      bottom: AppSize.PADDING_SIZE_B,
                    ),
                    child: MusicItemListView(
                      item: index[1],
                    ),
                  ),
                  MusicItemListView(item: index[2]),
                ],
              ),
            );
          },
        ).toList(),
        options: CarouselOptions(
          height: 280,
          viewportFraction: 0.95,
          reverse: false,
          enableInfiniteScroll: false,
          disableCenter: true,
        ),
      ),
    );
  }
}
