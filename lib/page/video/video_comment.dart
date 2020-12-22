import 'package:flutter/material.dart';
import 'package:music_mobile/api/video_page.dart';
import 'package:music_mobile/common/variable.dart';
import 'package:music_mobile/store/theme_model.dart';
import 'package:music_mobile/utils/format.dart';
import 'package:music_mobile/widget/image_radius.dart';
import 'package:provider/provider.dart';

class Comment extends StatefulWidget {
  final int id;

  const Comment({Key key, @required this.id}) : super(key: key);
  @override
  _CommentState createState() => _CommentState();
}

class _CommentState extends State<Comment> {
  int id;
  bool isMode = true;
  bool isLoading = true;
  bool isHttp = true;
  int offset = 0;
  int total = 0;
  ScrollController _controller = new ScrollController();
  List<Widget> commentListWidget = [];

  @override
  void initState() {
    super.initState();
    setState(() {
      id = widget.id;
      _getComment();
    });
    // 监听滚动事件
    _controller.addListener(() {
      if ((_controller.offset > _controller.position.maxScrollExtent - 10) &&
          isMode) {
        setState(() {
          if (commentListWidget.length == total && total != 0) {
            isMode = false;
          } else {
            isLoading = false;
            _getComment();
          }
        });
      }
    });
  }

  _getComment() {
    if (!isHttp) return;
    setState(() {
      isHttp = false;
    });
    ApiVideo().getComment({'id': id, 'offset': offset * 20}).then((res) {
      setState(() {
        List<Widget> arr = [];
        total = res.data['total'];
        offset = offset + 1;
        isLoading = true;
        isHttp = true;
        res.data['comments'].forEach((item) {
          arr.add(CommentIten(item: item));
        });
        commentListWidget.addAll(arr);
      });
    });
  }

  @override
  void didUpdateWidget(Comment oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (id != widget.id) {
      setState(() {
        id = widget.id;
        isMode = true;
        isLoading = true;
        offset = 0;
        total = 0;
        commentListWidget = [];
        _getComment();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return commentListWidget.length == 0
        ? Container(
            alignment: Alignment.center,
            child: const Text(
              '暂无评论',
              style: TextStyle(
                color: Color(AppColors.FONT_COLOR),
              ),
            ),
          )
        : Container(
            padding: EdgeInsets.only(left: 10, right: 10),
            child: ListView(
              controller: _controller,
              children: [
                ...commentListWidget,
                Offstage(
                  offstage: isLoading,
                  child: Container(
                    height: 40,
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/loading_more.gif',
                          width: 30,
                          height: 30,
                        ),
                        const SizedBox(width: AppSize.PADDING_SIZE_S),
                        const Text(
                          '加载中...',
                          style: TextStyle(
                            color: Color(AppColors.FONT_COLOR),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Offstage(
                  offstage: isMode,
                  child: Container(
                    height: 40,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.only(
                      top: AppSize.PADDING_SIZE_S,
                      bottom: AppSize.PADDING_SIZE_S,
                    ),
                    child: const Text(
                      '没有更多了',
                      style: TextStyle(
                        color: Color(AppColors.FONT_COLOR),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
  }
}

class CommentIten extends StatelessWidget {
  final Map item;
  const CommentIten({
    Key key,
    @required this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          ImageRadius(item['user']['avatarUrl'], 50, 50),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item['user']['nickname'],
                      style: TextStyle(
                          color: Color(
                              Provider.of<ThemeModel>(context, listen: false)
                                  .getColor),
                          fontWeight: FontWeight.bold,
                          height: 1),
                    ),
                    Expanded(child: Text('')),
                    Text(
                      formaDate(item['time']),
                      style: TextStyle(
                          color: Color(AppColors.FONT_COLOR),
                          height: 1,
                          fontSize: AppSize.FONT_SIZE_S),
                    ),
                  ],
                ),
                Container(
                  width: double.infinity,
                  child: Text(
                    item['content'],
                    style: TextStyle(
                        color: Color(AppColors.FONT_MAIN_COLOR),
                        height: 1,
                        fontSize: AppSize.FONT_SIZE_S),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
