import 'dart:io';

import 'package:flutter/material.dart';
// import 'dart:io';
import 'package:flutter/services.dart';

import 'common/variable.dart' show AppColors;
import 'page/home/home_page.dart';

void main() {
  runApp(MyApp());

  if (Platform.isAndroid) {
    SystemUiOverlayStyle style = SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.light,
    );
    SystemChrome.setSystemUIOverlayStyle(style);
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: MaterialApp(
        title: '网抑云',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Color(AppColors.APP_THEME),
        ),
        home: HomePage(),
      ),
    );
  }
}