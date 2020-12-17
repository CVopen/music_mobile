import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'common/variable.dart' show AppColors;

import 'router/routes.dart';

import 'package:provider/provider.dart';
import 'package:music_mobile/store/provider_steup.dart';

void main() {
  runApp(MultiProvider(
    providers: providers,
    child: MyApp(),
  ));

  if (Platform.isAndroid) {
    SystemUiOverlayStyle style = SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.light,
    );
    SystemChrome.setSystemUIOverlayStyle(style);
  }
}

// ignore: must_be_immutable
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // 设置支持语言类型
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('zh', 'CN'),
        const Locale('en', 'US'),
      ],
      title: '网抑云',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(AppColors.APP_THEME),
        // splashColor: Color.fromRGBO(0, 0, 0, 0),
        // highlightColor: Color.fromRGBO(0, 0, 0, 0),
      ),
      // home: SplashScreen(),
      // home: Container(width: 50, height: 50, color: Colors.yellow),
      // routes: routes,
      onGenerateRoute: onGenerateRoutePage,
      // initialRoute: '/',
    );
  }
}
