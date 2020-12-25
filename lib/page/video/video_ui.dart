import 'dart:async';
import 'dart:ui';

import 'package:auto_orientation/auto_orientation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:music_mobile/utils/format.dart';
import 'package:music_mobile/widget/Header.dart';
import 'package:video_player/video_player.dart';
import 'package:screen/screen.dart';
import 'package:volume_control/volume_control.dart';

class VideoUi extends StatefulWidget {
  final ValueChanged<bool> callback;
  final Map router;

  const VideoUi({
    Key key,
    @required this.callback,
    @required this.router,
  }) : super(key: key);
  @override
  _VideoUiState createState() => _VideoUiState();
}

class _VideoUiState extends State<VideoUi> {
  bool _isShow = true; // 是否显示控制器
  Timer _timer;
  bool _isFullScreen = false; // 是否全屏
  VideoPlayerController _controller;

  double _valuePosition = 0; // 进度条当前值
  double _valueMax = 0; // 进度条最大值

  bool _playEnd = false; // 是否播放结束

  String _url;

  Offset _onPanDown; // 滑动开始时位置
  Offset _optionsPlay;

  double _valControl = 0; //亮度和音量
  bool _showBright = true;
  bool _showVolume = true;
  bool _showControl = true;

  @override
  void initState() {
    super.initState();
    _initPlay(widget.router['url']);
  }

  // 监听播放
  _initPlay(video) {
    setState(() {
      _url = video;
    });
    _controller = VideoPlayerController.network(video)
      ..initialize().then((_) {
        _playVideo();
        setState(() {});
      });

    _controller.addListener(() {
      setState(() {
        _valuePosition = _controller.value.position.inMilliseconds.toDouble();
        _valueMax = _controller.value.duration.inMilliseconds.toDouble();
        if (_valuePosition == _valueMax) _playEnd = true;
      });
    });
  }

  // 播放
  void _playVideo() {
    setState(() {
      if (_playEnd) _replay();
      _controller.value.isPlaying ? _controller.pause() : _controller.play();
      // 播放保持屏幕常亮
      _controller.value.isPlaying ? Screen.keepOn(true) : Screen.keepOn(false);
    });
  }

  // 滑动快进
  void _playStep() {
    setState(() {
      _playEnd = false;
      _controller.seekTo(Duration(milliseconds: _valuePosition.toInt()));
      if (!_controller.value.isPlaying) _controller.play();
    });
  }

  // 点击play
  void _tapPlayVideo(bool play) {
    if (play) {
      setState(() {
        _isShow = true;
        if (_timer != null) _timer.cancel();
      });
    } else {
      setState(() {
        _isShow = false;
        if (_timer != null) _timer.cancel();
        _timer = Timer(Duration(seconds: 4), () {
          setState(() {
            _isShow = true;
          });
        });
      });
    }
  }

  // 重新播放
  _replay() {
    setState(() {
      _valuePosition = 0.0;
      _playEnd = false;
      _controller.seekTo(Duration(milliseconds: 0));
    });
  }

  // 全屏
  void _toggleFullScreen() {
    setState(() {
      _tapPlayVideo(false);
      if (_isFullScreen) {
        _isFullScreen = false;

        /// 如果是全屏就切换竖屏
        AutoOrientation.portraitAutoMode();

        ///显示状态栏，与底部虚拟操作按钮
        SystemChrome.setEnabledSystemUIOverlays(
            [SystemUiOverlay.top, SystemUiOverlay.bottom]);
      } else {
        AutoOrientation.landscapeAutoMode();
        _isFullScreen = true;

        ///关闭状态栏，与底部虚拟操作按钮
        SystemChrome.setEnabledSystemUIOverlays([]);
      }
      // _startPlayControlTimer(); // 操作完控件开始计时隐藏
      widget.callback(_isFullScreen);
    });
  }

