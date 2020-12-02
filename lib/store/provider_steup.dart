import 'package:music_mobile/store/login_info.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildStatelessWidget> providers = [
  ChangeNotifierProvider<LoginInfo>(
    create: (_) => LoginInfo(),
  )
];
