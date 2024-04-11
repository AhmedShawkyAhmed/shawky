import 'package:finance/core/resources/color_manger.dart';
import 'package:finance/core/routes/routes_names.dart';
import 'package:finance/core/services/navigation_service.dart';
import 'package:finance/core/shared/widgets/default_floating_button.dart';
import 'package:finance/core/shared/widgets/default_title_widget.dart';
import 'package:finance/features/money/savings/cubit/savings_cubit.dart';
import 'package:finance/features/money/savings/widgets/saving_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SavingsScreen extends StatelessWidget {
  const SavingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SavingsCubit cubit = BlocProvider.of(context);
    return BlocBuilder<SavingsCubit, SavingsState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: ColorManager.secondary,
          floatingActionButton: DefaultFloatingButton(
            onPressed: () {
              NavigationService.pushNamed(Routes.addSavingScreen);
            },
          ),
          body: Column(
            children: [
              const DefaultTitleWidget(title: "Savings"),
              Expanded(
                child: GridView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.symmetric(
                    vertical: 5.h,
                    horizontal: 15.w,
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
                    return SavingCard(model: cubit.savingList[index]);
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
