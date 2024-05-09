import 'package:shawky/core/resources/color_manger.dart';
import 'package:shawky/core/routes/arguments/expenses_arguments.dart';
import 'package:shawky/core/shared/widgets/default_app_button.dart';
import 'package:shawky/core/shared/widgets/default_drop_down_menu.dart';
import 'package:shawky/core/shared/widgets/default_text_field.dart';
import 'package:shawky/core/shared/widgets/default_title_widget.dart';
import 'package:shawky/core/utils/enums.dart';
import 'package:shawky/core/utils/extensions.dart';
import 'package:shawky/features/money/accounts/models/account_model.dart';
import 'package:shawky/features/money/expenses/models/expenses_category_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddExpensesScreen extends StatelessWidget {
  final ExpensesArguments args;

  const AddExpensesScreen({
    super.key,
    required this.args,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.secondary,
      body: SingleChildScrollView(
        child: Column(
          children: [
            DefaultTitleWidget(title: args.title),
            SizedBox(height: 20.h),
            DefaultTextField(
              controller: args.cubit.nameController,
              hintText: 'Name',
            ),
            DefaultTextField(
              controller: args.cubit.amountController,
              hintText: 'Amount',
              keyboardType: TextInputType.number,
            ),
            DefaultTextField(
              controller: args.cubit.dateController,
              hintText: 'Date',
              enabled: false,
              onTap: () {
                args.cubit.selectDate(true);
              },
            ),
            DefaultDropdown<ExpensesType>(
              items: args.cubit.expensesTypeList,
              hint: "Expenses Type",
              itemAsString: (ExpensesType? u) => u!.name.toCapitalized(),
              selectedItem: args.cubit.expensesType,
              onChanged: args.cubit.changeExpensesType,
            ),
            DefaultDropdown<ExpensesCategoryModel>(
              items: args.cubit.expensesCategoryList,
              showSearchBox: true,
              hint: "Expenses Category",
              itemAsString: (ExpensesCategoryModel? u) =>
                  u!.name!.toCapitalized(),
              onChanged: args.cubit.changeExpensesCategory,
            ),
            if (args.cubit.expensesType != ExpensesType.income)
              DefaultDropdown<AccountModel>(
                items: args.accountsCubit.moneyAccounts,
                hint: "From Account",
                itemAsString: (AccountModel? u) => u!.name!.toCapitalized(),
                onChanged: args.cubit.changeFromAccount,
              ),
            if (args.cubit.expensesType != ExpensesType.expenses)
              DefaultDropdown<AccountModel>(
                items: args.accountsCubit.moneyAccounts,
                hint: "To Account",
                itemAsString: (AccountModel? u) => u!.name!.toCapitalized(),
                onChanged: args.cubit.changeToAccount,
              ),
            DefaultDropdown<Currency>(
              items: args.cubit.currencyList,
              hint: "Currency",
              itemAsString: (Currency? u) => u!.name.toUpperCase(),
              selectedItem: args.cubit.currency,
              onChanged: args.cubit.changeCurrency,
            ),
            SizedBox(height: 20.h),
            DefaultAppButton(
              title: "Save",
              onTap: () {
                args.cubit.emitAddExpense();
              },
            ),
          ],
        ),
      ),
    );
  }
}
