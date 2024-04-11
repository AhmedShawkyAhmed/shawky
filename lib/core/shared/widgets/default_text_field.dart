import 'package:finance/core/resources/color_manger.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DefaultTextField extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback? onTap;
  final String hintText;
  final double? height;
  final double? width;
  final Color? color;
  final Color? borderColor;
  final Color? textColor;
  final Color? cursorColor;
  final double? fontSize;
  final bool? password;
  final int? maxLine;
  final bool? enabled;
  final Widget? prefix;
  final Widget? suffix;
  final double? bottom;
  final double? radius;
  final double? marginHorizontal;
  final double? marginVertical;
  final int? maxLength;
  final TextInputType? keyboardType;
  final TextDirection? direction;
  final Function(String)? onChange;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? inputFormatters;

  const DefaultTextField({
    required this.controller,
    required this.hintText,
    this.password,
    this.onTap,
    this.height,
    this.maxLength,
    this.color,
    this.textColor,
    this.borderColor,
    this.cursorColor,
    this.fontSize,
    this.width,
    this.enabled,
    this.maxLine,
    this.prefix,
    this.suffix,
    this.bottom,
    this.radius,
    this.keyboardType,
    this.marginHorizontal,
    this.marginVertical,
    this.direction,
    this.onChange,
    this.validator,
    this.inputFormatters,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height ?? 50.h,
        width: width ?? double.infinity,
        margin: EdgeInsetsDirectional.only(
          start: marginHorizontal ?? 15.w,
          end: marginHorizontal ?? 15.w,
        ),
        decoration: BoxDecoration(
          color: color ?? ColorManager.transparent,
          borderRadius: BorderRadius.circular(radius ?? 7),
        ),
        child: TextFormField(
          textInputAction: TextInputAction.go,
          onEditingComplete: () {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          inputFormatters: inputFormatters,
          validator: validator,
          keyboardType: keyboardType ?? TextInputType.text,
          textAlignVertical: TextAlignVertical.center,
          enabled: enabled ?? true,
          controller: controller,
          obscureText: password ?? false,
          obscuringCharacter: "*",
          textDirection: TextDirection.ltr,
          style: TextStyle(
            color: textColor ?? ColorManager.secondary,
            fontSize: fontSize ?? 15.sp,
          ),
          cursorColor: cursorColor ?? ColorManager.primary,
          maxLines: maxLine ?? 1,
          maxLength: maxLength,
          decoration: InputDecoration(
            counterText: "",
            counterStyle: const TextStyle(color: ColorManager.secondary),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(radius ?? 7),
              borderSide: const BorderSide(
                color: ColorManager.secondary,
              ),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(radius ?? 7),
              borderSide: const BorderSide(
                color: ColorManager.secondary,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(radius ?? 7),
              borderSide: const BorderSide(
                color: ColorManager.red,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(radius ?? 7),
              borderSide: const BorderSide(
                color: ColorManager.primary,
              ),
            ),
            prefixIcon: prefix,
            suffixIcon: suffix,
            hintText: hintText,
            alignLabelWithHint: true,
            hintStyle: TextStyle(
              color: ColorManager.secondary.withOpacity(0.7),
              fontSize: 15.sp,
            ),
            border: InputBorder.none,
            hintTextDirection: TextDirection.ltr,
            filled: true,
            fillColor: ColorManager.white,
            contentPadding: EdgeInsets.only(
              bottom: 5.sp,
              left: 5.sp,
              right: 5.sp,
            ),
          ),
          onChanged: onChange,
        ),
      ),
    );
  }
}
