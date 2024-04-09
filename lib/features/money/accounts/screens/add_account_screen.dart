import 'package:finance/core/resources/color_manger.dart';
import 'package:finance/core/shared/widgets/default_app_button.dart';
import 'package:finance/core/shared/widgets/default_drop_down_menu.dart';
import 'package:finance/core/shared/widgets/default_text_field.dart';
import 'package:finance/core/shared/widgets/default_title_widget.dart';
import 'package:finance/core/utils/enums.dart';
import 'package:finance/features/money/accounts/cubit/money_accounts_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddAccountScreen extends StatefulWidget {
  const AddAccountScreen({super.key});

  @override
  State<AddAccountScreen> createState() => _AddAccountScreenState();
}

class _AddAccountScreenState extends State<AddAccountScreen> {
  late MoneyAccountsCubit cubit = BlocProvider.of(context);

  TextEditingController accountNameController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController rateController = TextEditingController();
  AccountTypes accountType = AccountTypes.main;
  Currency currency = Currency.egp;
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MoneyAccountsCubit, MoneyAccountsState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: ColorManager.secondary,
          body: Column(
            children: [
              const DefaultTitleWidget(title: "Add Accounts"),
              SizedBox(height: 20.h),
              DefaultTextField(
                controller: accountNameController,
                hintText: 'Account Name',
              ),
              DefaultTextField(
                controller: amountController,
                hintText: 'Amount',
              ),
              DefaultTextField(
                controller: rateController,
                hintText: 'Rate',
              ),
              DefaultDropdown<AccountTypes>(
                items: cubit.accountTypesList,
                hint: "Account Type",
                itemAsString: (AccountTypes? u) => u!.name,
                // showSearchBox: true,
                onChanged: (val) {
                  setState(() {
                    accountType = val!;
                  });
                },
              ),
              DefaultDropdown<Currency>(
                items: cubit.currencyList,
                hint: "Currency",
                itemAsString: (Currency? u) => u!.name,
                // showSearchBox: true,
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
        );
      },
    );
  }
}
