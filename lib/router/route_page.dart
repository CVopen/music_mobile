import 'package:music_mobile/page/splash_screen.dart';

import 'package:music_mobile/page/home/home_page.dart';
import 'package:music_mobile/page/newPage/new_page.dart';
import 'package:music_mobile/page/login/login.dart';

Map routes = {
  '/': (context) => SplashScreen(),
  '/login_page': (context) => LoginPage(),
  '/home_page': (context) => HomePage(),
  '/new_page': (context, {arguments}) => NewPage(arguments: arguments),
};
