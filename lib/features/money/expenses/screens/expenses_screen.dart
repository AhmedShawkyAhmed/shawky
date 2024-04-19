import 'package:shawky/core/components/dialogs/warning_dialog.dart';
import 'package:shawky/core/resources/color_manger.dart';
import 'package:shawky/core/routes/arguments/expenses_arguments.dart';
import 'package:shawky/core/routes/routes_names.dart';
import 'package:shawky/core/services/navigation_service.dart';
import 'package:shawky/core/shared/widgets/default_floating_button.dart';
import 'package:shawky/core/shared/widgets/default_title_widget.dart';
import 'package:shawky/features/money/accounts/cubit/accounts_cubit.dart';
import 'package:shawky/features/money/expenses/cubit/expenses_cubit.dart';
import 'package:shawky/features/money/expenses/widgets/expenses_card.dart';
import 'package:shawky/features/money/expenses/widgets/expenses_status_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ExpensesScreen extends StatelessWidget {
  const ExpensesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ExpensesCubit cubit = BlocProvider.of(context);
    AccountsCubit accountsCubit = BlocProvider.of(context);
    return BlocBuilder<ExpensesCubit, ExpensesState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: ColorManager.secondary,
          floatingActionButton: DefaultFloatingButton(
            onPressed: () {
              NavigationService.pushNamed(
                Routes.addExpensesScreen,
                arguments: ExpensesArguments(
                  cubit: cubit,
                  accountsCubit: accountsCubit,
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
                child: GridView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.symmetric(
                    vertical: 10.h,
                    horizontal: 15.w,
                  ),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1,
                    crossAxisSpacing: 20.sp,
                    mainAxisSpacing: 10.sp,
                    mainAxisExtent: 90.h,
                  ),
                  scrollDirection: Axis.vertical,
                  itemCount: cubit.expensesList.length,
                  itemBuilder: (context, index) {
                    return ExpensesCard(
                      cubit: cubit,
                      model: cubit.expensesList[index],
                      onLongPress: (){
                        WarningDialog.show(
                          message:
                          "Are you Sure you want to Delete this Expenses ?",
                          onPressed: () {
                            NavigationService.pop();
                            cubit.emitDeleteExpense(
                              expenseId: cubit.expensesList[index].id!,
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
    );
  }
}
