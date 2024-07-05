import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shawky/core/resources/color_manger.dart';
import 'package:shawky/core/resources/globals.dart';
import 'package:shawky/core/shared/widgets/default_text.dart';
import 'package:shawky/core/utils/extensions.dart';

class TotalGoldWidget extends StatelessWidget {
  final String grams;
  final String price;

  const TotalGoldWidget({
    required this.grams,
    required this.price,
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const DefaultText(
                text: "Total Gold",
              ),
              SizedBox(height: 3.h),
              DefaultText(
                text: "$grams Grams",
                fontSize: 17.sp,
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              DefaultText(
                text: "${price.toFormatNumber()} EGP",
                fontSize: 17.sp,
              ),
              SizedBox(height: 3.h),
              DefaultText(
                text:
                    "${(double.parse(grams) * (Globals.settings?.gold ?? 1)).toString().toFormatNumber()} EGP",
                fontSize: 17.sp,
                textColor: double.parse(price) >
                        double.parse(grams) * (Globals.settings?.gold ?? 1)
                    ? ColorManager.red
                    : ColorManager.green,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
