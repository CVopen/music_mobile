import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'package:music_mobile/common/variable.dart';

import 'package:music_mobile/widget/top_list_card.dart';

class TopList extends StatefulWidget {
  final List toplist;

  const TopList({Key key, this.toplist}) : super(key: key);
  @override
  _TopListState createState() => _TopListState();
}

class _TopListState extends State<TopList> {
  List _list = [];

  @override
  void didUpdateWidget(TopList oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.toplist.length > 0) {
      setState(() {
        _list = widget.toplist;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 320,
      child: CarouselSlider(
        items: _list.map(
          (index) {
            return Container(
              child: Card(
                child: Column(
                  children: [
                    Container(
                      height: 40,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            index['name'],
                            style: const TextStyle(
                              fontSize: AppSize.FONT_SIZE_B,
                              fontWeight: FontWeight.w600,
                              height: 1,
                            ),
                          ),
                          const Icon(
                            Icons.keyboard_arrow_right,
                            size: 24,
                          ),
                        ],
                      ),
                    ),
                    TopListCard(id: index['id'])
                  ],
                ),
              ),
            );
          },
        ).toList(),
        options: CarouselOptions(
          height: 320,
          viewportFraction: 0.95,
          reverse: false,
          enableInfiniteScroll: false,
          disableCenter: true,
        ),
      ),
    );
  }
}
