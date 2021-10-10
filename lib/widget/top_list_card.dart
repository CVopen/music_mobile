import 'package:flutter/material.dart';
import 'package:music_mobile/api/home_page.dart';
import 'package:music_mobile/common/variable.dart';
import 'package:music_mobile/utils/format.dart';

import 'image_radius.dart';

class TopListCard extends StatefulWidget {
  final int id;

  const TopListCard({Key key, this.id}) : super(key: key);
  @override
  _TopListCardState createState() => _TopListCardState();
}

class _TopListCardState extends State<TopListCard> {
  List list = [];

  @override
  void initState() {
    super.initState();
    // new Future.delayed(Duration(seconds: 3), () {
    this._getDetail();
    // });
  }

  Future _getDetail() async {
    var res = await ApiHome().getTopListDetail({'id': widget.id});
    List count = createArr(3, res.data["playlist"]["tracks"].length);
    List arr = [];
    count.forEach((element) {
      arr.add(res.data["playlist"]["tracks"][element]);
    });
    setState(() {
      list = arr;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 270,
      child: Column(
        children: list.map((e) {
          return MusicItemListView(e);
        }).toList(),
      ),
    );
  }
}

class MusicItemListView extends StatelessWidget {
  final Map item;

  const MusicItemListView(this.item, {Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    final _width = _size.width;
    return Container(
      margin: const EdgeInsets.fromLTRB(AppSize.PADDING_SIZE_B, 0,
          AppSize.PADDING_SIZE_B, AppSize.PADDING_SIZE_B),
      height: 80,
      width: _width,
      child: Row(
        children: [
          Container(
            child: ImageRadius(item['al']['picUrl'], 80.0, 80.0),
          ),
          SizedBox(
            width: AppSize.BOX_SIZE_WIDTH_M,
          ),
          Expanded(
            child: Container(
              height: 80,
              padding: EdgeInsets.only(
                top: AppSize.PADDING_SIZE,
                bottom: AppSize.PADDING_SIZE,
              ),
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    width: 0.5,
                    color: Color(AppColors.BORDER_COLOR2),
                    style: BorderStyle.solid,
                  ),
                ),
              ),
              child: Flex(
                direction: Axis.vertical,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Text(
                      item['name'],
                      style: const TextStyle(
                        color: Color(AppColors.FONT_EM_COLOR),
                        fontSize: AppSize.FONT_SIZE_M,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(
                      item["ar"][0]["name"],
                      style: const TextStyle(
                        color: Color(AppColors.FONT_COLOR),
                        fontSize: AppSize.FONT_SIZE_S,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            width: AppSize.BOX_SIZE_WIDTH_M,
          ),
        ],
      ),
    );
  }
}
