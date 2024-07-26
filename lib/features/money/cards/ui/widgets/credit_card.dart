import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shawky/core/resources/assets_manager.dart';
import 'package:shawky/core/resources/color_manger.dart';
import 'package:shawky/core/shared/widgets/default_text.dart';
import 'package:shawky/core/utils/enums.dart';
import 'package:shawky/core/utils/extensions.dart';
import 'package:shawky/core/utils/shared_functions.dart';
import 'package:shawky/features/money/cards/cubit/cards_cubit.dart';
import 'package:shawky/features/money/cards/data/models/bank_card_model.dart';

class CreditCard extends StatefulWidget {
  final BankCardModel model;
  final VoidCallback onLongPress;
  final VoidCallback onTap;

  const CreditCard({
    required this.model,
    required this.onLongPress,
    required this.onTap,
    super.key,
  });

  @override
  State<CreditCard> createState() => _CreditCardState();
}

class _CreditCardState extends State<CreditCard> {
  bool isVisible = false;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CardsCubit, CardsState>(
      builder: (context, state) {
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
                      text: widget.model.name,
                      fontSize: 15.sp,
                    ),
                    DefaultText(
                      text: widget.model.cardType.name.toCapitalized(),
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
                      AssetsManager.chip,
                      width: 40.w,
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {
                        widget.onTap();
                      },
                      child: RotationTransition(
                        turns: const AlwaysStoppedAnimation(90 / 360),
                        child: Icon(
                          Icons.wifi,
                          color: ColorManager.secondary,
                          size: 40.sp,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () async {
                  await Clipboard.setData(
                    ClipboardData(text: widget.model.cardNumber),
                  );
                  showMyToast(message: "Card Number Copied");
                },
                child: DefaultText(
                  text: widget.model.cardNumber,
                  fontSize: 24.sp,
                ),
              ),
              Row(
                children: [
                  Column(
                    children: [
                      SizedBox(
                        width: 200.w,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  isVisible = !isVisible;
                                });
                              },
                              child: SizedBox(
                                width: 70.w,
                                child: DefaultText(
                                  text:
                                      " CVV ${isVisible ? (widget.model.cvv) : "***"}",
                                  fontSize: 13.sp,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.only(
                                start: 40.w,
                                top: 5.h,
                                bottom: 5.h,
                              ),
                              child: DefaultText(
                                text: "EXP ${widget.model.exp}",
                                fontSize: 13.sp,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 200.w,
                        child: DefaultText(
                          text: widget.model.nameOnCard,
                          fontSize: 15.sp,
                        ),
                      ),
                      SizedBox(height: 8.h),
                    ],
                  ),
                  const Spacer(),
                  GestureDetector(
                    onLongPress: () {
                      widget.onLongPress();
                      WidgetsBinding.instance.reassembleApplication();
                    },
                    child: Image.asset(
                      widget.model.cardCompany == CardCompany.visa
                          ? AssetsManager.visa
                          : AssetsManager.masterCard,
                      width: 55.w,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
