import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:audioplayers/audioplayers.dart';
import 'dart:convert' as convert;

import 'package:shared_preferences/shared_preferences.dart';

class AudioInfo with ChangeNotifier {
  List playList = []; // 播放列表
  List shuffleList = []; // 随机播放列表
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
      if (p.inMilliseconds <= allTime) {
        nowTime = p.inMilliseconds;
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
        int index = _createIndex();
        music = playList[index];
        shuffleList.add(playList[index]);
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
  void setInfo(Map info, [int index]) {
    if (music['id'] != info['id']) {
      music = info;
      _setPrefesMusic(info);
      if (index == null) {
        playList.add(info);
        _setPrefesList();
      }

      if (!shuffleList.contains(info)) {
        shuffleList.add(info);
      }

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

  // 上下首
  void playSong(String str) {
    if (mode == 2) {
      if (str == 'last') {
        for (int i = 0; i < shuffleList.length; i++) {
          if (music['id'] == shuffleList[i]['id']) {
            int index;
            if (i != 0) {
              index = i - 1;
            } else {
              index = _createIndex();
              music = playList[index];
              _setPrefesMusic(playList[index]);
            }
            music = shuffleList[index];

            _setPrefesMusic(music);
            play(music['id']);
            break;
          }
        }
      } else {
        int index = _createIndex();
        print('${playList[index]['id']}   ${music['id']}');
        music = playList[index];
        shuffleList.add(playList[index]);

        _setPrefesMusic(playList[index]);
        play(music['id']);
      }
    } else {
      for (int i = 0; i < playList.length; i++) {
        if (music['id'] == playList[i]['id']) {
          int index;
          if (str == 'next') {
            i == playList.length - 1 ? index = 0 : index = i + 1;
          } else {
            i == 0 ? index = playList.length - 1 : index = i - 1;
          }
          music = playList[index];
          shuffleList = [playList[index]];
          _setPrefesMusic(music);
          play(music['id']);
          break;
        }
      }
    }
  }

  //随机 下一首索引
  int _createIndex() {
    int index = Random().nextInt(playList.length);

    if (shuffleList.length >= playList.length) {
      if (music['id'] == playList[index]['id']) {
        _createIndex();
      }
    } else {
      for (int i = 0; i < shuffleList.length; i++) {
        if (playList[index]['id'] == shuffleList[i]['id']) {
          _createIndex();
          break;
        }
      }
    }

    return index;
  }

  void removeList(Map data) {
    if (data['id'] == music['id']) {
      playSong('next');
      playList.remove(data);
    } else {
      playList.remove(data);
      notifyListeners();
    }
    _setPrefesList();
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
      shuffleList = [convert.jsonDecode(playInfo)];
    }

    playMode == null ? _setPrefesMode(0) : mode = playMode;

    playList = listP;
    notifyListeners();
  }
}
