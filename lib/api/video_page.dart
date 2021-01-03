import 'package:music_mobile/utils/request.dart';

class ApiVideo {
  factory ApiVideo() => _getInstance();
  static ApiVideo _instance;
  Request _request;

  static ApiVideo _getInstance() {
    if (_instance == null) {
      _instance = ApiVideo._init();
    }
    return _instance;
  }

  ApiVideo._init() {
    _request = Request();
  }

  // 获取歌单详情
  getMvUrl(data) {
    return _request.get('/mv/url', data: data);
  }

  // 获取相似 mv
  getSimiMv(data) {
    return _request.get('/simi/mv', data: data);
  }

  // 获取mv 评论
  getComment(data) {
    return _request.get('/comment/mv', data: data);
  }

  // 相关视频
  getRelated(data) {
    return _request.get('/related/allvideo', data: data);
  }

  // 获取视频播放地址
  getUrl(data) {
    return _request.get('/video/url', data: data);
  }

  // 获取视频详情
  getDetail(data) {
    return _request.get('/video/detail', data: data);
  }
}
