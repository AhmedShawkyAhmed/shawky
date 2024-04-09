import 'package:finance/core/resources/color_manger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CardWidget extends StatelessWidget {
  const CardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 800.w,
      margin: EdgeInsetsDirectional.symmetric(horizontal: 15.w, vertical: 5.h),
      padding: EdgeInsetsDirectional.only(
        top: 13.h,
        bottom: 13.h,
        start: 10.w,
        end: 10.w,
      ),
      decoration: BoxDecoration(
        color: ColorManager.white,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Banque Misr",
            style: TextStyle(
              color: ColorManager.darkGrey,
              fontSize: 14.sp,
            ),
          ),
          Row(
            children: [
              Text(
                "151,651,651.52",
                style: TextStyle(
                  color: ColorManager.darkGrey,
                  fontSize: 20.sp,
                ),
              ),
              Text(
                "  EGP",
                style: TextStyle(
                  color: ColorManager.darkGrey,
                  fontSize: 12.sp,
                ),
              ),
            ],
          ),
          Text(
            "4223 3041 5262 6625",
            style: TextStyle(
              color: ColorManager.darkGrey,
              fontSize: 17.sp,
            ),
          ),
          Text(
            "Ahmed Shawky Ahmed",
            style: TextStyle(
              color: ColorManager.darkGrey,
              fontSize: 17.sp,
            ),
          ),
          Row(
            children: [
              const Spacer(),
              Text(
                "04/28",
                style: TextStyle(
                  color: ColorManager.darkGrey,
                  fontSize: 12.sp,
                ),
              ),
              SizedBox(width: 5.w),
              Text(
                "Visa",
                style: TextStyle(
                  color: ColorManager.darkGrey,
                  fontSize: 12.sp,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
