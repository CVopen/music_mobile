import 'package:music_mobile/utils/request.dart';
// import 'package:provider/provider.dart';

// 使用单例
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

  // 刷新登录
  refreshLogin() => _request.get('/login/refresh');

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

  // 所有榜单
  getTopList() => _request.get('/toplist');

  // 排行榜详情 传入排行榜id
  getTopListDetail(data) => _request.get('/top/list', data: data);

  // 获取等级
  getLevel() => _request.get('/user/level');

  // 获取用户信息 , 歌单，收藏，mv, dj 数量
  getSubcount() => _request.get('/user/subcount');

  // 喜欢音乐列表
  getLikeLists(data) => _request.get('/likelist', data: data);

  // 喜欢音乐列表
  getPlaylist(data) => _request.get('/user/playlist', data: data);

  // 新建歌单
  createPalyList(data) => _request.post('/playlist/create', data);

  // 新建歌单
  deletePalyList(data) => _request.get('/playlist/delete', data: data);

  // 最新MV
  getMvFirst(data) => _request.get('/mv/first', data: data);

  // 全部MV
  getMvAll(data) => _request.get('/mv/all', data: data);

  // 推荐MV
  getPersonalizedMv() => _request.get('/personalized/mv');

  // 网易出品MV
  getRcmdMv(data) => _request.get('/mv/exclusive/rcmd', data: data);

  // 获取 mv 点赞转发评论数数据
  getDetail(data) => _request.get('/mv/detail/info', data: data);
}
