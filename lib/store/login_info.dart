import 'package:flutter/cupertino.dart';
import 'dart:convert' as convert;

import 'package:shared_preferences/shared_preferences.dart';

class LoginInfo with ChangeNotifier {
  Map info;

  get loginGet {
    return info;
  }

  set loginSet(data) {
    var _info = data;
    if (data == 'remove') {
      _removePrefes();
    } else {
      if (!(data is Map)) {
        _info = convert.jsonDecode(_info);
      }
      info = _info;
      _setPrefes(_info);
    }

    notifyListeners();
  }

  _setPrefes(data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // ignore: await_only_futures
    String infos = await prefs.getString('userInfo');
    if (infos == null) {
      await prefs.setString('userInfo', convert.jsonEncode(data));
    }
  }

  _removePrefes() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // prefs.clear(); 删除所有
    prefs.remove('userInfo');
  }
}
