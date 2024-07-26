import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shawky/core/components/dialogs/warning_dialog.dart';
import 'package:shawky/core/resources/color_manger.dart';
import 'package:shawky/core/routes/arguments/expenses_arguments.dart';
import 'package:shawky/core/routes/routes_names.dart';
import 'package:shawky/core/services/navigation_service.dart';
import 'package:shawky/core/services/service_locator.dart';
import 'package:shawky/core/shared/widgets/default_floating_button.dart';
import 'package:shawky/core/shared/widgets/default_text.dart';
import 'package:shawky/core/shared/widgets/default_title_widget.dart';
import 'package:shawky/features/money/expenses/cubit/expenses_cubit.dart';
import 'package:shawky/features/money/expenses/ui/widgets/expenses_card.dart';
import 'package:shawky/features/money/expenses/ui/widgets/expenses_status_widget.dart';

class ExpensesScreen extends StatefulWidget {
  const ExpensesScreen({super.key});

  @override
  State<ExpensesScreen> createState() => _ExpensesScreenState();
}

class _ExpensesScreenState extends State<ExpensesScreen> {
  ExpensesCubit cubit = ExpensesCubit(getIt());

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => cubit..emitGetExpenses(month: DateTime.now().month),
      child: BlocBuilder<ExpensesCubit, ExpensesState>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: ColorManager.secondary,
            floatingActionButton: DefaultFloatingButton(
              onPressed: () {
                NavigationService.pushNamed(
                  Routes.addExpensesScreen,
                  arguments: ExpensesArguments(
                    cubit: cubit,
                    title: "Add Expenses",
                  ),
                );
              },
            ),
            body: Column(
              children: [
                const DefaultTitleWidget(title: "Expenses"),
                ExpensesStatusWidget(cubit: cubit),
                Expanded(
                  child: cubit.filteredExpensesList.isEmpty
                      ? Center(
                          child: DefaultText(
                            text: "No Expenses Found !",
                            textColor: ColorManager.white,
                            fontSize: 18.sp,
                          ),
                        )
                      : GridView.builder(
                          shrinkWrap: true,
                          padding: EdgeInsets.only(
                            top: 5.h,
                            bottom: 55.h,
                            left: 15.w,
                            right: 15.w,
                          ),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 1,
                            crossAxisSpacing: 20.sp,
                            mainAxisSpacing: 10.sp,
                            mainAxisExtent: 90.h,
                          ),
                          scrollDirection: Axis.vertical,
                          itemCount: cubit.filteredExpensesList.length,
                          itemBuilder: (context, index) {
                            return ExpensesCard(
                              cubit: cubit,
                              model: cubit.filteredExpensesList[index],
                              onLongPress: () {
                                WarningDialog.show(
                                  message:
                                      "Are you Sure you want to Delete this Expenses ?",
                                  onPressed: () {
                                    NavigationService.pop();
                                    cubit.emitDeleteExpense(
                                      expenseId:
                                          cubit.filteredExpensesList[index].id!,
                                    );
                                  },
                                );
                              },
                            );
                          },
                        ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
