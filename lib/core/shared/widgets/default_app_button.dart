import 'package:finance/core/resources/color_manger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DefaultAppButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final Color? textColor;
  final Color? buttonColor;
  final Color? shadowColor;
  final double? fontSize;
  final double? width;
  final double? height;
  final double? radius;
  final double? spreadRadius;
  final double? blurRadius;
  final Offset? offset;
  final FontWeight? fontWeight;
  final TextDecoration? textDecoration;
  final AlignmentGeometry? begin;
  final AlignmentGeometry? end;
  final List<Color>? gradientColors;
  final bool isGradient;
  final bool haveShadow;
  final double? marginHorizontal;
  final double? marginVertical;

  const DefaultAppButton({
    required this.title,
    required this.onTap,
    this.buttonColor,
    this.textColor,
    this.width,
    this.height,
    this.radius,
    this.fontSize,
    this.fontWeight,
    this.textDecoration,
    this.begin,
    this.end,
    this.offset,
    this.gradientColors,
    this.shadowColor,
    this.spreadRadius,
    this.blurRadius,
    this.marginHorizontal,
    this.marginVertical,
    this.isGradient = false,
    this.haveShadow = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: width ?? double.infinity,
        height: height ?? 40.h,
        margin: EdgeInsets.symmetric(
          horizontal: marginHorizontal ?? 15.w,
          vertical: marginVertical ?? 2.h,
        ),
        decoration: BoxDecoration(
          gradient: isGradient
              ? LinearGradient(
                  begin: begin ?? Alignment.centerLeft,
                  end: end ?? Alignment.centerRight,
                  colors: gradientColors ??
                      [ColorManager.primaryLight, ColorManager.primary],
                )
              : LinearGradient(
                  colors: [
                    buttonColor ?? ColorManager.primaryLight,
                    buttonColor ?? ColorManager.primary,
                  ],
                ),
          boxShadow: [
            haveShadow
                ? BoxShadow(
                    color: shadowColor ?? ColorManager.white.withOpacity(0.2),
                    spreadRadius: spreadRadius ?? 2,
                    blurRadius: blurRadius ?? 2,
                    offset: offset ??
                        const Offset(1, 1), // changes position of shadow
                  )
                : const BoxShadow(),
          ],
          borderRadius: BorderRadius.circular(radius ?? 7),
          color: buttonColor ?? ColorManager.primary,
        ),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              color: textColor ?? Colors.white,
              fontSize: fontSize ?? 20.sp,
              fontWeight: fontWeight ?? FontWeight.w400,
              decoration: textDecoration ?? TextDecoration.none,
            ),
          ),
        ),
      ),
    );
  }
}
