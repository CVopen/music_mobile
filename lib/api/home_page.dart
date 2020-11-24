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
  // 获取banner
  getBanner({data}) {
    if (data != null) {
      return _request.get('/banner', data: data);
    } else {
      return _request.get('/banner');
    }
  }

  // 推荐歌单
  getPersonalized(data) {
    return _request.get('/personalized', data: data);
  }

  // 数字专辑-新碟上架
  getAlbumNewest(data) {
    return _request.get('/album/newest', data: data);
  }
}
