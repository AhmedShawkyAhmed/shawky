import 'package:finance/core/resources/color_manger.dart';
import 'package:finance/core/services/service_locator.dart';
import 'package:finance/core/shared/widgets/default_app_button.dart';
import 'package:finance/core/shared/widgets/default_drop_down_menu.dart';
import 'package:finance/core/shared/widgets/default_text_field.dart';
import 'package:finance/core/shared/widgets/default_title_widget.dart';
import 'package:finance/core/utils/enums.dart';
import 'package:finance/features/money/accounts/cubit/accounts_cubit.dart';
import 'package:finance/features/money/accounts/data/models/account_model.dart';
import 'package:finance/features/money/expenses/cubit/expenses_cubit.dart';
import 'package:finance/features/money/expenses/data/models/expenses_category_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddExpensesScreen extends StatefulWidget {
  const AddExpensesScreen({super.key});

  @override
  State<AddExpensesScreen> createState() => _AddExpensesScreenState();
}

class _AddExpensesScreenState extends State<AddExpensesScreen> {
  late ExpensesCubit cubit = BlocProvider.of(context);
  TextEditingController nameController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController rateController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  ExpensesType type = ExpensesType.income;
  Currency currency = Currency.egp;
  ExpensesCategoryModel expensesCategoryModel = ExpensesCategoryModel();
  AccountModel fromAccount = AccountModel();
  AccountModel toAccount = AccountModel();

  @override
  Widget build(BuildContext context) {
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
                  controller: nameController,
                  hintText: 'Name',
                ),
                DefaultTextField(
                  controller: amountController,
                  hintText: 'Amount',
                  keyboardType: TextInputType.number,
                ),
                DefaultTextField(
                  controller: rateController,
                  hintText: 'Rate',
                  keyboardType: TextInputType.number,
                ),
                DefaultTextField(
                  controller: dateController,
                  hintText: 'Date',
                ),
                DefaultDropdown<ExpensesType>(
                  items: cubit.expensesTypeList,
                  hint: "Expenses Type",
                  itemAsString: (ExpensesType? u) => u!.name,
                  onChanged: (val) {
                    setState(() {
                      type = val!;
                    });
                  },
                ),
                DefaultDropdown<ExpensesCategoryModel>(
                  items: cubit.expensesCategoryList,
                  showSearchBox: true,
                  hint: "Expenses Category",
                  itemAsString: (ExpensesCategoryModel? u) => u!.name!,
                  onChanged: (val) {
                    setState(() {
                      expensesCategoryModel = val!;
                    });
                  },
                ),
                DefaultDropdown<AccountModel>(
                  items: getIt<AccountsCubit>().moneyAccounts,
                  hint: "From Account",
                  itemAsString: (AccountModel? u) => u!.name!,
                  onChanged: (val) {
                    setState(() {
                      fromAccount = val!;
                    });
                  },
                ),
                DefaultDropdown<AccountModel>(
                  items: getIt<AccountsCubit>().moneyAccounts,
                  hint: "To Account",
                  itemAsString: (AccountModel? u) => u!.name!,
                  onChanged: (val) {
                    setState(() {
                      toAccount = val!;
                    });
                  },
                ),
                DefaultDropdown<Currency>(
                  items: cubit.currencyList,
                  hint: "Currency",
                  itemAsString: (Currency? u) => u!.name,
                  onChanged: (val) {
                    setState(() {
                      currency = val!;
                    });
                  },
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
