import 'package:flutter/material.dart';
import 'package:music_mobile/store/theme_model.dart';
import 'package:provider/provider.dart';
import '../../../../common/variable.dart';

// 我喜欢的音乐
class LikeMusic extends StatelessWidget {
  final Map likeMusic;

  const LikeMusic({Key key, this.likeMusic}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(
          AppSize.PADDING_SIZE, AppSize.PADDING_SIZE, AppSize.PADDING_SIZE, 0),
      padding: const EdgeInsets.all(AppSize.PADDING_SIZE_B),
      decoration: const BoxDecoration(
        color: Color(AppColors.BACKGROUND_COLOR),
        borderRadius: BorderRadius.all(
          Radius.circular(AppSize.BORDER_RADIUS_S),
        ),
      ),
      child: InkWell(
        onTap: () {
          print(likeMusic['id']);
          Navigator.pushNamed(context, '/list_page',
              arguments: {'id': likeMusic['id'], 'title': '喜欢'});
        },
        child: Row(
          children: [
            Container(
              margin: const EdgeInsets.only(right: AppSize.PADDING_SIZE_S),
              child: Stack(
                children: [
                  Opacity(
                    opacity: 0.2,
                    child: Container(
                      width: 50.0,
                      height: 50.0,
                      decoration: BoxDecoration(
                        color: Color(
                            Provider.of<ThemeModel>(context, listen: true)
                                .getColor),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(AppSize.BORDER_RADIUS_S),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 13.0,
                    left: 13.0,
                    child: Icon(
                      Icons.favorite,
                      color: Color(
                          Provider.of<ThemeModel>(context, listen: true)
                              .getColor),
                      size: 24.0,
                    ),
                  ),
                ],
              ),
            ),
            const Expanded(
              child: Text('我喜欢的音乐'),
            ),
            Text(
              '${likeMusic['trackCount']} 首',
              style: const TextStyle(color: Color(AppColors.FONT_COLOR)),
            ),
          ],
        ),
      ),
    );
  }
}
