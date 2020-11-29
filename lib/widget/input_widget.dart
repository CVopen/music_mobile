import 'package:flutter/material.dart';
import 'package:music_mobile/common/variable.dart';

class InputWidget extends StatefulWidget {
  final ValueChanged callback;
  final IconData prefixIcon;
  final IconData icon;
  final String placeholder;
  final bool isShow;

  const InputWidget(this.callback,
      {Key key, this.prefixIcon, this.icon, this.placeholder, this.isShow})
      : super(key: key);
  @override
  _InputWidgetState createState() => _InputWidgetState();
}

class _InputWidgetState extends State<InputWidget> {
  var _isShow;
  @override
  void initState() {
    super.initState();

    _isShow = widget.isShow != null ? widget.isShow : '';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Material(
        color: Colors.transparent,
        child: TextField(
          onChanged: widget.callback,
          obscureText: (_isShow is bool) ? _isShow : false,
          cursorColor: Color(AppColors.IMPORTANT_COLOR),
          decoration: InputDecoration(
            hintText: widget.placeholder,
            prefixIcon: Icon(
              widget.prefixIcon,
              color: Color(AppColors.FONT_COLOR),
            ),
            icon: widget.icon != null
                ? Icon(
                    widget.icon,
                    color: Color(AppColors.FONT_COLOR),
                  )
                : null,
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: Color(AppColors.IMPORTANT_COLOR),
                width: 0.5,
              ),
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                width: 0.5,
              ),
            ),
            // suffixIcon: (_isShow is bool)
            //     ? IconButton(
            //         icon: Icon(
            //           _isShow ? Icons.visibility : Icons.visibility_off,
            //           color: Color(AppColors.FONT_COLOR),
            //         ),
            //         onPressed: () {
            //           setState(() {
            //             _isShow = !_isShow;
            //           });
            //         },
            //       )
            //     : null,
            suffixIcon: Container(
              color: Colors.red,
              width: 80,
              child: Center(
                child: Text(
                  'data',
                  textAlign: TextAlign.center,
                  style: TextStyle(height: 1),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
