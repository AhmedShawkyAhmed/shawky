import 'package:shawky/core/components/dialogs/warning_dialog.dart';
import 'package:shawky/core/resources/color_manger.dart';
import 'package:shawky/core/routes/arguments/card_arguments.dart';
import 'package:shawky/core/routes/routes_names.dart';
import 'package:shawky/core/services/navigation_service.dart';
import 'package:shawky/core/shared/widgets/default_floating_button.dart';
import 'package:shawky/core/shared/widgets/default_text.dart';
import 'package:shawky/core/shared/widgets/default_title_widget.dart';
import 'package:shawky/features/money/cards/cubit/cards_cubit.dart';
import 'package:shawky/features/money/cards/widgets/credit_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BankCardsScreen extends StatefulWidget {
  const BankCardsScreen({super.key});

  @override
  State<BankCardsScreen> createState() => _BankCardsScreenState();
}

class _BankCardsScreenState extends State<BankCardsScreen> {
  CardsCubit cubit = CardsCubit();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => cubit..emitGetCard(),
      child: BlocBuilder<CardsCubit, CardsState>(
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
                    padding: EdgeInsets.only(
                      top: 5.h,
                      bottom: 55.h,
                      left: 15.w,
                      right: 15.w,
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
                              cubit.emitDeleteCard(
                                cardId: cubit.moneyCardList[0].id!,
                              );
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
      ),
    );
  }
}
