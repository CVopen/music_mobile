import 'package:flutter/material.dart';
import 'package:music_mobile/common/variable.dart';
import 'package:music_mobile/store/audio_info.dart';
import 'package:music_mobile/store/theme_model.dart';
import 'package:music_mobile/widget/image_radius.dart';
import 'package:provider/provider.dart';

class ModelMusic extends StatelessWidget {
  final bool isStay;

  const ModelMusic({Key key, this.isStay = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: Material(
        child: Container(
          height: _size.height / 2,
          child: Column(
            children: [
              Container(
                height: 40,
                padding: EdgeInsets.only(
                    left: AppSize.PADDING_SIZE_B,
                    right: AppSize.PADDING_SIZE_B),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Color(AppColors.BORDER_COLOR2).withOpacity(.8),
                      width: .3,
                    ),
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        '播放列表',
                        style: TextStyle(
                          color: Color(
                              Provider.of<ThemeModel>(context, listen: false)
                                  .getColor),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    InkWell(
                      child: Icon(
                        Icons.close_outlined,
                        color: Color(
                            Provider.of<ThemeModel>(context, listen: false)
                                .getColor),
                      ),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    )
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: AppSize.PADDING_SIZE_B,
                      right: AppSize.PADDING_SIZE_B),
                  child: Consumer<AudioInfo>(
                    builder: (BuildContext context, value, Widget child) {
                      return ListView.builder(
                        itemBuilder: (BuildContext context, int index) {
                          return ModelItem(
                            item: value.playList[index],
                            number: index,
                            stay: isStay,
                          );
                        },
                        itemCount: value.playList.length,
                      );
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ModelItem extends StatelessWidget {
  final Map item;
  final int number;
  final bool stay;

  const ModelItem({Key key, @required this.item, this.number, this.stay})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
          top: AppSize.PADDING_SIZE_S, bottom: AppSize.PADDING_SIZE_S),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Color(AppColors.BORDER_COLOR2).withOpacity(.8),
            width: .3,
          ),
        ),
      ),
      child: InkWell(
        onTap: () {
          Provider.of<AudioInfo>(context, listen: false).setInfo(item, number);
          Navigator.pop(context);
          if (!stay) Navigator.pushNamed(context, '/audio_page');
        },
        child: Row(
          children: [
            Container(
              margin: EdgeInsets.only(right: AppSize.PADDING_SIZE_B),
              child: ImageRadius(
                item['al']['picUrl'],
                40,
                40,
              ),
            ),
            Expanded(
              child: Text(
                item['name'],
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: const TextStyle(
                  color: Color(AppColors.FONT_EM_COLOR),
                  fontSize: AppSize.FONT_SIZE_M,
                  decoration: TextDecoration.none,
                  height: 1,
                ),
              ),
            ),
            Offstage(
              offstage:
                  Provider.of<AudioInfo>(context, listen: false).music['id'] ==
                          item['id']
                      ? false
                      : true,
              child: Icon(
                Icons.headset,
                color: Color(
                    Provider.of<ThemeModel>(context, listen: false).getColor),
              ),
            ),
            const SizedBox(width: AppSize.BOX_SIZE_WIDTH_B),
            InkWell(
              highlightColor: Colors.transparent,
              radius: 0.0,
              child: Icon(
                //  Icons.favorite
                Icons.favorite_border,
                color: Color(
                    Provider.of<ThemeModel>(context, listen: false).getColor),
              ),
              onTap: () {},
            ),
            const SizedBox(width: AppSize.BOX_SIZE_WIDTH_B),
            InkWell(
              child: Icon(
                Icons.close_outlined,
                color: Color(
                    Provider.of<ThemeModel>(context, listen: false).getColor),
              ),
              onTap: () {
                Provider.of<AudioInfo>(context, listen: false).removeList(item);
              },
            ),
          ],
        ),
      ),
    );
  }
}
