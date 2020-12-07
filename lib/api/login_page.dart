import 'package:music_mobile/utils/request.dart';

// 使用单例
class ApiLogin {
  factory ApiLogin() => _getInstance();
  static ApiLogin _instance;
  Request _request;

  static ApiLogin _getInstance() {
    if (_instance == null) {
      _instance = ApiLogin._init();
    }
    return _instance;
  }

  ApiLogin._init() {
    _request = Request();
  }
  // 手机登录
  loginPhone(data) {
    return _request.post('/login/cellphone', data);
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
