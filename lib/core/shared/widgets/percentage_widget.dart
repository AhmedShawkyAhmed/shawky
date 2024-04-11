import 'package:finance/core/shared/widgets/default_text.dart';
import 'package:finance/core/utils/shared_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:percent_indicator/percent_indicator.dart';

class PercentageWidget extends StatelessWidget {
  final num current, target;
  final bool linear;

  const PercentageWidget({
    required this.current,
    required this.target,
    this.linear = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return linear
        ? LinearPercentIndicator(
            lineHeight: 10.h,
            padding: EdgeInsets.symmetric(vertical: 2.h),
            percent: (current / (target == 0 ? 1 : target)).toDouble(),
            progressColor: getColor(current, target),
            animation: true,
            animateFromLastPercent: true,
            barRadius: Radius.circular(5.r),
          )
        : CircularPercentIndicator(
            radius: 40.w,
            lineWidth: 7.sp,
            addAutomaticKeepAlive: true,
            percent: (current / (target == 0 ? 1 : target)).toDouble(),
            animation: true,
            animateFromLastPercent: true,
            center: DefaultText(
              text:
                  "${((current / (target == 0 ? 1 : target)) * 100).toStringAsFixed(2)} %",
              fontSize: 10.sp,
            ),
            progressColor: getColor(current, target),
          );
  }
}
