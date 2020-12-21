import 'package:music_mobile/page/splash_screen.dart';
import 'package:music_mobile/page/audio/audio_page.dart';
import 'package:music_mobile/page/musicList/list_page.dart';
import 'package:music_mobile/page/home/home_page.dart';
import 'package:music_mobile/page/newPage/new_page.dart';
import 'package:music_mobile/page/login/login.dart';
import 'package:music_mobile/page/video/video_page.dart';

Map routes = {
  '/': (context) => SplashScreen(),
  '/login_page': (context) => LoginPage(),
  '/home_page': (context) => HomePage(),
  '/new_page': (context, {arguments}) => NewPage(arguments: arguments),
  '/audio_page': (context, {arguments}) => AudioPage(arguments: arguments),
  '/list_page': (context, {arguments}) => MusicListPage(arguments: arguments),
  '/video_page': (context, {arguments}) => VideoPage(arguments: arguments),
};
