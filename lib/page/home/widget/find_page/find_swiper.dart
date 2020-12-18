import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:music_mobile/common/variable.dart';
import 'package:music_mobile/store/theme_model.dart';
import 'package:provider/provider.dart';

class FindSwiper extends StatefulWidget {
  final List swiperList;

  const FindSwiper({Key key, this.swiperList}) : super(key: key);

  @override
  _FindSwiperState createState() => _FindSwiperState();
}

class _FindSwiperState extends State<FindSwiper> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      height: (size.width - AppSize.PADDING_SIZE_B * 2) * 284 / 730 +
          AppSize.PADDING_SIZE_B * 2,
      child: Swiper(
        key: UniqueKey(),
        itemBuilder: (BuildContext context, int index) {
          return Container(
            margin: const EdgeInsets.all(AppSize.PADDING_SIZE_B),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                widget.swiperList[index]['pic'],
                fit: BoxFit.fill,
              ),
            ),
          );
        },
        itemCount: widget.swiperList.length,
        autoplay: true,
        autoplayDelay: 5000,
        duration: 600,
        pagination: SwiperPagination(
          margin: const EdgeInsets.all(15.0),
          builder: DotSwiperPaginationBuilder(
            activeColor:
                Color(Provider.of<ThemeModel>(context, listen: true).getColor),
            color: const Color(AppColors.FONT_COLOR),
            size: 6,
            activeSize: 6,
          ),
        ),
      ),
    );
  }
}
