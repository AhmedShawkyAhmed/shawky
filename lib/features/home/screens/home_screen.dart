import 'package:finance/core/shared/widgets/default_item_card_widget.dart';
import 'package:finance/core/resources/color_manger.dart';
import 'package:finance/features/home/cubit/home_cubit.dart';
import 'package:finance/features/home/widgets/user_info_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    HomeCubit homeCubit = BlocProvider.of(context);
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: ColorManager.secondary,
          body: Column(
            children: [
              const UserInfoWidget(),
              Expanded(
                child: GridView.builder(
                  shrinkWrap: true,
                  // physics: const NeverScrollableScrollPhysics(),
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
                  itemCount: homeCubit.itemList.length,
                  itemBuilder: (context, index) {
                    return DefaultItemCardWidget(
                      model: homeCubit.itemList[index],
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
