import 'package:finance/core/resources/color_manger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DefaultFloatingButton extends StatelessWidget {
  final VoidCallback onPressed;
  const DefaultFloatingButton({required this.onPressed,super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: ColorManager.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(100.r),
      ),
      onPressed: onPressed,
      child: Icon(
        Icons.add,
        color: ColorManager.primaryDark,
        size: 25.sp,
      ),
    );
  }
}
