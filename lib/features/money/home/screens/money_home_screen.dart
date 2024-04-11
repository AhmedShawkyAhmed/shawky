import 'package:shawky/core/resources/color_manger.dart';
import 'package:shawky/core/shared/widgets/default_item_card_widget.dart';
import 'package:shawky/core/shared/widgets/default_title_widget.dart';
import 'package:shawky/features/money/home/cubit/money_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MoneyHomeScreen extends StatelessWidget {
  const MoneyHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    MoneyCubit cubit = BlocProvider.of(context);
    return BlocBuilder<MoneyCubit, MoneyState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: ColorManager.secondary,
          body: Column(
            children: [
              const DefaultTitleWidget(title: "Money"),
              Expanded(
                child: GridView.builder(
                  shrinkWrap: true,
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
                  itemCount: cubit.itemList.length,
                  itemBuilder: (context, index) {
                    return DefaultItemCardWidget(
                      model: cubit.itemList[index],
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
