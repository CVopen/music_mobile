import 'package:flutter/material.dart';
import 'package:music_mobile/api/video_page.dart';
import 'package:music_mobile/common/variable.dart';
import 'package:music_mobile/utils/format.dart';
import 'package:music_mobile/widget/Header.dart';
import 'package:music_mobile/widget/image_radius.dart';
import 'package:screen/screen.dart';
import 'package:video_player/video_player.dart';

class PlayWidget extends StatefulWidget {
  final String id;

  const PlayWidget({Key key, @required this.id}) : super(key: key);

  @override
  _PlayWidgetState createState() => _PlayWidgetState();
}

class _PlayWidgetState extends State<PlayWidget> {
  VideoPlayerController _controller;
  double _valuePosition = 0; // 进度条当前值
  double _valueMax = 0; // 进度条最大值
  bool _isIcon = true;
  Map _videoDetail; // 视频详情

  @override
  void initState() {
    super.initState();
    this._getVideoUrl();
    this._getVideoDetail();
  }

  _isPlay() {
    _controller.value.isPlaying ? _controller.pause() : _controller.play();
    // 播放保持屏幕常亮
    _controller.value.isPlaying ? Screen.keepOn(true) : Screen.keepOn(false);
    setState(() {
      _isIcon = _controller.value.isPlaying;
    });
  }

  // 重新播放
  _replay() {
    setState(() {
      _valuePosition = 0.0;
      _controller.seekTo(Duration(milliseconds: 0));
      if (!_controller.value.isPlaying) _controller.play();
    });
  }

  // 获取视频详情
  _getVideoDetail() async {
    var res = await ApiVideo().getDetail({'id': widget.id});
    setState(() {
      _videoDetail = res.data['data'];
    });
  }

  _getVideoUrl() async {
    var res = await ApiVideo().getUrl({'id': widget.id});
    _initVideo(res.data['urls'][0]['url']);
  }

  _initVideo(url) {
    _controller = VideoPlayerController.network(url)
      ..initialize().then((_) {
        setState(() {
          if (_controller.value.initialized) {
            _controller.play();
          }
        });
      });

    _controller.addListener(() {
      setState(() {
        _valuePosition = _controller.value.position.inMilliseconds.toDouble();
        _valueMax = _controller.value.duration.inMilliseconds.toDouble();
        if (_valuePosition == _valueMax) {
          _replay();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    return Stack(
      children: [
        _controller == null
            ? Container(
                height: _size.height,
                child: Center(child: Image.asset('assets/images/loading.gif')),
              )
            : GestureDetector(
                onTap: _isPlay,
                child: Container(
                  height: _size.height,
                  child: Center(
                    child: _controller.value.initialized
                        ? AspectRatio(
                            aspectRatio: _controller.value.aspectRatio,
                            child: VideoPlayer(_controller),
                          )
                        : Container(),
                  ),
                ),
              ),
        Offstage(
          offstage: _isIcon,
          child: Center(
            child: InkWell(
              highlightColor: Colors.transparent,
              radius: 0.0,
              onTap: _isPlay,
              child: const Icon(
                Icons.play_arrow_rounded,
                color: Colors.white,
                size: 50,
              ),
            ),
          ),
        ),
        const Positioned(
          top: 0,
          child: HeaderWidget(back: Icons.keyboard_backspace),
        ),
        Positioned(
          bottom: 0,
          child: Container(
            width: _size.width,
            child: SliderTheme(
              data: SliderTheme.of(context).copyWith(
                trackHeight: 2,
                thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 5),
                overlayShape: const RoundSliderOverlayShape(
                  overlayRadius: 12.0,
                ),
              ),
              child: Slider(
                value: _valuePosition,
                min: 0,
                max: _valueMax,
                activeColor: Colors.white,
                onChanged: (double newValue) {},
              ),
            ),
          ),
        ),
        _videoDetail != null
            ? Positioned(
                bottom: 20,
                child: Container(
                  width: _size.width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          children: [
                            ImageRadius(
                                _videoDetail['creator']['avatarUrl'], 30, 30),
                            const SizedBox(width: 5.0),
                            Text(
                              '${_videoDetail['creator']['nickname']}',
                              style: const TextStyle(
                                fontSize: AppSize.FONT_SIZE_B,
                                color: Color(AppColors.BACKGROUND_COLOR),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Text(
                          _videoDetail['description'] != null
                              ? _videoDetail['description']
                              : '',
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: AppSize.FONT_SIZE_M,
                            color: Color(AppColors.BACKGROUND_COLOR),
                          ),
                        ),
                      ),
                      Text(
                        '${computePlay(_videoDetail['playTime'])}次播放',
                        style: const TextStyle(
                          fontSize: AppSize.FONT_SIZE_S,
                          color: Color(AppColors.FONT_COLOR),
                        ),
                      )
                    ],
                  ),
                ),
              )
            : const Text(''),
        _videoDetail != null
            ? Positioned(
                right: 10,
                bottom: 30,
                child: Container(
                  child: Column(
                    children: [
                      Column(
                        children: [
                          const Icon(
                            Icons.thumb_up,
                            color: Colors.white,
                          ),
                          Text(
                            computePlay(_videoDetail['praisedCount']),
                            style: const TextStyle(
                              fontSize: AppSize.FONT_SIZE_S,
                              color: Color(AppColors.FONT_COLOR),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 20),
                      Column(
                        children: [
                          const Icon(
                            Icons.chat,
                            color: Colors.white,
                          ),
                          Text(
                            computePlay(_videoDetail['commentCount']),
                            style: const TextStyle(
                              fontSize: AppSize.FONT_SIZE_S,
                              color: Color(AppColors.FONT_COLOR),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 20),
                      Column(
                        children: [
                          const Icon(
                            Icons.reply,
                            color: Colors.white,
                          ),
                          Text(
                            computePlay(_videoDetail['shareCount']),
                            style: const TextStyle(
                              fontSize: AppSize.FONT_SIZE_S,
                              color: Color(AppColors.FONT_COLOR),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              )
            : const Text('')
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
