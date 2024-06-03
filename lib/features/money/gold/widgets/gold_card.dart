import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shawky/core/resources/color_manger.dart';
import 'package:shawky/core/shared/widgets/default_text.dart';
import 'package:shawky/features/money/gold/models/gold_model.dart';

class GoldCard extends StatelessWidget {
  final GoldModel model;
  final VoidCallback onLongPress;

  const GoldCard({
    super.key,
    required this.model,
    required this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        onLongPress();
        WidgetsBinding.instance.reassembleApplication();
      },
      child: Container(
        padding:
            EdgeInsetsDirectional.symmetric(horizontal: 10.w, vertical: 5.h),
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
                  text: "${DateTime.parse(model.date).day}",
                  fontSize: 22.sp,
                  fontWeight: FontWeight.w600,
                ),
                SizedBox(width: 5.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DefaultText(
                      text:
                      "${DateTime.parse(model.date).month} - ${DateTime.parse(model.date).year}",
                      fontSize: 10.sp,
                    ),
                    Container(
                      padding: EdgeInsetsDirectional.symmetric(horizontal: 4.w),
                      decoration: BoxDecoration(
                        color: ColorManager.secondary,
                        borderRadius: BorderRadius.circular(2.r),
                      ),
                      child: DefaultText(
                        text: DateFormat('EEEE')
                            .format(DateTime.parse(model.date))
                            .substring(0, 3),
                        fontSize: 10.sp,
                        textColor: ColorManager.white,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                DefaultText(
                  text: model.name,
                  fontSize: 22.sp,
                  fontWeight: FontWeight.w600,
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
                  text: "${model.weight} Grams",
                ),
                const Spacer(),
                DefaultText(
                  text: "${model.price.toStringAsFixed(2)} £",
                  textColor: ColorManager.secondary,
                ),
                SizedBox(width: 10.w),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
