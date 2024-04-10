import 'package:finance/core/resources/color_manger.dart';
import 'package:finance/core/shared/widgets/default_app_button.dart';
import 'package:finance/core/shared/widgets/default_drop_down_menu.dart';
import 'package:finance/core/shared/widgets/default_text_field.dart';
import 'package:finance/core/shared/widgets/default_title_widget.dart';
import 'package:finance/core/utils/enums.dart';
import 'package:finance/features/money/cards/cubit/money_cards_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddCardScreen extends StatefulWidget {
  const AddCardScreen({super.key});

  @override
  State<AddCardScreen> createState() => _AddCardScreenState();
}

class _AddCardScreenState extends State<AddCardScreen> {
  late MoneyCardsCubit cubit = BlocProvider.of(context);

  TextEditingController nameController = TextEditingController();
  TextEditingController nameOnCardController = TextEditingController();
  TextEditingController cardNumberController = TextEditingController();
  CardType cardType = CardType.debit;
  CardCompany cardCompany = CardCompany.visa;
  String year = "00",month = "00";

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MoneyCardsCubit, MoneyCardsState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: ColorManager.secondary,
          body: Column(
            children: [
              const DefaultTitleWidget(title: "Add Card"),
              SizedBox(height: 20.h),
              DefaultTextField(
                controller: nameController,
                hintText: 'Name',
              ),
              DefaultTextField(
                controller: nameOnCardController,
                hintText: 'Name On Card',
              ),
              DefaultTextField(
                controller: cardNumberController,
                hintText: 'Card Number',
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
                        items: cubit.yearList,
                        hint: "Year",
                        itemAsString: (String? u) => u!,
                        onChanged: (val) {
                          setState(() {
                            year = val!;
                          });
                        },
                      ),
                    ),
                    SizedBox(
                      width: 170.w,
                      child: DefaultDropdown<String>(
                        padding: 0,
                        items: cubit.monthList,
                        hint: "Month",
                        itemAsString: (String? u) => u!,
                        onChanged: (val) {
                          setState(() {
                            month = val!;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
              DefaultDropdown<CardType>(
                items: cubit.cardTypeList,
                hint: "Card Type",
                itemAsString: (CardType? u) => u!.name,
                onChanged: (val) {
                  setState(() {
                    cardType = val!;
                  });
                },
              ),
              DefaultDropdown<CardCompany>(
                items: cubit.cardCompanyList,
                hint: "Card Company",
                itemAsString: (CardCompany? u) => u!.name,
                onChanged: (val) {
                  setState(() {
                    cardCompany = val!;
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
