import 'package:finance/core/resources/color_manger.dart';
import 'package:finance/core/services/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DefaultTitleWidget extends StatelessWidget {
  final String title;

  const DefaultTitleWidget({
    required this.title,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.only(top: 17.h, start: 15.w, end: 17.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              color: ColorManager.white,
              fontSize: 20.sp,
            ),
          ),
          GestureDetector(
            onTap: () => NavigationService.pop(),
            child: Icon(
              Icons.arrow_forward_ios_rounded,
              color: ColorManager.white,
              size: 25.sp,
            ),
          )
        ],
      ),
    );
  }
}
