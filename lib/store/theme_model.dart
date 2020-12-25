import 'package:flutter/cupertino.dart';
import 'package:music_mobile/common/variable.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeModel with ChangeNotifier {
  int color;
  List<Map> colorList = [
    {'color': AppColors.IMPORTANT_COLOR, 'name': '猛男粉'},
    {'color': AppColors.IMPORTANT_COLOR1, 'name': '基佬紫'},
    {'color': AppColors.IMPORTANT_COLOR2, 'name': '骚气红'},
    {'color': AppColors.IMPORTANT_COLOR3, 'name': '咸蛋黄'},
    {'color': AppColors.IMPORTANT_COLOR4, 'name': '早苗绿'},
    {'color': AppColors.IMPORTANT_COLOR5, 'name': '萝莉青'},
  ];
  get getColorList {
    return colorList;
  }

  get getColor {
    return color;
  }

  set setColor(int _color) {
    color = _color;
    _setColor(_color);
    notifyListeners();
  }

  _setColor(int color) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('color', color);
  }
}
