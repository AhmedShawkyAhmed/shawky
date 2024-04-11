import 'package:finance/core/resources/color_manger.dart';
import 'package:finance/core/shared/widgets/default_text.dart';
import 'package:finance/features/money/expenses/data/models/expenses_category_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ExpensesCategoryItemWidget extends StatelessWidget {
  final ExpensesCategoryModel model;

  const ExpensesCategoryItemWidget({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          width: 10.w,
          height: 10.w,
          decoration: BoxDecoration(
            color: model.color,
            borderRadius: BorderRadius.circular(500.r),
          ),
        ),
        SizedBox(width: 5.w),
        DefaultText(
          text: model.name ?? "-",
          textColor: ColorManager.white,
          fontWeight: FontWeight.w400,
          fontSize: 12.sp,
        ),
      ],
    );
  }
}
