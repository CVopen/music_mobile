import 'package:flutter/material.dart';
import 'package:music_mobile/store/theme_model.dart';
import 'package:provider/provider.dart';
import '../../../../common/variable.dart';

// 我喜欢的音乐
class LikeMusic extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        top: AppSize.PADDING_SIZE,
        left: AppSize.PADDING_SIZE,
        right: AppSize.PADDING_SIZE,
      ),
      padding: const EdgeInsets.all(AppSize.PADDING_SIZE_B),
      decoration: const BoxDecoration(
        color: Color(AppColors.BACKGROUND_COLOR),
        borderRadius: BorderRadius.all(
          Radius.circular(AppSize.BORDER_RADIUS_S),
        ),
      ),
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
                    color: Color(Provider.of<ThemeModel>(context, listen: true)
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
          const Text(
            '0 首',
            style: TextStyle(color: Color(AppColors.FONT_COLOR)),
          ),
        ],
      ),
    );
  }
}
