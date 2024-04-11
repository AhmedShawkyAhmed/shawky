import 'package:finance/core/resources/assets_manager.dart';
import 'package:finance/core/resources/color_manger.dart';
import 'package:finance/core/shared/widgets/default_text.dart';
import 'package:finance/core/utils/enums.dart';
import 'package:finance/core/utils/extentions.dart';
import 'package:finance/features/money/cards/data/models/bank_card_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CardWidget extends StatelessWidget {
  final BankCardModel model;

  const CardWidget({required this.model, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsetsDirectional.only(
        top: 8.h,
        bottom: 8.h,
        start: 15.w,
        end: 15.w,
      ),
      decoration: BoxDecoration(
        color: ColorManager.white,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsetsDirectional.only(start: 5.w, end: 15.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DefaultText(
                  text: model.name,
                  fontSize: 15.sp,
                ),
                DefaultText(
                  text: model.cardType.name.toCapitalized(),
                  fontSize: 15.sp,
                ),
              ],
            ),
          ),
          const Spacer(),
          Padding(
            padding: EdgeInsetsDirectional.only(end: 9.w, bottom: 5.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: ColorManager.secondary,
                  size: 25.sp,
                ),
                SizedBox(width: 5.w),
                Image.asset(
                  ImageAssets.chip,
                  width: 40.w,
                ),
                const Spacer(),
                RotationTransition(
                  turns: const AlwaysStoppedAnimation(90 / 360),
                  child: Icon(
                    Icons.wifi,
                    color: ColorManager.secondary,
                    size: 40.sp,
                  ),
                ),
              ],
            ),
          ),
          DefaultText(
            text: model.cardNumber,
            fontSize: 24.sp,
          ),
          Row(
            children: [
              Column(
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.only(
                      start: 110.w,
                      top: 5.h,
                      bottom: 5.h,
                    ),
                    child: DefaultText(
                      text: model.exp,
                      fontSize: 13.sp,
                    ),
                  ),
                  DefaultText(
                    text: model.nameOnCard,
                    fontSize: 15.sp,
                  ),
                  SizedBox(height: 8.h),
                ],
              ),
              const Spacer(),
              Image.asset(
                model.cardCompany == CardCompany.visa
                    ? ImageAssets.visa
                    : ImageAssets.masterCard,
                width: 55.w,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
