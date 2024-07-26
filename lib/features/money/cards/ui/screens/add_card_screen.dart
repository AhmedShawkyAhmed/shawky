import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shawky/core/resources/color_manger.dart';
import 'package:shawky/core/resources/credit_card_formatter.dart';
import 'package:shawky/core/routes/arguments/card_arguments.dart';
import 'package:shawky/core/shared/widgets/default_app_button.dart';
import 'package:shawky/core/shared/widgets/default_drop_down_menu.dart';
import 'package:shawky/core/shared/widgets/default_text_field.dart';
import 'package:shawky/core/shared/widgets/default_title_widget.dart';
import 'package:shawky/core/utils/enums.dart';
import 'package:shawky/core/utils/extensions.dart';
import 'package:shawky/features/money/cards/data/constants/cards_constants.dart';

class AddCardScreen extends StatelessWidget {
  final CardArguments args;

  const AddCardScreen({
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
              hintText: args.model?.name ?? 'Name',
              maxLength: 20,
            ),
            DefaultTextField(
              controller: args.cubit.nameOnCardController,
              hintText: args.model?.nameOnCard ?? 'Name On Card',
              maxLength: 20,
            ),
            DefaultTextField(
              controller: args.cubit.cardNumberController,
              hintText: args.model?.cardNumber ?? 'Card Number',
              maxLength: 19,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp("[0-9]")),
                CreditCardNumberFormatter(),
              ],
              keyboardType: TextInputType.number,
            ),
            DefaultTextField(
              controller: args.cubit.cvvController,
              hintText: args.model?.cvv ?? 'CVV',
              maxLength: 3,
              keyboardType: TextInputType.number,
            ),
            Padding(
              padding: EdgeInsetsDirectional.symmetric(horizontal: 15.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 170.w,
                    child: DefaultDropdown<String>(
                      padding: 0,
                      items: CardsConstants.monthList,
                      hint: "Month",
                      selectedItem: args.model?.exp.substring(0, 2),
                      itemAsString: (String? u) => u!,
                      onChanged: args.cubit.changeMonth,
                    ),
                  ),
                  SizedBox(
                    width: 170.w,
                    child: DefaultDropdown<String>(
                      padding: 0,
                      items: CardsConstants.yearList,
                      hint: "Year",
                      selectedItem: args.model?.exp.substring(3, 5),
                      itemAsString: (String? u) => u!,
                      onChanged: args.cubit.changeYear,
                    ),
                  ),
                ],
              ),
            ),
            DefaultDropdown<CardType>(
              items: CardsConstants.cardTypeList,
              hint: "Card Type",
              selectedItem: args.model?.cardType ?? args.cubit.cardType,
              itemAsString: (CardType? u) => u!.name.toCapitalized(),
              onChanged: args.cubit.changeCardType,
            ),
            DefaultDropdown<CardCompany>(
              items: CardsConstants.cardCompanyList,
              hint: "Card Company",
              selectedItem: args.model?.cardCompany ?? args.cubit.cardCompany,
              itemAsString: (CardCompany? u) => u!.name.toUpperCase(),
              onChanged: args.cubit.changeCardCompany,
            ),
            SizedBox(height: 20.h),
            DefaultAppButton(
              title: "Save",
              onTap: () {
                if (args.model == null) {
                  args.cubit.emitAddCard();
                } else {
                  args.cubit.emitUpdateCard(model: args.model!);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
