import 'package:shawky/core/resources/color_manger.dart';
import 'package:shawky/core/shared/widgets/default_text.dart';
import 'package:shawky/core/utils/shared_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class VersionWidget extends StatelessWidget {
  const VersionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: isPortrait ? 25.h : 35.h,
      decoration: const BoxDecoration(color: ColorManager.black),
      child: Center(
        child: DefaultText(
          text: 'Version 0.0.1+5',
          textColor: ColorManager.white,
          fontSize: isPortrait ? 15.sp : 8.sp,
        ),
      ),
    );
  }
}
