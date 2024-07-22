import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shawky/core/resources/color_manger.dart';
import 'package:shawky/core/routes/arguments/expenses_arguments.dart';
import 'package:shawky/core/services/service_locator.dart';
import 'package:shawky/core/shared/widgets/default_app_button.dart';
import 'package:shawky/core/shared/widgets/default_drop_down_menu.dart';
import 'package:shawky/core/shared/widgets/default_text_field.dart';
import 'package:shawky/core/shared/widgets/default_title_widget.dart';
import 'package:shawky/core/utils/enums.dart';
import 'package:shawky/core/utils/extensions.dart';
import 'package:shawky/features/money/accounts/cubit/accounts_cubit.dart';
import 'package:shawky/features/money/accounts/models/account_model.dart';
import 'package:shawky/features/money/expenses/constants/expenses_constants.dart';
import 'package:shawky/features/money/expenses/models/expenses_category_model.dart';

class AddExpensesScreen extends StatefulWidget {
  final ExpensesArguments args;

  const AddExpensesScreen({
    super.key,
    required this.args,
  });

  @override
  State<AddExpensesScreen> createState() => _AddExpensesScreenState();
}

class _AddExpensesScreenState extends State<AddExpensesScreen> {
  AccountsCubit accountsCubit = AccountsCubit(getIt());

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => accountsCubit..emitGetAccounts(),
      child: Scaffold(
        backgroundColor: ColorManager.secondary,
        body: SingleChildScrollView(
          child: Column(
            children: [
              DefaultTitleWidget(title: widget.args.title),
              SizedBox(height: 20.h),
              DefaultTextField(
                controller: widget.args.cubit.nameController,
                hintText: 'Name',
              ),
              DefaultTextField(
                controller: widget.args.cubit.amountController,
                hintText: 'Amount',
                keyboardType: TextInputType.number,
              ),
              DefaultTextField(
                controller: widget.args.cubit.dateController,
                hintText: 'Date',
                enabled: false,
                onTap: () {
                  widget.args.cubit.selectDate(true);
                },
              ),
              DefaultDropdown<ExpensesType>(
                items: ExpensesConstants.expensesTypeList,
                hint: "Expenses Type",
                itemAsString: (ExpensesType? u) => u!.name.toCapitalized(),
                selectedItem: widget.args.cubit.expensesType,
                onChanged: widget.args.cubit.changeExpensesType,
              ),
              DefaultDropdown<ExpensesCategoryModel>(
                items: ExpensesConstants.expensesCategoryList,
                showSearchBox: true,
                hint: "Expenses Category",
                itemAsString: (ExpensesCategoryModel? u) =>
                    u!.name!.toCapitalized(),
                onChanged: widget.args.cubit.changeExpensesCategory,
              ),
              BlocBuilder<AccountsCubit, AccountsState>(
                builder: (context, state) {
                  return Column(
                    children: [
                      if (widget.args.cubit.expensesType != ExpensesType.income)
                        DefaultDropdown<AccountModel>(
                          items: accountsCubit.moneyAccounts,
                          hint: "From Account",
                          itemAsString: (AccountModel? u) => u!.name!,
                          onChanged: widget.args.cubit.changeFromAccount,
                        ),
                      if (widget.args.cubit.expensesType !=
                          ExpensesType.expenses)
                        DefaultDropdown<AccountModel>(
                          items: accountsCubit.moneyAccounts,
                          hint: "To Account",
                          itemAsString: (AccountModel? u) => u!.name!,
                          onChanged: widget.args.cubit.changeToAccount,
                        ),
                    ],
                  );
                },
              ),
              DefaultDropdown<Currency>(
                items: ExpensesConstants.currencyList,
                hint: "Currency",
                itemAsString: (Currency? u) => u!.name.toUpperCase(),
                selectedItem: widget.args.cubit.currency,
                onChanged: widget.args.cubit.changeCurrency,
              ),
              SizedBox(height: 20.h),
              DefaultAppButton(
                title: "Save",
                onTap: () {
                  widget.args.cubit.emitAddExpense();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
