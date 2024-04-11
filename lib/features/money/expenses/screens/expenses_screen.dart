import 'package:finance/core/resources/color_manger.dart';
import 'package:finance/core/routes/routes_names.dart';
import 'package:finance/core/services/navigation_service.dart';
import 'package:finance/core/shared/widgets/default_floating_button.dart';
import 'package:finance/core/shared/widgets/default_title_widget.dart';
import 'package:finance/features/money/expenses/cubit/expenses_cubit.dart';
import 'package:finance/features/money/expenses/widgets/expenses_card.dart';
import 'package:finance/features/money/expenses/widgets/expenses_status_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ExpensesScreen extends StatelessWidget {
  const ExpensesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ExpensesCubit cubit = BlocProvider.of(context);
    return BlocBuilder<ExpensesCubit, ExpensesState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: ColorManager.secondary,
          floatingActionButton: DefaultFloatingButton(
            onPressed: () {
              NavigationService.pushNamed(Routes.addExpensesScreen);
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
                  itemCount: 15,
                  itemBuilder: (context, index) {
                    return const ExpensesCard();
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
