import 'package:finance/core/shared/widgets/default_text.dart';
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

Color getColor(num percent, count) {
  String value =
      ((percent / (count == 0 ? 1 : count)) * 100).toStringAsFixed(1);
  double doubleValue = double.parse(value);
  if (doubleValue > 0 && doubleValue < 11) {
    return Colors.red;
  } else if (doubleValue > 10 && doubleValue < 21) {
    return Colors.lightGreen.shade500;
  }else if (doubleValue > 20 && doubleValue < 31) {
    return Colors.yellow.shade600;
  }else if (doubleValue > 30 && doubleValue < 41) {
    return Colors.cyan;
  }else if (doubleValue > 40 && doubleValue < 51) {
    return Colors.deepOrange;
  }else if (doubleValue > 50 && doubleValue < 61) {
    return Colors.deepPurple;
  }else if (doubleValue > 60 && doubleValue < 71) {
    return Colors.pink;
  }else if (doubleValue > 70 && doubleValue < 81) {
    return Colors.tealAccent.shade700;
  }else if (doubleValue > 80 && doubleValue < 91) {
    return Colors.brown;
  } else if (doubleValue > 90 && doubleValue < 101) {
    return Colors.lightBlue.shade700;
  }else {
    return Colors.black;
  }
}
