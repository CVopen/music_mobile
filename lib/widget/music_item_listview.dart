import 'package:flutter/material.dart';
import 'package:music_mobile/common/variable.dart';
import 'image_radius.dart';

class MusicItemListView extends StatefulWidget {
  final Map item;

  const MusicItemListView({Key key, this.item}) : super(key: key);
  @override
  _MusicItemListViewState createState() => _MusicItemListViewState();
}

class _MusicItemListViewState extends State<MusicItemListView> {
  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    final _width = _size.width;
    return Container(
      height: 80,
      width: _width,
      child: Row(
        children: [
          Container(
            child: ImageRadius(widget.item['picUrl'], 80.0, 80.0),
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
              decoration: BoxDecoration(
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
                    child: OverflowBox(
                      alignment: Alignment.centerLeft,
                      maxWidth: double.infinity,
                      child: Row(
                        children: [
                          Text(
                            widget.item['company'],
                            style: TextStyle(
                              color: Color(AppColors.FONT_EM_COLOR),
                              fontSize: AppSize.FONT_SIZE_M,
                            ),
                          ),
                          Text(
                            ' - ${widget.item['artist']['name']}',
                            style: TextStyle(
                              color: Color(AppColors.FONT_COLOR),
                              fontSize: AppSize.FONT_SIZE_S,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(
                      widget.item['name'],
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Color(AppColors.FONT_COLOR),
                        fontSize: AppSize.FONT_SIZE_S,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            width: AppSize.BOX_SIZE_WIDTH_M,
          ),
        ],
      ),
    );
  }
}
