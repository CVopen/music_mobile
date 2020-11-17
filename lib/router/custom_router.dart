import 'package:flutter/material.dart';

class CustomRoute extends PageRouteBuilder {
  final Function func;
  final Map arguments;

  CustomRoute(this.func, {this.arguments})
      : super(
          transitionDuration: Duration(milliseconds: 300),
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) {
            var widget;
            if (arguments != null) {
              widget = func(context, arguments: arguments);
            } else {
              widget = func(context);
            }
            return widget;
          },
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) {
            // 淡入淡出路由效果
            return FadeTransition(
              opacity: Tween(begin: 0.0, end: 1.0).animate(
                CurvedAnimation(
                  parent: animation,
                  curve: Curves.fastOutSlowIn,
                ),
              ),
              child: child,
            );

            //缩放动画
            // return ScaleTransition(
            //   scale: Tween(begin: 0.0, end: 1.0).animate(
            //     CurvedAnimation(
            //       parent: animation,
            //       curve: Curves.fastOutSlowIn,
            //     ),
            //   ),
            //   child: child,
            // );

            //旋转加缩放
            // return RotationTransition(
            //   turns: Tween(begin: 0.0, end: 1.0).animate(
            //     CurvedAnimation(
            //       parent: animation,
            //       curve: Curves.fastOutSlowIn,
            //     ),
            //   ),
            //   child: ScaleTransition(
            //     scale: Tween(begin: 0.0, end: 1.0).animate(
            //       CurvedAnimation(
            //         parent: animation1,
            //         curve: Curves.fastOutSlowIn,
            //       ),
            //     ),
            //     child: child,
            //   ),
            // );

            //侧边退出路由
            // return SlideTransition(
            //   position: Tween<Offset>(
            //     begin: Offset(1.0, 0.0),
            //     end: Offset(0.0, 0.0),
            //   ).animate(
            //     CurvedAnimation(
            //       parent: animation,
            //       curve: Curves.easeIn,
            //     ),
            //   ),
            //   child: child,
            // );
          },
        );
}
