import 'package:shawky/core/resources/color_manger.dart';
import 'package:shawky/core/routes/routes_names.dart';
import 'package:shawky/core/services/navigation_service.dart';
import 'package:shawky/core/shared/widgets/default_floating_button.dart';
import 'package:shawky/core/shared/widgets/default_title_widget.dart';
import 'package:shawky/features/money/accounts/cubit/accounts_cubit.dart';
import 'package:shawky/features/money/accounts/widgets/account_card.dart';
import 'package:shawky/features/money/accounts/widgets/total_balance_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MoneyAccountsScreen extends StatelessWidget {
  const MoneyAccountsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AccountsCubit cubit = BlocProvider.of(context);
    return BlocBuilder<AccountsCubit, AccountsState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: ColorManager.secondary,
          floatingActionButton: DefaultFloatingButton(
            onPressed: () {
              NavigationService.pushNamed(Routes.addAccountsScreen);
            },
          ),
          body: Column(
            children: [
              const DefaultTitleWidget(title: "Accounts"),
              TotalBalanceWidget(
                  total:
                      "${cubit.moneyAccounts.fold(0, (num sum, e) => sum + ((e.amount ?? 0) * (e.rate ?? 0)))}"),
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
                  itemCount: cubit.moneyAccounts.length,
                  itemBuilder: (context, index) {
                    return AccountCard(
                      model: cubit.moneyAccounts[index],
                      total: cubit.moneyAccounts.fold(
                          0,
                          (num sum, e) =>
                              sum + ((e.amount ?? 0) * (e.rate ?? 0))),
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
