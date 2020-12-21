// 使用单例
import 'package:music_mobile/utils/request.dart';

class ApiList {
  factory ApiList() => _getInstance();
  static ApiList _instance;
  Request _request;

  static ApiList _getInstance() {
    if (_instance == null) {
      _instance = ApiList._init();
    }
    return _instance;
  }

  ApiList._init() {
    _request = Request();
  }
  // 获取歌单详情
  getListDetail(data) {
    return _request.get('/playlist/detail', data: data);
  }

  // 获取每日推荐歌曲
  getListRecommend() {
    return _request.get('/recommend/songs');
  }
}
