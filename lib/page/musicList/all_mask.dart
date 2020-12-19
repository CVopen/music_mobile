import 'package:flutter/material.dart';
import 'package:music_mobile/common/variable.dart';
import 'package:music_mobile/store/theme_model.dart';
import 'package:provider/provider.dart';

class AllPlay extends StatelessWidget {
  final int count;

  const AllPlay({
    Key key,
    this.count = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: Colors.transparent,
      radius: 0.0,
      onTap: () {
        print('播放');
      },
      child: Padding(
        padding: EdgeInsets.all(AppSize.PADDING_SIZE_B),
        child: Row(
          children: [
            Container(
              margin: EdgeInsets.only(right: AppSize.PADDING_SIZE_B),
              decoration: BoxDecoration(
                color: Color(
                    Provider.of<ThemeModel>(context, listen: false).getColor),
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(3),
                child: const Icon(
                  Icons.play_arrow,
                  size: 18.0,
                  color: Colors.white,
                ),
              ),
            ),
            Text(
              '播放全部 ($count)',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Mask extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    return Container(
      width: _size.width,
      height: _size.width / 1.5,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xff000000),
            Color(0xff122738).withOpacity(.9),
            Color(0xFF090e42).withOpacity(.8),
            Color(0xfff34235).withOpacity(.6),
            Color(0xfffd79a8).withOpacity(.4),
          ],
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
        ),
      ),
    );
  }
}
