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

  // 邮箱登录
  login(data) {
    return _request.post('/login', data);
  }

  // 发送验证码
  sendCode(data) {
    return _request.get('/captcha/sent', data: data);
  }

  // 验证验证码
  verify(data) {
    return _request.get('/captcha/verify', data: data);
  }

  // 退出登录
  logout() => _request.get('/logout');
}
