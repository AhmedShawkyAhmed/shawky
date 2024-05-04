import 'package:shawky/core/resources/color_manger.dart';
import 'package:shawky/core/shared/widgets/default_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TotalGoldWidget extends StatelessWidget {
  final String grams;
  final String price;
  final String newPrice;

  const TotalGoldWidget({
    required this.grams,
    required this.price,
    required this.newPrice,
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
            text: "Total Gold",
          ),
          SizedBox(height: 3.h),
          DefaultText(
            text: "$grams EGP",
            fontSize: 17.sp,
          ),
        ],
      ),
    );
  }
}
