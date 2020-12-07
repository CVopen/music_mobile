import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:music_mobile/common/variable.dart';
import 'package:music_mobile/store/theme_model.dart';
import 'dart:ui';

import 'package:provider/provider.dart';

class InputWidget extends StatefulWidget {
  final ValueChanged callback;
  final IconData prefixIcon;
  // 右边icon
  final IconData icon;
  // 左边icon
  final String placeholder;
  // 提示文字
  final bool isShow;
  // 是否需要查看密码
  final String code;
  // 验证码按钮文字
  final ValueChanged codeFun;
  // 验证码回调函数
  final String type;

  const InputWidget(
    this.callback, {
    Key key,
    this.prefixIcon,
    this.icon,
    this.placeholder,
    this.isShow,
    this.code,
    this.codeFun,
    this.type,
  }) : super(key: key);
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
          inputFormatters: widget.type == null
              ? [
                  //只允许输入字母数字 @ .
                  // ignore: deprecated_member_use
                  WhitelistingTextInputFormatter(
                      RegExp("[0-9.]|[a-zA-Z]|[@]|[\.]")),
                ]
              : null,
          onChanged: widget.callback,
          obscureText: (_isShow is bool) ? _isShow : false,
          cursorColor:
              Color(Provider.of<ThemeModel>(context, listen: true).getColor),
          decoration: InputDecoration(
            hintText: widget.placeholder,
            prefixIcon: widget.prefixIcon == null
                ? null
                : Icon(
                    widget.prefixIcon,
                    color: const Color(AppColors.FONT_COLOR),
                  ),
            icon: widget.icon != null
                ? Icon(
                    widget.icon,
                    color: const Color(AppColors.FONT_COLOR),
                  )
                : null,
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: Color(
                    Provider.of<ThemeModel>(context, listen: true).getColor),
                width: 0.5,
              ),
            ),
            enabledBorder: const UnderlineInputBorder(
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
