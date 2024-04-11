import 'package:finance/core/shared/widgets/default_text.dart';
import 'package:finance/core/utils/shared_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:percent_indicator/percent_indicator.dart';

class PercentageWidget extends StatelessWidget {
  final num percent, count;

  const PercentageWidget({
    required this.percent,
    required this.count,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CircularPercentIndicator(
      radius: 40.w,
      lineWidth: 6.sp,
      addAutomaticKeepAlive: true,
      percent: (percent / (count == 0 ? 1 : count)).toDouble(),
      animation: true,
      animateFromLastPercent: true,
      center: DefaultText(
        text:
            "${((percent / (count == 0 ? 1 : count)) * 100).toStringAsFixed(1)} %",
        fontSize: 10.sp,
      ),
      // footer: DefaultText(text: title),
      progressColor: getColor(percent, count),
    );
  }
}
