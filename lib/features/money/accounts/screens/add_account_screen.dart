import 'package:shawky/core/resources/color_manger.dart';
import 'package:shawky/core/shared/widgets/default_app_button.dart';
import 'package:shawky/core/shared/widgets/default_drop_down_menu.dart';
import 'package:shawky/core/shared/widgets/default_text_field.dart';
import 'package:shawky/core/shared/widgets/default_title_widget.dart';
import 'package:shawky/core/utils/enums.dart';
import 'package:shawky/core/utils/extensions.dart';
import 'package:shawky/features/money/accounts/cubit/accounts_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddAccountScreen extends StatelessWidget {
  const AddAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AccountsCubit cubit = BlocProvider.of(context);
    return BlocBuilder<AccountsCubit, AccountsState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: ColorManager.secondary,
          body: SingleChildScrollView(
            child: Column(
              children: [
                const DefaultTitleWidget(title: "Add Accounts"),
                SizedBox(height: 20.h),
                DefaultTextField(
                  controller: cubit.accountNameController,
                  hintText: 'Account Name',
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
                DefaultDropdown<AccountTypes>(
                  items: cubit.accountTypesList,
                  hint: "Account Type",
                  itemAsString: (AccountTypes? u) => u!.name.toCapitalized(),
                  onChanged: cubit.changeAccountTypes,
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
