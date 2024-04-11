import 'package:finance/core/resources/color_manger.dart';
import 'package:finance/core/shared/widgets/default_text.dart';
import 'package:finance/core/shared/widgets/percentage_widget.dart';
import 'package:finance/core/utils/enums.dart';
import 'package:finance/core/utils/extensions.dart';
import 'package:finance/features/money/accounts/data/models/account_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AccountCard extends StatelessWidget {
  final AccountModel model;
  final num total;

  const AccountCard({
    required this.model,
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
          SizedBox(
            width: 250.w,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DefaultText(
                  text: "${model.type!.name.toCapitalized()} - ${model.name}",
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
          SizedBox(
            width: 40.w,
            child: PercentageWidget(
              target: total,
              current: ((model.amount ?? 0) * (model.rate ?? 0)),
            ),
          ),
        ],
      ),
    );
  }
}
