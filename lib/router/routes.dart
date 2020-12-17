import 'package:flutter/material.dart';
import 'package:music_mobile/router/route_page.dart';

import 'custom_router.dart';

Function onGenerateRoutePage = (RouteSettings settings) {
  final String name = settings.name;
  final Function _builder = routes[name];

  Route route;
  bool isAudio = false;
  print(settings.name);

  if (settings.name == '/audio_page') isAudio = true;
  if (settings.arguments != null) {
    route =
        CustomRoute(_builder, arguments: settings.arguments, isAudio: isAudio);
  } else {
    route = CustomRoute(_builder, isAudio: isAudio);
  }
  return route;
};
