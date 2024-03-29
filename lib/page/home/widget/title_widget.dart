import 'package:flutter/material.dart';
import '../../../common/variable.dart';

class TitleWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(AppSize.BORDER_RADIUS),
      onTap: () {
        print(123);
      },
      child: Container(
        height: 40.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppSize.BORDER_RADIUS),
          color: const Color(AppColors.BACKGROUND_COLOR),
        ),
        child: Row(
          // crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.search,
              color: Color(AppColors.FONT_COLOR),
              size: 18.0,
            ),
            const SizedBox(
              width: AppSize.BOX_SIZE_WIDTH_S,
            ),
            const Text(
              '音乐/视频',
              style: TextStyle(
                fontSize: AppSize.FONT_SIZE_M,
                color: Color(AppColors.FONT_COLOR),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
