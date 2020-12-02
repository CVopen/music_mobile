import 'package:flutter/cupertino.dart';
import 'dart:convert' as convert;

class LoginInfo with ChangeNotifier {
  Map info;

  get loginGet {
    return info;
  }

  set loginSet(data) {
    if (data is Map) {
      this.info = data;
    } else {
      this.info = convert.jsonDecode(data);
    }
  }
}
