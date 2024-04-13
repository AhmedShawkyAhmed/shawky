import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:shawky/core/resources/color_manger.dart';
import 'package:shawky/core/shared/widgets/default_text.dart';
import 'package:shawky/core/shared/widgets/percentage_widget.dart';
import 'package:shawky/core/utils/enums.dart';
import 'package:shawky/core/utils/extensions.dart';
import 'package:shawky/features/money/accounts/data/models/account_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AccountCard extends StatelessWidget {
  final AccountModel model;
  final VoidCallback onLongPress;
  final VoidCallback onTap;
  final num total;

  const AccountCard({
    required this.model,
    required this.onLongPress,
    required this.onTap,
    required this.total,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.w,
      padding:
          EdgeInsetsDirectional.symmetric(horizontal: 15.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: ColorManager.white,
        borderRadius: BorderRadius.circular(15.r),
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: (){
              onTap();
            },
            child: SizedBox(
              width: 250.w,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DefaultText(
                    text: "${model.accountType!.name.toCapitalized()} - ${model.name}",
                    fontSize: 13.sp,
                  ),
                  DefaultText(
                    text: "${model.amount} ${model.currency!.name.toUpperCase()}",
                    fontSize: 17.sp,
                  ),
                  if(model.currency != Currency.egp)
                  DefaultText(
                    text: "${((model.amount ?? 0) * (model.rate ?? 0))} ${Currency.egp.name.toUpperCase()}",
                    fontSize: 11.sp,
                  ),
                  const Spacer(),
                  DefaultText(
                    text: model.updatedAt ?? "-",
                    fontSize: 9.sp,
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            onLongPress: () {
              onLongPress();
              WidgetsBinding.instance.reassembleApplication();
            },
            child: SizedBox(
              width: 50.w,
              child: PercentageWidget(
                target: total,
                current: ((model.amount ?? 0) * (model.rate ?? 0)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
