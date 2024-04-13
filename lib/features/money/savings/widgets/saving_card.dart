import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:shawky/core/resources/color_manger.dart';
import 'package:shawky/core/shared/widgets/default_text.dart';
import 'package:shawky/core/shared/widgets/percentage_widget.dart';
import 'package:shawky/features/money/savings/data/models/saving_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SavingCard extends StatelessWidget {
  final SavingModel model;
  final VoidCallback onTap;
  final VoidCallback onLongPress;

  const SavingCard({
    super.key,
    required this.model,
    required this.onTap,
    required this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsetsDirectional.only(
        start: 5.w,
        end: 15.w,
        top: 5.h,
        bottom: 5.h,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        color: ColorManager.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onLongPress: () {
              onLongPress();
              WidgetsBinding.instance.reassembleApplication();
            },
            child: Container(
              width: 60.w,
              height: 60.w,
              decoration: BoxDecoration(
                color: ColorManager.secondary,
                borderRadius: BorderRadius.circular(100.r),
              ),
              child: Center(
                child: DefaultText(
                  text:
                      "${(((model.current ?? 0) / ((model.target ?? 0) == 0 ? 1 : (model.target ?? 0))) * 100).toStringAsFixed(2)} %",
                  fontSize: 11.sp,
                  textColor: ColorManager.white,
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: (){
              onTap();
            },
            child: SizedBox(
              width: 250.w,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      DefaultText(
                        text: model.name ?? "-",
                        fontSize: 13.sp,
                      ),
                      DefaultText(
                        text: "${model.target ?? 0} £",
                        fontSize: 13.sp,
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.symmetric(vertical: 5.h),
                    child: PercentageWidget(
                      target: model.target ?? 0,
                      current: model.current ?? 0,
                      linear: true,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      DefaultText(
                        text: "${model.current ?? 0} £",
                        fontSize: 12.sp,
                      ),
                      DefaultText(
                        text: "${(model.target ?? 0) - (model.current ?? 0)} £",
                        fontSize: 12.sp,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
