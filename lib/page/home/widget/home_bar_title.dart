import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class TitleBarWidget extends StatefulWidget {
  final String text;

  const TitleBarWidget({Key key, this.text}) : super(key: key);

  @override
  _TitleBarWidgetState createState() => _TitleBarWidgetState();
}

class _TitleBarWidgetState extends State<TitleBarWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Expanded(
        child: Center(
          child: Text.rich(
            TextSpan(
              text: widget.text,
              style: const TextStyle(
                fontSize: 14,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  print(123);
                },
            ),
          ),
        ),
      ),
    );
  }
}
