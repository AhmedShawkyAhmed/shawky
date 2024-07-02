import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shawky/core/components/dialogs/warning_dialog.dart';
import 'package:shawky/core/resources/color_manger.dart';
import 'package:shawky/core/routes/routes_names.dart';
import 'package:shawky/core/services/navigation_service.dart';
import 'package:shawky/core/services/service_locator.dart';
import 'package:shawky/core/shared/widgets/default_floating_button.dart';
import 'package:shawky/core/shared/widgets/default_text.dart';
import 'package:shawky/core/shared/widgets/default_title_widget.dart';
import 'package:shawky/features/money/gold/cubit/gold_cubit.dart';
import 'package:shawky/features/money/gold/widgets/gold_card.dart';
import 'package:shawky/features/money/gold/widgets/total_gold_widget.dart';

class GoldScreen extends StatefulWidget {
  const GoldScreen({super.key});

  @override
  State<GoldScreen> createState() => _GoldScreenState();
}

class _GoldScreenState extends State<GoldScreen> {
  GoldCubit cubit = GoldCubit(getIt());

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => cubit..emitGetGold(),
      child: BlocBuilder<GoldCubit, GoldState>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: ColorManager.secondary,
            floatingActionButton: DefaultFloatingButton(
              onPressed: () {
                NavigationService.pushNamed(
                  Routes.addGoldScreen,
                  arguments: cubit,
                );
              },
            ),
            body: Column(
              children: [
                const DefaultTitleWidget(title: "Gold"),
                TotalGoldWidget(
                  grams:
                  "${cubit.goldList.fold(
                      0, (num sum, e) => sum + double.parse(e.weight))}",
                  price: (cubit.goldList.fold(0, (num sum, e) => sum + e.price))
                      .toStringAsFixed(2),
                ),
                Expanded(
                  child: cubit.goldList.isEmpty
                      ? Center(
                    child: DefaultText(
                      text: "No Gold Found !",
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
                    itemCount: cubit.goldList.length,
                    itemBuilder: (context, index) {
                      return GoldCard(
                        model: cubit.goldList[index],
                        onLongPress: () {
                          WarningDialog.show(
                            message:
                            "Are you Sure you want to Delete this Gold Item ?",
                            onPressed: () {
                              NavigationService.pop();
                              cubit.emitDeleteGold(
                                goldId: cubit.goldList[index].id!,
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
