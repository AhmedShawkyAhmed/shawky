import 'package:shawky/core/resources/color_manger.dart';
import 'package:shawky/core/routes/arguments/account_arguments.dart';
import 'package:shawky/core/shared/widgets/default_app_button.dart';
import 'package:shawky/core/shared/widgets/default_drop_down_menu.dart';
import 'package:shawky/core/shared/widgets/default_text_field.dart';
import 'package:shawky/core/shared/widgets/default_title_widget.dart';
import 'package:shawky/core/utils/enums.dart';
import 'package:shawky/core/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shawky/features/money/accounts/constants/accounts_constants.dart';

class AddAccountScreen extends StatelessWidget {
  final AccountArguments args;

  const AddAccountScreen({
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
              controller: args.cubit.accountNameController,
              hintText: args.model?.name ?? 'Account Name',
            ),
            DefaultTextField(
              controller: args.cubit.amountController,
              hintText: args.model?.amount.toString() ?? 'Amount',
              keyboardType: TextInputType.number,
            ),
            DefaultDropdown<AccountTypes>(
              items: AccountsConstants.accountTypesList,
              hint: "Account Type",
              selectedItem: args.model?.accountType ?? args.cubit.accountType,
              itemAsString: (AccountTypes? u) => u!.name.toCapitalized(),
              onChanged: args.cubit.changeAccountTypes,
            ),
            DefaultDropdown<Currency>(
              items: AccountsConstants.currencyList,
              hint: "Currency",
              selectedItem: args.model?.currency ?? args.cubit.currency,
              itemAsString: (Currency? u) => u!.name.toUpperCase(),
              onChanged: args.cubit.changeCurrency,
            ),
            SizedBox(height: 20.h),
            DefaultAppButton(
              title: "Save",
              onTap: () {
                if (args.model == null) {
                  args.cubit.emitAddAccount();
                } else {
                  args.cubit.emitUpdateAccount(model: args.model!);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
