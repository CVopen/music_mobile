import 'package:flutter/cupertino.dart';
// import 'dart:convert' as convert;

// import 'package:shared_preferences/shared_preferences.dart';

class AudioInfo with ChangeNotifier {
  bool isSHow = false; // 是否显示控件
  List playList = []; // 播放列表

  get show {
    return isSHow;
  }

  set showSet(show) {
    isSHow = show;
    notifyListeners();
  }

  // _setPrefes(data) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   // ignore: await_only_futures
  //   String infos = await prefs.getString('userInfo');
  //   if (infos == null) {
  //     await prefs.setString('userInfo', convert.jsonEncode(data));
  //   }
  // }

  // _removePrefes() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   // prefs.clear(); 删除所有
  //   prefs.remove('userInfo');
  // }
}
