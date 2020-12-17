import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import 'package:music_mobile/store/login_info.dart';
import 'package:music_mobile/store/theme_model.dart';
import 'package:music_mobile/store/audio_info.dart';

List<SingleChildStatelessWidget> providers = [
  ChangeNotifierProvider<LoginInfo>(create: (_) => LoginInfo()),
  ChangeNotifierProvider<ThemeModel>(create: (_) => ThemeModel()),
  ChangeNotifierProvider<AudioInfo>(create: (_) => AudioInfo())
];
