import 'package:finance/core/resources/color_manger.dart';
import 'package:finance/core/services/service_locator.dart';
import 'package:finance/core/shared/widgets/default_app_button.dart';
import 'package:finance/core/shared/widgets/default_drop_down_menu.dart';
import 'package:finance/core/shared/widgets/default_text_field.dart';
import 'package:finance/core/shared/widgets/default_title_widget.dart';
import 'package:finance/core/utils/enums.dart';
import 'package:finance/core/utils/extensions.dart';
import 'package:finance/features/money/accounts/cubit/accounts_cubit.dart';
import 'package:finance/features/money/accounts/data/models/account_model.dart';
import 'package:finance/features/money/expenses/cubit/expenses_cubit.dart';
import 'package:finance/features/money/expenses/data/models/expenses_category_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddExpensesScreen extends StatelessWidget {
  const AddExpensesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ExpensesCubit cubit = BlocProvider.of(context);
    return BlocBuilder<ExpensesCubit, ExpensesState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: ColorManager.secondary,
          body: SingleChildScrollView(
            child: Column(
              children: [
                const DefaultTitleWidget(title: "Add Card"),
                SizedBox(height: 20.h),
                DefaultTextField(
                  controller: cubit.nameController,
                  hintText: 'Name',
                ),
                DefaultTextField(
                  controller: cubit.amountController,
                  hintText: 'Amount',
                  keyboardType: TextInputType.number,
                ),
                DefaultTextField(
                  controller: cubit.rateController,
                  hintText: 'Rate',
                  keyboardType: TextInputType.number,
                ),
                DefaultTextField(
                  controller: cubit.dateController,
                  hintText: 'Date',
                ),
                DefaultDropdown<ExpensesType>(
                  items: cubit.expensesTypeList,
                  hint: "Expenses Type",
                  itemAsString: (ExpensesType? u) => u!.name.toCapitalized(),
                  onChanged: cubit.changeExpensesType,
                ),
                DefaultDropdown<ExpensesCategoryModel>(
                  items: cubit.expensesCategoryList,
                  showSearchBox: true,
                  hint: "Expenses Category",
                  itemAsString: (ExpensesCategoryModel? u) => u!.name!.toCapitalized(),
                  onChanged: cubit.changeExpensesCategory,
                ),
                DefaultDropdown<AccountModel>(
                  items: getIt<AccountsCubit>().moneyAccounts,
                  hint: "From Account",
                  itemAsString: (AccountModel? u) => u!.name!.toCapitalized(),
                  onChanged: cubit.changeFromAccount,
                ),
                DefaultDropdown<AccountModel>(
                  items: getIt<AccountsCubit>().moneyAccounts,
                  hint: "To Account",
                  itemAsString: (AccountModel? u) => u!.name!.toCapitalized(),
                  onChanged: cubit.changeToAccount,
                ),
                DefaultDropdown<Currency>(
                  items: cubit.currencyList,
                  hint: "Currency",
                  itemAsString: (Currency? u) => u!.name.toUpperCase(),
                  onChanged: cubit.changeCurrency,
                ),
                SizedBox(height: 20.h),
                DefaultAppButton(
                  title: "Save",
                  onTap: () {},
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
