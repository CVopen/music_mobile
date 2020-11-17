import 'package:flutter/material.dart';
import 'package:music_mobile/router/route_page.dart';

import 'custom_router.dart';

Function onGenerateRoutePage = (RouteSettings settings) {
  final String name = settings.name;
  final Function _builder = routes[name];

  Route route;
  print(settings);
  if (settings.arguments != null) {
    route = CustomRoute(_builder, arguments: settings.arguments);
  } else {
    route = CustomRoute(_builder);
  }

  return route;
};
