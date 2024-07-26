import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shawky/core/resources/color_manger.dart';
import 'package:shawky/core/shared/widgets/default_text.dart';
import 'package:shawky/core/utils/enums.dart';
import 'package:shawky/core/utils/extensions.dart';
import 'package:shawky/features/money/expenses/cubit/expenses_cubit.dart';
import 'package:shawky/features/money/expenses/ui/widgets/expenses_category_item_widget.dart';

class ExpensesStatusWidget extends StatelessWidget {
  final ExpensesCubit cubit;

  const ExpensesStatusWidget({
    super.key,
    required this.cubit,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExpensesCubit, ExpensesState>(
      builder: (context, state) {
        return SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () async {
                  await cubit.emitFilterExpenses();
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    DefaultText(
                      text: (cubit.currentDate ?? DateTime.now())
                          .month
                          .toString(),
                      textColor: ColorManager.white,
                    ),
                    const DefaultText(
                      text: "  -  ",
                      textColor: ColorManager.white,
                    ),
                    DefaultText(
                      text:
                          (cubit.currentDate ?? DateTime.now()).year.toString(),
                      textColor: ColorManager.white,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.only(
                  start: 25.sp,
                  end: 25.sp,
                  top: 15.h,
                  bottom: 5.h,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        const DefaultText(
                          text: "INCOME",
                          textColor: ColorManager.white,
                        ),
                        DefaultText(
                          text:
                              "${cubit.filteredExpensesList.fold(0, (num sum, e) => sum + (e.type == ExpensesType.income ? ((e.amount) * (e.rate)) : 0)).toString().toFormatNumber()} £",
                          textColor: ColorManager.green,
                          fontSize: 12.sp,
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        const DefaultText(
                          text: "EXPENSES",
                          textColor: ColorManager.white,
                        ),
                        DefaultText(
                          text:
                              "${cubit.filteredExpensesList.fold(0, (num sum, e) => sum + (e.type == ExpensesType.expenses ? ((e.amount) * (e.rate)) : 0)).toString().toFormatNumber()} £",
                          textColor: ColorManager.red,
                          fontSize: 12.sp,
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        const DefaultText(
                          text: "TOTAL",
                          textColor: ColorManager.white,
                        ),
                        DefaultText(
                          text:
                              "${(cubit.filteredExpensesList.fold(0, (num sum, e) => sum + (e.type == ExpensesType.income ? ((e.amount) * (e.rate)) : 0)) - cubit.expensesList.fold(0, (num sum, e) => sum + (e.type == ExpensesType.expenses ? ((e.amount) * (e.rate)) : 0))).toString().toFormatNumber()} £",
                          textColor: ColorManager.orange,
                          fontSize: 12.sp,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                height: 1.h,
                decoration: const BoxDecoration(
                  color: ColorManager.secondary,
                  boxShadow: [
                    BoxShadow(
                      color: ColorManager.lightGrey,
                      blurRadius: 2.0,
                      offset: Offset(0, 2),
                      spreadRadius: 0.0,
                    ),
                  ],
                ),
                clipBehavior: Clip.antiAliasWithSaveLayer,
              ),
              cubit.categoryList.toList().isEmpty
                  ? const SizedBox()
                  : Row(
                      children: [
                        SizedBox(
                          width: 170.w,
                          child: AspectRatio(
                            aspectRatio: 1,
                            child: PieChart(
                              PieChartData(
                                sections: cubit.pieChartSectionData,
                                centerSpaceRadius: 55.w,
                                sectionsSpace: 2.5.sp,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 200.h,
                          width: 205.w,
                          child: Center(
                            child: GridView.builder(
                              shrinkWrap: true,
                              padding: EdgeInsets.symmetric(
                                vertical: 5.h,
                                horizontal: 1.w,
                              ),
                              physics: const NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 5.sp,
                                mainAxisSpacing: 5.sp,
                                mainAxisExtent: 14.h,
                              ),
                              scrollDirection: Axis.vertical,
                              itemCount: cubit.categoryList.length,
                              itemBuilder: (context, index) {
                                return ExpensesCategoryItemWidget(
                                  model: cubit.categoryList.toList()[index],
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
              Container(
                width: double.infinity,
                height: 1.h,
                decoration: const BoxDecoration(
                  color: ColorManager.secondary,
                  boxShadow: [
                    BoxShadow(
                      color: ColorManager.lightGrey,
                      blurRadius: 2.0,
                      offset: Offset(0, -2),
                      spreadRadius: 0.0,
                    ),
                  ],
                ),
                clipBehavior: Clip.antiAliasWithSaveLayer,
              ),
            ],
          ),
        );
      },
    );
  }
}
