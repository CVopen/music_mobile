import 'package:flutter/material.dart';
import '../../../../common/variable.dart';
import 'recommend_music.dart';
import 'album_list.dart';

class ContainerTitle extends StatefulWidget {
  final List list;
  final String title;

  const ContainerTitle({Key key, this.list, this.title}) : super(key: key);
  @override
  _ContainerTitleState createState() => _ContainerTitleState();
}

class _ContainerTitleState extends State<ContainerTitle> {
  _returnWidget() {
    switch (widget.title) {
      case '推荐歌单':
        return RecommendMusic(personalizedList: widget.list);
        break;
      case '新碟上架':
        return AlbumList(albumListList: widget.list);
      default:
        return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(
            left: AppSize.PADDING_SIZE_B,
            right: AppSize.PADDING_SIZE_B,
          ),
          child: Row(
            children: [
              Text(
                widget.title,
                style: TextStyle(
                  color: Color(AppColors.FONT_MAIN_COLOR),
                  fontSize: AppSize.FONT_SIZE_B,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Expanded(child: Text('')),
              InkWell(
                onTap: () {
                  print('查看更多');
                },
                child: Container(
                  padding: EdgeInsets.only(
                    top: 2,
                    left: 5,
                    right: 5,
                    bottom: 2,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(AppSize.BORDER_RADIUS),
                    ),
                    color: Color(AppColors.BACKGROUND_COLOR),
                    border: Border.all(
                      width: 1,
                      color: Color(AppColors.BORDER_COLOR),
                    ),
                  ),
                  child: Text(
                    '查看更多',
                    style: TextStyle(
                      color: Color(AppColors.FONT_MAIN_COLOR),
                      fontSize: AppSize.FONT_SIZE_S,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        _returnWidget()
      ],
    );
  }
}