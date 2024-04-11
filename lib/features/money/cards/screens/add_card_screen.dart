import 'package:finance/core/resources/color_manger.dart';
import 'package:finance/core/shared/widgets/default_app_button.dart';
import 'package:finance/core/shared/widgets/default_drop_down_menu.dart';
import 'package:finance/core/shared/widgets/default_text_field.dart';
import 'package:finance/core/shared/widgets/default_title_widget.dart';
import 'package:finance/core/utils/enums.dart';
import 'package:finance/core/utils/extensions.dart';
import 'package:finance/features/money/cards/cubit/cards_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddCardScreen extends StatelessWidget {
  const AddCardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    CardsCubit cubit = BlocProvider.of(context);
    return BlocBuilder<CardsCubit, CardsState>(
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
                  controller: cubit.nameOnCardController,
                  hintText: 'Name On Card',
                ),
                DefaultTextField(
                  controller: cubit.cardNumberController,
                  hintText: 'Card Number',
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
                          items: cubit.monthList,
                          hint: "Month",
                          itemAsString: (String? u) => u!,
                          onChanged: cubit.changeMonth,
                        ),
                      ),
                      SizedBox(
                        width: 170.w,
                        child: DefaultDropdown<String>(
                          padding: 0,
                          items: cubit.yearList,
                          hint: "Year",
                          itemAsString: (String? u) => u!,
                          onChanged: cubit.changeYear,
                        ),
                      ),
                    ],
                  ),
                ),
                DefaultDropdown<CardType>(
                  items: cubit.cardTypeList,
                  hint: "Card Type",
                  itemAsString: (CardType? u) => u!.name.toCapitalized(),
                  onChanged: cubit.changeCardType,
                ),
                DefaultDropdown<CardCompany>(
                  items: cubit.cardCompanyList,
                  hint: "Card Company",
                  itemAsString: (CardCompany? u) => u!.name.toUpperCase(),
                  onChanged: cubit.changeCardCompany,
                ),
                SizedBox(height: 20.h),
                DefaultAppButton(
                  title: "Save",
                  onTap: () {
                    cubit.emitInsertCard();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
