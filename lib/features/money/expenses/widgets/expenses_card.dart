import 'package:finance/core/resources/color_manger.dart';
import 'package:finance/core/shared/widgets/default_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ExpensesCard extends StatelessWidget {
  const ExpensesCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsetsDirectional.symmetric(horizontal: 10.w, vertical: 5.h),
      decoration: BoxDecoration(
        color: ColorManager.white,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              SizedBox(width: 5.w),
              DefaultText(
                text: "29",
                fontSize: 28.sp,
                fontWeight: FontWeight.w800,
              ),
              SizedBox(width: 5.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DefaultText(
                    text: "04 - 2024",
                    fontSize: 10.sp,
                  ),
                  Container(
                    padding: EdgeInsetsDirectional.symmetric(horizontal: 4.w),
                    decoration: BoxDecoration(
                      color: ColorManager.secondary,
                      borderRadius: BorderRadius.circular(2.r),
                    ),
                    child: DefaultText(
                      text: "Mon",
                      fontSize: 10.sp,
                      textColor: ColorManager.white,
                    ),
                  ),
                ],
              ),
              const Spacer(flex: 3),
              const DefaultText(
                text: "0.00 £",
                textColor: ColorManager.green,
              ),
              const Spacer(),
              const DefaultText(
                text: "0.00 £",
                textColor: ColorManager.red,
              ),
              SizedBox(width: 10.w),
            ],
          ),
          Divider(
            color: ColorManager.secondary,
            height: 1.h,
          ),
          Row(
            children: [
              SizedBox(width: 5.w),
               DefaultText(
                text: "Transfer",
                fontSize: 12.sp,
              ),
              SizedBox(width: 25.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const DefaultText(
                    text: "Expenses Name",
                  ),
                  DefaultText(
                    text: "from - to",
                    fontSize: 12.sp,
                  ),
                ],
              ),
              const Spacer(),
              const DefaultText(
                text: "0.00 £",
                textColor: ColorManager.green,
              ),
              SizedBox(width: 10.w),
            ],
          ),
        ],
      ),
    );
  }
}
