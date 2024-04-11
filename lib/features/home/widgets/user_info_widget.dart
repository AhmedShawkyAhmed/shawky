import 'package:shawky/core/resources/assets_manager.dart';
import 'package:shawky/core/resources/color_manger.dart';
import 'package:shawky/core/shared/widgets/default_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserInfoWidget extends StatelessWidget {
  const UserInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.only(top: 17.h),
      child: Row(
        children: [
          Container(
            padding: EdgeInsetsDirectional.all(8.sp),
            margin: EdgeInsetsDirectional.only(start: 15.w,end: 10.w),
            decoration: BoxDecoration(
              color: ColorManager.primaryDark.withOpacity(0.3),
              borderRadius: BorderRadius.circular(100.r),
            ),
            child: Image.asset(
              ImageAssets.logo,
              width: 60.w,
            ),
          ),
          DefaultText(
            text: "Ahmed Shawky\nSoftware Engineer",
            textColor: ColorManager.white,
            fontSize: 15.sp,
            maxLines: 2,
          ),
        ],
      ),
    );
  }
}
