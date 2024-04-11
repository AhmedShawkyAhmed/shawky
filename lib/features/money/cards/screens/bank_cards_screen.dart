import 'package:shawky/core/components/dialogs/warning_dialog.dart';
import 'package:shawky/core/resources/color_manger.dart';
import 'package:shawky/core/routes/arguments/card_arguments.dart';
import 'package:shawky/core/routes/routes_names.dart';
import 'package:shawky/core/services/navigation_service.dart';
import 'package:shawky/core/shared/widgets/default_floating_button.dart';
import 'package:shawky/core/shared/widgets/default_text.dart';
import 'package:shawky/core/shared/widgets/default_title_widget.dart';
import 'package:shawky/core/utils/shared_functions.dart';
import 'package:shawky/features/money/cards/cubit/cards_cubit.dart';
import 'package:shawky/features/money/cards/widgets/credit_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BankCardsScreen extends StatelessWidget {
  const BankCardsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    CardsCubit cubit = BlocProvider.of(context);
    return BlocBuilder<CardsCubit, CardsState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: ColorManager.secondary,
          floatingActionButton: DefaultFloatingButton(
            onPressed: () {
              NavigationService.pushNamed(
                Routes.addCardsScreen,
                arguments: CardArguments(
                  cubit: cubit,
                  title: "Add Card",
                ),
              );
            },
          ),
          body: Column(
            children: [
              const DefaultTitleWidget(title: "Cards"),
              Expanded(
                child: cubit.moneyCardList.isEmpty
                    ? Center(
                        child: DefaultText(
                          text: "No Cards Found !",
                          textColor: ColorManager.white,
                          fontSize: 18.sp,
                        ),
                      )
                    : GridView.builder(
                        shrinkWrap: true,
                        padding: EdgeInsets.symmetric(
                          vertical: 5.h,
                          horizontal: 15.w,
                        ),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 1,
                          crossAxisSpacing: 20.sp,
                          mainAxisSpacing: 10.sp,
                          mainAxisExtent: 185.h,
                        ),
                        scrollDirection: Axis.vertical,
                        itemCount: cubit.moneyCardList.length,
                        itemBuilder: (context, index) {
                          return CreditCard(
                            model: cubit.moneyCardList[index],
                            onTap: () {
                              NavigationService.pushNamed(
                                Routes.addCardsScreen,
                                arguments: CardArguments(
                                  cubit: cubit,
                                  title: "Edit Card",
                                  isEdit: true,
                                  model: cubit.moneyCardList[index],
                                ),
                              );
                            },
                            onLongPress: () {
                              WarningDialog.show(
                                message:
                                    "Are you Sure you want to Delete this Card ?",
                                onPressed: () {
                                  NavigationService.pop();
                                  printLog(cubit.moneyCardList[index]);
                                  cubit.emitDeleteCard(
                                      cardId: cubit.moneyCardList[index].id!);
                                },
                              );
                            },
                          );
                        },
                      ),
              ),
            ],
          ),
        );
      },
    );
  }
}
