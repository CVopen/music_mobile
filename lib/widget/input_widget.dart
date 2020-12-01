import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:music_mobile/common/variable.dart';
import 'dart:ui';

class InputWidget extends StatefulWidget {
  final ValueChanged callback;
  final IconData prefixIcon;
  final IconData icon;
  final String placeholder;
  final bool isShow;
  final String code;
  final ValueChanged codeFun;

  const InputWidget(this.callback,
      {Key key,
      this.prefixIcon,
      this.icon,
      this.placeholder,
      this.isShow,
      this.code,
      this.codeFun})
      : super(key: key);
  @override
  _InputWidgetState createState() => _InputWidgetState();
}

class _InputWidgetState extends State<InputWidget> {
  var _isShow;
  final textFieldFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    _isShow = widget.isShow != null ? widget.isShow : '';
  }

  _suffixIcon() {
    if (widget.code != null) {
      return Container(
        width: 80,
        child: InkWell(
          child: Center(
            child: Text.rich(
              TextSpan(
                text: widget.code,
                style: TextStyle(
                  color: Color(AppColors.IMPORTANT_COLOR),
                  height: 1,
                  fontSize: AppSize.FONT_SIZE_S,
                ),
              ),
            ),
          ),
          onTap: () {
            textFieldFocusNode.unfocus();
            textFieldFocusNode.canRequestFocus = false;
            Future.delayed(Duration(milliseconds: 100), () {
              textFieldFocusNode.canRequestFocus = true;
            });
            widget.codeFun('');
          },
        ),
      );
    }
    if (_isShow is bool) {
      return IconButton(
        icon: Icon(
          _isShow ? Icons.visibility : Icons.visibility_off,
          color: Color(AppColors.FONT_COLOR),
        ),
        onPressed: () {
          textFieldFocusNode.unfocus();
          textFieldFocusNode.canRequestFocus = false;
          setState(() {
            _isShow = !_isShow;
          });
          Future.delayed(Duration(milliseconds: 100), () {
            textFieldFocusNode.canRequestFocus = true;
          });
        },
      );
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Material(
        color: Colors.transparent,
        child: TextField(
          focusNode: textFieldFocusNode,
          inputFormatters: [
            //只允许输入字母数字 @ .
            // ignore: deprecated_member_use
            WhitelistingTextInputFormatter(RegExp("[0-9.]|[a-zA-Z]|[@]|[\.]")),
          ],
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
            suffixIcon: _suffixIcon(),
          ),
        ),
      ),
    );
  }
}
