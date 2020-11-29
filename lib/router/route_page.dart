import '../page/home/home_page.dart';
import '../page/newPage/new_page.dart';
import '../page/login/login.dart';

final routes = {
  '/login_page': (context) => LoginPage(),
  '/home_page': (context) => HomePage(),
  '/new_page': (context, {arguments}) => NewPage(arguments: arguments)
};
