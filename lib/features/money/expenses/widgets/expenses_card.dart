import 'package:shawky/core/resources/color_manger.dart';
import 'package:shawky/core/shared/widgets/default_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shawky/core/utils/enums.dart';
import 'package:shawky/core/utils/extensions.dart';
import 'package:shawky/features/money/expenses/cubit/expenses_cubit.dart';
import 'package:shawky/features/money/expenses/models/expenses_model.dart';

class ExpensesCard extends StatelessWidget {
  final ExpensesCubit cubit;
  final ExpensesModel model;
  final VoidCallback onLongPress;

  const ExpensesCard({
    super.key,
    required this.cubit,
    required this.model,
    required this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        onLongPress();
        WidgetsBinding.instance.reassembleApplication();
      },
      child: Container(
        padding:
            EdgeInsetsDirectional.symmetric(horizontal: 10.w, vertical: 5.h),
        decoration: BoxDecoration(
          color: ColorManager.white,
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SizedBox(width: 5.w),
                DefaultText(
                  text: "${DateTime.parse(model.date).day}",
                  fontSize: 28.sp,
                  fontWeight: FontWeight.w800,
                ),
                SizedBox(width: 5.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DefaultText(
                      text:
                          "${DateTime.parse(model.date).month} - ${DateTime.parse(model.date).year}",
                      fontSize: 10.sp,
                    ),
                    Container(
                      padding: EdgeInsetsDirectional.symmetric(horizontal: 4.w),
                      decoration: BoxDecoration(
                        color: ColorManager.secondary,
                        borderRadius: BorderRadius.circular(2.r),
                      ),
                      child: DefaultText(
                        text: DateFormat('EEEE')
                            .format(DateTime.parse(model.date))
                            .substring(0, 3),
                        fontSize: 10.sp,
                        textColor: ColorManager.white,
                      ),
                    ),
                  ],
                ),
                const Spacer(flex: 3),
                Container(
                  width: 10.w,
                  height: 10.w,
                  decoration: BoxDecoration(
                    color: cubit.getExpensesColor(model.category),
                    borderRadius: BorderRadius.circular(500.r),
                  ),
                ),
                SizedBox(width: 5.w),
                DefaultText(
                  text: model.type.name.toCapitalized(),
                  fontSize: 12.sp,
                ),
                SizedBox(width: 10.w),
              ],
            ),
            Divider(
              color: ColorManager.secondary,
              height: 1.h,
            ),
            Row(
              children: [
                SizedBox(width: 5.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DefaultText(
                      text: model.name,
                    ),
                    DefaultText(
                      text:
                          "${model.fromAccount.name} - ${model.toAccount.name}",
                      fontSize: 10.sp,
                    ),
                  ],
                ),
                const Spacer(),
                DefaultText(
                  text: "${model.amount * model.rate} £",
                  textColor: model.type == ExpensesType.income
                      ? ColorManager.green
                      : model.type == ExpensesType.transfer
                          ? ColorManager.secondary
                          : ColorManager.red,
                ),
                SizedBox(width: 10.w),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
