import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:audioplayers/audioplayers.dart';
import 'dart:convert' as convert;

import 'package:shared_preferences/shared_preferences.dart';

class AudioInfo with ChangeNotifier {
  List playList = []; // 播放列表
  Map music = {}; // 当前播放音乐数据
  bool isInfo = false; // 首次进入应用是否存在播放数据
  bool isPlay = false; // 是否播放
  AudioPlayer audioPlayer = AudioPlayer();

  int allTime = 0; // 当前播放歌曲总长
  int nowTime = 0; // 播放进度

  int mode = 0; // 0顺序 1 单曲 2 随机

  AudioInfo() {
    // 获取初始值
    _getPrefesMusic();
    // 播放进度
    audioPlayer.onAudioPositionChanged.listen((Duration p) async {
      nowTime = p.inMilliseconds;
      if (nowTime > allTime) {
        print('我比你大');
      }
      notifyListeners();
    });
    // 返回的音频的总的时长
    audioPlayer.onDurationChanged.listen((Duration d) {
      allTime = d.inMilliseconds;
      notifyListeners();
    });

    // 完成事件
    audioPlayer.onPlayerCompletion.listen((event) async {
      if (mode == 0) {
        for (int i = 0; i < playList.length; i++) {
          if (music['id'] == playList[i]['id']) {
            int index;
            i == playList.length - 1 ? index = 0 : index = i + 1;
            music = playList[index];
            _setPrefesMusic(music);
            play(music['id']);
            break;
          }
        }
      } else if (mode == 1) {
        await audioPlayer.stop();
        await audioPlayer.resume();
      } else if (mode == 2) {
        int index = _createIndex(playList.length, music['id']);
        music = playList[index];
        _setPrefesMusic(playList[index]);
        play(music['id']);
      }
    });
  }

  get musicInfo {
    return music;
  }

  get isPlayer {
    return isPlay;
  }

  set setMode(int data) {
    mode = data;
    _setPrefesMode(data);
    notifyListeners();
  }

  // item点击播放
  void setInfo(Map info) {
    if (music['id'] != info['id']) {
      music = info;
      playList.add(info);
      _setPrefesMusic(info);
      _setPrefesList();
      play(info['id']);
    } else {
      allTime == 0 ? play(info['id']) : resume();
    }
  }

  // 播放
  void play(int id) async {
    await audioPlayer.stop();
    await audioPlayer
        .play('https://music.163.com/song/media/outer/url?id=$id.mp3');
    isPlay = true;
    isInfo = false;
    notifyListeners();
  }

  // 暂停
  void pause() async {
    await audioPlayer.pause();
    isPlay = false;
    notifyListeners();
  }

  // 恢复播放
  void resume() async {
    await audioPlayer.resume();
    isPlay = true;
    notifyListeners();
  }

  // 跳过
  void seek(date) async {
    await audioPlayer.seek(Duration(milliseconds: date));
  }

  //随机生成单个索引
  int _createIndex(max, id) {
    if (max == 1) return 0;
    int index = Random().nextInt(max);
    if (playList[index]['id'] == id) {
      index = _createIndex(max, id);
    }
    return index;
  }

  void _setPrefesMusic(Map data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('playInfo', convert.jsonEncode(data));
  }

  void _setPrefesMode(int mode) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('mode', mode);
  }

  void _setPrefesList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('playList', convert.jsonEncode(playList));
  }

  void _getPrefesMusic() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // ignore: await_only_futures
    String playInfo = await prefs.getString('playInfo');

    // ignore: await_only_futures
    int playMode = await prefs.getInt('mode');

    // ignore: await_only_futures
    String lists = await prefs.getString('playList');
    List listP;
    lists == null ? listP = [] : listP = await convert.jsonDecode(lists);

    if (playInfo != null) {
      music = convert.jsonDecode(playInfo);
      isInfo = true;
    }

    playMode == null ? _setPrefesMode(0) : mode = playMode;

    playList = listP;
    notifyListeners();
  }
}
