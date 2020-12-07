import 'package:flutter/material.dart';

dialogWidget(context, Widget widget, callback) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        content: widget,
        actions: <Widget>[
          FlatButton(
            child: Text('取消'),
            onPressed: () => Navigator.of(context).pop(),
          ),
          FlatButton(
            child: Text('确认'),
            onPressed: () {
              Navigator.of(context).pop();
              callback();
            },
          ),
        ],
      );
    },
  );
}
