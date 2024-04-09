import 'package:finance/core/resources/color_manger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Row(),
          Icon(
            Icons.warning_amber_rounded,
            color: ColorManager.redError,
            size: 200.sp,
          ),
          Text(
            "Internal Server Error",
            style: TextStyle(
              color: ColorManager.black,
              fontSize: 20.sp,
            ),
          ),
        ],
      ),
    );
  }
}
