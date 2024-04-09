import 'package:finance/core/resources/color_manger.dart';
import 'package:finance/core/shared/widgets/default_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TotalBalanceWidget extends StatelessWidget {
  final String total;

  const TotalBalanceWidget({
    required this.total,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 100.h,
      margin: EdgeInsetsDirectional.symmetric(horizontal: 15.w, vertical: 10.h),
      padding:
          EdgeInsetsDirectional.symmetric(horizontal: 15.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: ColorManager.white,
        borderRadius: BorderRadius.circular(15.r),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const DefaultText(
            text: "Total Money",
          ),
          SizedBox(height: 3.h),
          DefaultText(
            text: "$total EGP",
            fontSize: 17.sp,
          ),
        ],
      ),
    );
  }
}
