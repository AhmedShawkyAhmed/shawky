import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shawky/core/components/dialogs/warning_dialog.dart';
import 'package:shawky/core/resources/color_manger.dart';
import 'package:shawky/core/routes/arguments/saving_arguments.dart';
import 'package:shawky/core/routes/routes_names.dart';
import 'package:shawky/core/services/navigation_service.dart';
import 'package:shawky/core/services/service_locator.dart';
import 'package:shawky/core/shared/widgets/default_floating_button.dart';
import 'package:shawky/core/shared/widgets/default_text.dart';
import 'package:shawky/core/shared/widgets/default_title_widget.dart';
import 'package:shawky/features/money/savings/cubit/savings_cubit.dart';
import 'package:shawky/features/money/savings/ui/widgets/saving_card.dart';

class SavingsScreen extends StatefulWidget {
  const SavingsScreen({super.key});

  @override
  State<SavingsScreen> createState() => _SavingsScreenState();
}

class _SavingsScreenState extends State<SavingsScreen> {
  SavingsCubit cubit = SavingsCubit(getIt());

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => cubit..emitGetSavings(),
      child: BlocBuilder<SavingsCubit, SavingsState>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: ColorManager.secondary,
            floatingActionButton: DefaultFloatingButton(
              onPressed: () {
                NavigationService.pushNamed(
                  Routes.addSavingScreen,
                  arguments: SavingArguments(
                    cubit: cubit,
                    title: "Add Savings",
                  ),
                );
              },
            ),
            body: Column(
              children: [
                const DefaultTitleWidget(title: "Savings"),
                Expanded(
                  child: cubit.savingList.isEmpty
                      ? Center(
                    child: DefaultText(
                      text: "No Savings Found !",
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
                      mainAxisExtent: 70.h,
                    ),
                    scrollDirection: Axis.vertical,
                    itemCount: cubit.savingList.length,
                    itemBuilder: (context, index) {
                      return SavingCard(
                        model: cubit.savingList[index],
                        onTap: () {
                          NavigationService.pushNamed(
                            Routes.addSavingScreen,
                            arguments: SavingArguments(
                              cubit: cubit,
                              title: "Edit Savings",
                              model: cubit.savingList[index],
                            ),
                          );
                        },
                        onLongPress: () {
                          WarningDialog.show(
                            message:
                            "Are you Sure you want to Delete this Saving ?",
                            onPressed: () {
                              NavigationService.pop();
                              cubit.emitDeleteSavings(
                                savingsId: cubit.savingList[index].id!,
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
