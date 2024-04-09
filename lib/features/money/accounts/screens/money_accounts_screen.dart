import 'package:finance/core/resources/color_manger.dart';
import 'package:finance/core/routes/routes_names.dart';
import 'package:finance/core/services/navigation_service.dart';
import 'package:finance/core/shared/widgets/default_floating_button.dart';
import 'package:finance/core/shared/widgets/default_title_widget.dart';
import 'package:finance/features/money/accounts/cubit/money_accounts_cubit.dart';
import 'package:finance/features/money/accounts/widgets/account_card_widget.dart';
import 'package:finance/features/money/accounts/widgets/total_balance_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MoneyAccountsScreen extends StatelessWidget {
  const MoneyAccountsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    MoneyAccountsCubit moneyAccountsCubit = BlocProvider.of(context);
    return BlocBuilder<MoneyAccountsCubit, MoneyAccountsState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: ColorManager.secondary,
          floatingActionButton: DefaultFloatingButton(
            onPressed: () {
              NavigationService.pushNamed(Routes.moneyAddAccountsScreen);
            },
          ),
          body: Column(
            children: [
              const DefaultTitleWidget(title: "Accounts"),
              TotalBalanceWidget(
                  total:
                      "${moneyAccountsCubit.moneyAccounts.fold(0, (num sum, e) => sum + (e.amount * e.rate))}"),
              Expanded(
                child: GridView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.symmetric(
                    vertical: 5.h,
                    horizontal: 15.w,
                  ),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1,
                    crossAxisSpacing: 20.sp,
                    mainAxisSpacing: 10.sp,
                    mainAxisExtent: 100.h,
                  ),
                  scrollDirection: Axis.vertical,
                  itemCount: moneyAccountsCubit.moneyAccounts.length,
                  itemBuilder: (context, index) {
                    return AccountCardWidget(
                      model: moneyAccountsCubit.moneyAccounts[index],
                      total: moneyAccountsCubit.moneyAccounts
                          .fold(0, (num sum, e) => sum + (e.amount * e.rate)),
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
