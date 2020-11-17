import 'package:music_mobile/utils/request.dart';

// 使用单例模式定义 home路由
// 不使用单例模式也可以在api.dart 统一存放到map中
class ApiHome {
  factory ApiHome() => _getInstance();
  static ApiHome _instance;
  Request _request;

  static ApiHome _getInstance() {
    if (_instance == null) {
      _instance = ApiHome._init();
    }
    return _instance;
  }

  ApiHome._init() {
    _request = Request();
  }

  getBanner(data) => _request.get(path: '/banner', data: data); // 获取banner
}