  // 按下事件
  _onPanDwon(DragDownDetails e) {
    //打印手指按下的位置(相对于屏幕)
    setState(() {
      _onPanDown = e.globalPosition;
      _optionsPlay = e.globalPosition;
    });
  }

  _onPanUpdata(DragUpdateDetails e) {
    Size _size = MediaQuery.of(context).size;

    //用户手指滑动时，更新偏移，重新构建
    if ((_onPanDown.dy - e.globalPosition.dy).abs() <= 20 &&
        (_onPanDown.dx - e.globalPosition.dx).abs() > 20) {
      // 进度条滑动
      _setSlider(e, _size);
    } else if ((_onPanDown.dx - e.globalPosition.dx).abs() <= 20 &&
        (_onPanDown.dy - e.globalPosition.dy).abs() > 20) {
      // 亮度和音量
      setState(() {
        _showControl = false;
        if (e.globalPosition.dx < _size.width / 4) {
          _showBright = false;
        } else if (e.globalPosition.dx > _size.width / 4) {
          _showVolume = false;
        }
      });
      _setControl(_size, e);
    }
  }

  // 亮度调节
  _setControl(_size, e) async {
    double _val;
    if (!_showBright) {
      _val = await Screen.brightness;
    } else {
      _val = await VolumeControl.volume;
    }
    double _proportion = (_optionsPlay.dy - e.globalPosition.dy) /
        (_size.width / 1920 * 1080); // 与屏幕高度比例
    double _position = _val + _proportion; // 值
    if (_position < 0) {
      _position = 0;
    } else if (_position > 1) {
      _position = 1;
    }
    !_showBright
        ? Screen.setBrightness(_position)
        : VolumeControl.setVolume(_position);
    setState(() {
      _valControl = _position;
      _optionsPlay = e.globalPosition;
    });
  }

  // 进度条
  _setSlider(e, _size) {
    double _proportion =
        (e.globalPosition.dx - _optionsPlay.dx) / _size.width; // 与屏幕比例
    double _offset = _proportion * _valueMax; // 偏移量
    double _position = _valuePosition + _offset; // 播放进度
    if (_position < 0) {
      _position = 0;
    } else if (_position > _valueMax) {
      _position = _valueMax;
    }
    setState(() {
      _valuePosition = _position;
      _optionsPlay = e.globalPosition;
      _playStep();
    });
  }

