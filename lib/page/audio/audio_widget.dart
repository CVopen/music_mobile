import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:music_mobile/common/variable.dart';
import 'package:music_mobile/page/audio/model.dart';
import 'package:music_mobile/store/audio_info.dart';
import 'package:music_mobile/store/theme_model.dart';
import 'package:music_mobile/widget/image_radius.dart';

import 'package:provider/provider.dart';

class MusicWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    return Container(
      child: Consumer<AudioInfo>(
        builder: (context, t, child) {
          return t.musicInfo.isEmpty
              ? Container()
              : Container(
                  height: 50,
                  width: _size.width,
                  padding: EdgeInsets.all(AppSize.PADDING_SIZE_S),
                  decoration: BoxDecoration(
                    color: Color(Provider.of<ThemeModel>(context, listen: true)
                            .getColor)
                        .withOpacity(.05),
                    border: Border(
                      top: BorderSide(
                        color: Color(AppColors.BORDER_COLOR2).withOpacity(.8),
                        width: .3,
                      ),
                    ),
                  ),
                  child: InkWell(
                    highlightColor: Colors.transparent,
                    radius: 0.0,
                    onTap: () {
                      Navigator.pushNamed(context, '/audio_page');
                    },
                    child: Row(
                      children: [
                        Container(
                          margin:
                              EdgeInsets.only(right: AppSize.PADDING_SIZE_B),
                          child: ImageRadius(
                            t.musicInfo['al']['picUrl'],
                            40,
                            40,
                            radius: 20,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            t.musicInfo['name'],
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
                        InkWell(
                          highlightColor: Colors.transparent,
                          radius: 0.0,
                          child: Icon(
                            t.isPlayer
                                ? Icons.pause_circle_outline
                                : Icons.play_circle_outline,
                            size: 28,
                            color: Color(
                                Provider.of<ThemeModel>(context, listen: true)
                                    .getColor),
                          ),
                          onTap: () {
                            t.isInfo
                                ? t.play(t.music['id'])
                                // ignore: unnecessary_statements
                                : (t.isPlayer ? t.pause() : t.resume());
                          },
                        ),
                        const SizedBox(width: AppSize.BOX_SIZE_WIDTH_B),
                        InkWell(
                          highlightColor: Colors.transparent,
                          radius: 0.0,
                          child: Icon(
                            Icons.queue_music,
                            color: Color(
                                Provider.of<ThemeModel>(context, listen: true)
                                    .getColor),
                          ),
                          onTap: () {
                            showCupertinoModalBottomSheet(
                              context: context,
                              enableDrag: false,
                              builder: (context) => ModelMusic(),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                );
        },
      ),
    );
  }
}
