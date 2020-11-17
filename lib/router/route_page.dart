import '../page/home/home_page.dart';
import '../page/newPage/new_page.dart';

final routes = {
  '/home_page': (context) => HomePage(),
  '/new_page': (context, {arguments}) => NewPage(arguments: arguments)
};