  // 结束触摸
  _endPan(DragEndDetails e) {
    setState(() {
      _showBright = true;
      _showVolume = true;
      _showControl = true;
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    if (_timer != null) _timer.cancel();
  }

  @override
  void didUpdateWidget(VideoUi oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.router['url'] != _url) {
      _controller.dispose();
      _initPlay(widget.router['url']);
    }
  }

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    final _barHeight = MediaQueryData.fromWindow(window).padding.top; // 获取状态栏高度

    return Stack(
      children: [
        _controller.value.initialized
            ? GestureDetector(
                onTap: () {
                  _tapPlayVideo(false);
                },
                onDoubleTap: _playVideo,
                onPanDown: _onPanDwon,
                onPanUpdate: _onPanUpdata,
                onPanEnd: _endPan,
                child: Container(
                  width: _size.width,
                  color: Colors.transparent,
                  height: _size.width > _size.height
                      ? _size.height
                      : _size.width / 1920 * 1080,
                  alignment: Alignment.center,
                  child: AspectRatio(
                    aspectRatio: _controller.value.aspectRatio,
                    child: VideoPlayer(_controller),
                  ),
                ),
              )
            : Container(
                height: _size.width / 1920 * 1080 - _barHeight,
                width: _size.width,
                alignment: Alignment.center,
                child: Image.asset(
                  'assets/images/loading.gif',
                  width: 60,
                  height: 60,
                ),
              ),
        Offstage(
          offstage: _isShow,
          child: GestureDetector(
            onTap: () {
              _tapPlayVideo(true);
            },
            onDoubleTap: _playVideo,
            onPanDown: _onPanDwon,
            onPanUpdate: _onPanUpdata,
            onPanEnd: _endPan,
            child: Container(
              width: _size.width,
              height: _size.width > _size.height
                  ? _size.height
                  : _size.width / 1920 * 1080,
              color: Colors.transparent,
              child: Column(
                children: [
                  Expanded(
                    child: InkWell(
                      highlightColor: Colors.transparent,
                      radius: 0.0,
                      child: Container(
                        margin: EdgeInsets.only(top: _barHeight),
                        child: Icon(
                          _controller.value.isPlaying
                              ? Icons.pause
                              : (_playEnd ? Icons.replay : Icons.play_arrow),
                          size: 44,
                          color: Colors.white,
                        ),
                      ),
                      onTap: _playVideo,
                    ),
                  ),
                  Row(
                    children: [
                      const SizedBox(width: 5.0),
                      Text(
                        formatDuration(_valuePosition),
                        style: const TextStyle(color: Colors.white),
                      ),
                      Expanded(
                        child: SliderTheme(
                          data: SliderTheme.of(context).copyWith(
                            trackHeight: 2,
                            thumbShape: const RoundSliderThumbShape(
                                enabledThumbRadius: 5),
                            overlayShape: const RoundSliderOverlayShape(
                              overlayRadius: 12.0,
                            ),
                          ),
                          child: Slider(
                            value: _valuePosition,
                            min: 0,
                            max: _valueMax,
                            activeColor: Colors.white,
                            onChanged: (double newValue) {
                              setState(() {
                                _valuePosition = newValue;
                                _playStep();
                              });
                            },
                          ),
                        ),
                      ),
                      Text(
                        formatDuration(_valueMax),
                        style: TextStyle(color: Colors.white),
                      ),
                      Container(
                        padding: const EdgeInsets.all(10),
                        child: InkWell(
                          highlightColor: Colors.transparent,
                          radius: 0.0,
                          child: Icon(
                            _isFullScreen
                                ? Icons.fullscreen_exit
                                : Icons.fullscreen,
                            size: 30,
                            color: Colors.white,
                          ),
                          onTap: _toggleFullScreen,
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
        Positioned(
          top: 0,
          child: Offstage(
            offstage: _isShow,
            child: HeaderWidget(
              back: Icons.keyboard_backspace,
              callback: (value) {
                if (_isFullScreen) {
                  _toggleFullScreen();
                } else {
                  Navigator.of(context).pop();
                }
              },
              content: Container(
                width: _size.width / 2,
                alignment: Alignment.center,
                child: Text(
                  widget.router['name'],
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ),
        Positioned(
          top: 50,
          left: _size.width / 3,
          child: Offstage(
            offstage: _showControl,
            child: Container(
              width: _size.width / 3,
              height: 30,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(.2),
                borderRadius: BorderRadius.circular(30.0),
              ),
              child: Row(
                children: [
                  !_showBright
                      ? Icon(
                          _valControl > 7.5
                              ? Icons.brightness_1_sharp
                              : (_valControl > 3.5
                                  ? Icons.brightness_2_sharp
                                  : Icons.brightness_3_sharp),
                          color: Colors.white,
                        )
                      : const Text(''),
                  !_showVolume
                      ? Icon(
                          Icons.volume_down_outlined,
                          color: Colors.white,
                        )
                      : const Text(''),
                  Expanded(
                    child: SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        trackHeight: 2,
                        thumbShape:
                            const RoundSliderThumbShape(enabledThumbRadius: 5),
                        overlayShape: const RoundSliderOverlayShape(
                          overlayRadius: 12.0,
                        ),
                      ),
                      child: Slider(
                        value: _valControl,
                        min: 0,
                        max: 1,
                        activeColor: Colors.white,
                        onChanged: (double newValue) {},
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
