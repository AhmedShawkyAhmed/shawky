import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shawky/core/resources/color_manger.dart';
import 'package:shawky/core/shared/widgets/default_item_card_widget.dart';
import 'package:shawky/features/home/cubit/home_cubit.dart';
import 'package:shawky/features/home/data/constants/home_constants.dart';
import 'package:shawky/features/home/ui/widgets/user_info_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeCubit cubit = HomeCubit();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => cubit..getSettings(),
      child: BlocBuilder<HomeCubit, HomeState>(
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
                      mainAxisExtent: 130.h,
                    ),
                    scrollDirection: Axis.vertical,
                    itemCount: HomeConstants.itemList.length,
                    itemBuilder: (context, index) {
                      return DefaultItemCardWidget(
                        model: HomeConstants.itemList[index],
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
