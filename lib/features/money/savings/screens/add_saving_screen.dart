import 'package:shawky/core/resources/color_manger.dart';
import 'package:shawky/core/shared/widgets/default_app_button.dart';
import 'package:shawky/core/shared/widgets/default_text_field.dart';
import 'package:shawky/core/shared/widgets/default_title_widget.dart';
import 'package:shawky/features/money/savings/cubit/savings_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddSavingScreen extends StatelessWidget {
  const AddSavingScreen({super.key});

  @override
  Widget build(BuildContext context) {
   SavingsCubit cubit = BlocProvider.of(context);
    return BlocBuilder<SavingsCubit, SavingsState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: ColorManager.secondary,
          body: SingleChildScrollView(
            child: Column(
              children: [
                const DefaultTitleWidget(title: "Add Saving"),
                SizedBox(height: 20.h),
                DefaultTextField(
                  controller: cubit.nameController,
                  hintText: 'Name',
                ),
                DefaultTextField(
                  controller: cubit.targetController,
                  hintText: 'Target',
                  keyboardType: TextInputType.number,
                ),
                DefaultTextField(
                  controller: cubit.currentController,
                  hintText: 'Current',
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: 20.h),
                DefaultAppButton(
                  title: "Save",
                  onTap: () {},
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
