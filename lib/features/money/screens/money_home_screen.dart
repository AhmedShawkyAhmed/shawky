import 'package:finance/core/resources/color_manger.dart';
import 'package:finance/core/shared/widgets/default_item_card_widget.dart';
import 'package:finance/core/shared/widgets/default_title_widget.dart';
import 'package:finance/features/money/cubit/money_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MoneyHomeScreen extends StatelessWidget {
  const MoneyHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    MoneyCubit moneyCubit = BlocProvider.of(context);
    return BlocBuilder<MoneyCubit, MoneyState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: ColorManager.secondary,
          body: SingleChildScrollView(
            child: Column(
              children: [
                const DefaultTitleWidget(title: "Money",),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(
                    vertical: 15.h,
                    horizontal: 15.w,
                  ),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 20.sp,
                    mainAxisSpacing: 20.sp,
                    mainAxisExtent: 120.h,
                  ),
                  scrollDirection: Axis.vertical,
                  itemCount: moneyCubit.itemList.length,
                  itemBuilder: (context, index) {
                    return DefaultItemCardWidget(
                      model: moneyCubit.itemList[index],
                    );
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
