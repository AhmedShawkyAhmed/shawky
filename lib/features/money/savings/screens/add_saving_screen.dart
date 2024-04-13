import 'package:shawky/core/resources/color_manger.dart';
import 'package:shawky/core/routes/arguments/saving_arguments.dart';
import 'package:shawky/core/shared/widgets/default_app_button.dart';
import 'package:shawky/core/shared/widgets/default_text_field.dart';
import 'package:shawky/core/shared/widgets/default_title_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddSavingScreen extends StatelessWidget {
  final SavingArguments args;

  const AddSavingScreen({
    super.key,
    required this.args,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.secondary,
      body: SingleChildScrollView(
        child: Column(
          children: [
            DefaultTitleWidget(title: args.title),
            SizedBox(height: 20.h),
            DefaultTextField(
              controller: args.cubit.nameController,
              hintText: args.model?.name ?? 'Name',
            ),
            DefaultTextField(
              controller: args.cubit.targetController,
              hintText: args.model?.target.toString() ?? 'Target',
              keyboardType: TextInputType.number,
            ),
            DefaultTextField(
              controller: args.cubit.currentController,
              hintText: args.model?.current.toString() ?? 'Current',
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20.h),
            DefaultAppButton(
              title: "Save",
              onTap: () {
                if (args.model == null) {
                  args.cubit.emitAddSavings();
                } else {
                  args.cubit.emitUpdateSavings(model: args.model!);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
