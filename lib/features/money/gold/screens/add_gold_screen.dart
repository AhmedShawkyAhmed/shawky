import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shawky/core/resources/color_manger.dart';
import 'package:shawky/core/shared/widgets/default_app_button.dart';
import 'package:shawky/core/shared/widgets/default_text_field.dart';
import 'package:shawky/core/shared/widgets/default_title_widget.dart';
import 'package:shawky/features/money/gold/cubit/gold_cubit.dart';

class AddGoldScreen extends StatelessWidget {
  final GoldCubit cubit;

  const AddGoldScreen({
    required this.cubit,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.secondary,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const DefaultTitleWidget(title: "Add Gold"),
            SizedBox(height: 20.h),
            DefaultTextField(
              controller: cubit.nameController,
              hintText: 'Name',
            ),
            DefaultTextField(
              controller: cubit.weightController,
              hintText: 'Weight',
              keyboardType: TextInputType.number,
            ),
            DefaultTextField(
              controller: cubit.priceController,
              hintText: 'Price',
              keyboardType: TextInputType.number,
            ),
            DefaultTextField(
              controller: cubit.dateController,
              hintText: 'Date',
              enabled: false,
              onTap: () {
                cubit.selectDate();
              },
            ),
            SizedBox(height: 20.h),
            DefaultAppButton(
              title: "Save",
              onTap: () {
                cubit.emitAddGold();
              },
            ),
          ],
        ),
      ),
    );
  }
}
