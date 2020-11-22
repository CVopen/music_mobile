import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'common/variable.dart' show AppColors;

import 'router/routes.dart';

import 'page/splash_screen.dart';

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
          // splashColor: Color.fromRGBO(0, 0, 0, 0),
          // highlightColor: Color.fromRGBO(0, 0, 0, 0),
        ),
        home: SplashScreen(),
        // routes: routes,
        onGenerateRoute: onGenerateRoutePage,
        // initialRoute: '/home_page',
      ),
    );
  }
}
