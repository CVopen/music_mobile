import 'package:flutter/material.dart';
import 'package:music_mobile/common/variable.dart';
import 'package:music_mobile/widget/image_radius.dart';

import 'package:audioplayers/audioplayers.dart';

class MusicWidget extends StatefulWidget {
  @override
  _MusicWidgetState createState() => _MusicWidgetState();
}

class _MusicWidgetState extends State<MusicWidget> {
  AudioPlayer audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    // 播放进度
    audioPlayer.onAudioPositionChanged.listen((p) async {
      // p参数可以获取当前进度，也是可以调整的，比如p.inMilliseconds
      // print('我是p $p');
    });
    // 返回的音频的总的时长
    audioPlayer.onDurationChanged.listen((Duration d) {
      // print('Max duration: $d');
      // print(d is double);
      // setState(() => duration = d);
    });

    // 完成事件
    audioPlayer.onPlayerCompletion.listen((event) {
      // onComplete();
      print('完成了');
      setState(() {
        // position = duration;
      });
    });
  }

  // 播放
  play() async {
    int result = await audioPlayer.play(
      "http://m8.music.126.net/20201217004743/0f712cd4fa09429918903f2b2ef38cd9/ymusic/0fd6/4f65/43ed/a8772889f38dfcb91c04da915b301617.mp3",
    );
    if (result == 1) {
      // success
      print('play success');
    } else {
      print('play failed');
    }
  }

  // 暂停
  pause() async {
    int result = await audioPlayer.pause();
    if (result == 1) {
      // success
      print('pause success');
    } else {
      print('pause failed');
    }
  }

  // 跳过
  seek() async {
    int result = await audioPlayer.seek(Duration(milliseconds: 1200));
    if (result == 1) {
      print('go to success');
      // await audioPlayer.resume();
    } else {
      print('go to failed');
    }
  }

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    final _width = _size.width;

    return Container(
      height: 50,
      width: _width,
      padding: EdgeInsets.all(AppSize.PADDING_SIZE_S),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: Color(AppColors.BORDER_COLOR2),
            width: .3,
          ),
        ),
      ),
      child: Material(
        child: InkWell(
          highlightColor: Colors.transparent,
          radius: 0.0,
          onTap: () {
            Navigator.pushNamed(context, '/audio_page');
          },
          child: Row(
            children: [
              Container(
                margin: EdgeInsets.only(right: AppSize.PADDING_SIZE_B),
                child: ImageRadius(
                  'http://p2.music.126.net/RpzIkeUOZ4V7WBecytqH0Q==/109951165515305859.jpg',
                  40,
                  40,
                ),
              ),
              Expanded(
                child: Row(
                  children: [
                    Text(
                      'sfsd',
                      style: const TextStyle(
                        color: Color(AppColors.FONT_EM_COLOR),
                        fontSize: AppSize.FONT_SIZE_M,
                        decoration: TextDecoration.none,
                        height: 1,
                      ),
                    ),
                    Text(
                      ' - asd',
                      style: const TextStyle(
                        height: 1,
                        color: Color(AppColors.FONT_COLOR),
                        fontSize: AppSize.FONT_SIZE_S,
                        decoration: TextDecoration.none,
                      ),
                    ),
                  ],
                ),
              ),
              InkWell(
                highlightColor: Colors.transparent,
                radius: 0.0,
                child: Icon(
                  // Icons.play_circle_outline,
                  Icons.pause_circle_outline,
                  color: Colors.black,
                  size: 28,
                ),
                onTap: () {
                  play();
                },
              ),
              SizedBox(width: AppSize.BOX_SIZE_WIDTH_B),
              InkWell(
                highlightColor: Colors.transparent,
                radius: 0.0,
                child: Icon(
                  Icons.queue_music,
                  color: Colors.black,
                ),
                onTap: () {
                  print('点击打开歌单');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
