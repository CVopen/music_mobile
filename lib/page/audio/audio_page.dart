import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:music_mobile/common/variable.dart';
import 'package:music_mobile/store/audio_info.dart';
import 'package:music_mobile/utils/format.dart';
import 'package:music_mobile/widget/Header.dart';
import 'package:provider/provider.dart';

class AudioPage extends StatefulWidget {
  @override
  _AudioPageState createState() => _AudioPageState();
}

class _AudioPageState extends State<AudioPage> {
  @override
  Widget build(BuildContext context) {
    final _barHeight = MediaQueryData.fromWindow(window).padding.top; // 获取状态栏高度
    final _size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(0xFF090e42),
      body: Consumer<AudioInfo>(
        builder: (context, t, child) {
          return Stack(
            children: [
              FadeInImage.assetNetwork(
                placeholder: 'assets/images/audio_bg.jpg',
                image: t.musicInfo['al']['picUrl'],
                fit: BoxFit.fitWidth,
              ),
              const Mask(),
              Positioned(
                top: _barHeight,
                child: HeaderWidget(
                  back: Icons.keyboard_arrow_down,
                  rightWidget: Container(width: 40.0),
                  content: Column(
                    children: [
                      Text(
                        t.musicInfo['name'],
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: AppSize.FONT_SIZE_M,
                          height: 1,
                        ),
                      ),
                      Expanded(child: Text('')),
                      Text(
                        t.musicInfo['ar'][0]['name'],
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: AppSize.FONT_SIZE_S,
                          height: 1,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: _size.height / 3,
                width: _size.width,
                child: Column(
                  children: [
                    SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        trackHeight: 2,
                        thumbShape:
                            RoundSliderThumbShape(enabledThumbRadius: 5),
                        overlayShape: RoundSliderOverlayShape(
                          overlayRadius: 12.0,
                        ),
                      ),
                      child: Slider(
                        value: t.nowTime / 1,
                        min: 0,
                        max: t.allTime / 1,
                        activeColor: Color(0xffec7194),
                        onChanged: (double newValue) {
                          setState(() {
                            t.seek(newValue.toInt());
                          });
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            formatDuration(t.nowTime),
                            style:
                                TextStyle(color: Colors.white.withOpacity(0.7)),
                          ),
                          Text(formatDuration(t.allTime),
                              style: TextStyle(
                                  color: Colors.white.withOpacity(0.7)))
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: _size.height / 6 + 20,
                width: _size.width,
                left: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.fast_rewind,
                      color: Colors.white54,
                      size: 42.0,
                    ),
                    const SizedBox(width: 32.0),
                    Container(
                      decoration: BoxDecoration(
                          color: Color(0xffec7194),
                          borderRadius: BorderRadius.circular(50.0)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          child: Icon(
                            t.isPlayer ? Icons.pause : Icons.play_arrow,
                            size: 46.0,
                            color: Colors.white,
                          ),
                          onTap: () {
                            t.isInfo
                                ? t.play(t.music['id'])
                                // ignore: unnecessary_statements
                                : (t.isPlayer ? t.pause() : t.resume());
                          },
                        ),
                      ),
                    ),
                    const SizedBox(width: 32.0),
                    const Icon(
                      Icons.fast_forward,
                      color: Colors.white54,
                      size: 42.0,
                    )
                  ],
                ),
              ),
              Positioned(
                bottom: 50,
                width: _size.width,
                left: 0,
                child: PlayModel(),
              ),
            ],
          );
        },
      ),
    );
  }
}

// 底部切换
class PlayModel extends StatefulWidget {
  @override
  _PlayModelState createState() => _PlayModelState();
}

class _PlayModelState extends State<PlayModel> {
  int _play = 0;
  List _palyIcon = [
    Icons.repeat,
    Icons.repeat_one,
    Icons.shuffle,
  ];
  bool _isList = false;

  @override
  void initState() {
    super.initState();
    setState(() {
      _play = Provider.of<AudioInfo>(context, listen: false).mode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        InkWell(
          highlightColor: Colors.transparent,
          radius: 0.0,
          child: Icon(
            _isList ? Icons.favorite : Icons.favorite_border,
            size: 28,
            color: Color(0xffec7194),
          ),
          onTap: () {
            setState(() {
              _isList = !_isList;
            });
          },
        ),
        InkWell(
          highlightColor: Colors.transparent,
          radius: 0.0,
          child: Icon(
            _palyIcon[_play],
            color: Color(0xffec7194),
            size: 28,
          ),
          onTap: () {
            setState(() {
              _play++;
              if (_play > 2) _play = 0;
              Provider.of<AudioInfo>(context, listen: false).setMode = _play;
            });
          },
        ),
        InkWell(
          highlightColor: Colors.transparent,
          radius: 0.0,
          child: Icon(
            Icons.queue_music,
            color: Color(0xffec7194),
            size: 28,
          ),
          onTap: () {},
        ),
      ],
    );
  }
}

// 遮罩颜色
class Mask extends StatelessWidget {
  const Mask({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFF090e42).withOpacity(0.4),
            Color(0xff1a1d45),
            Color(0xFFfd5f74).withOpacity(0.6)
          ],
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
        ),
      ),
    );
  }
}
