import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shawky/core/components/dialogs/warning_dialog.dart';
import 'package:shawky/core/resources/color_manger.dart';
import 'package:shawky/core/resources/globals.dart';
import 'package:shawky/core/routes/arguments/account_arguments.dart';
import 'package:shawky/core/routes/routes_names.dart';
import 'package:shawky/core/services/navigation_service.dart';
import 'package:shawky/core/shared/widgets/default_floating_button.dart';
import 'package:shawky/core/shared/widgets/default_text.dart';
import 'package:shawky/core/shared/widgets/default_title_widget.dart';
import 'package:shawky/core/utils/enums.dart';
import 'package:shawky/features/money/accounts/cubit/accounts_cubit.dart';
import 'package:shawky/features/money/accounts/widgets/account_card.dart';
import 'package:shawky/features/money/accounts/widgets/total_balance_widget.dart';

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
              NavigationService.pushNamed(
                Routes.addAccountsScreen,
                arguments: AccountArguments(
                  cubit: cubit,
                  title: "Add Account",
                ),
              );
            },
          ),
          body: Column(
            children: [
              const DefaultTitleWidget(title: "Accounts"),
              TotalBalanceWidget(
                  total:
                      cubit.moneyAccounts.fold(0, (num sum, e) => sum + ((e.amount ?? 0) * (e.currency == Currency.egp ? 1 : (Globals.settings?.rate ?? 1)))).toStringAsFixed(2)),
              Expanded(
                child: cubit.moneyAccounts.isEmpty
                    ? Center(
                        child: DefaultText(
                          text: "No Accounts Found !",
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
                                  sum +
                                  ((e.amount ?? 0) *
                                      (e.currency == Currency.egp
                                          ? 1
                                          : (Globals.settings?.rate ?? 1))),
                            ),
                            onTap: () {
                              NavigationService.pushNamed(
                                Routes.addAccountsScreen,
                                arguments: AccountArguments(
                                  cubit: cubit,
                                  title: "Edit Account",
                                  model: cubit.moneyAccounts[index],
                                ),
                              );
                            },
                            onLongPress: () {
                              WarningDialog.show(
                                message:
                                    "Are you Sure you want to Delete this Account ?",
                                onPressed: () {
                                  NavigationService.pop();
                                  cubit.emitDeleteAccount(
                                    accountId: cubit.moneyAccounts[index].id!,
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
