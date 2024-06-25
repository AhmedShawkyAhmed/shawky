import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shawky/core/resources/color_manger.dart';
import 'package:shawky/core/resources/globals.dart';
import 'package:shawky/core/shared/widgets/default_app_button.dart';
import 'package:shawky/core/shared/widgets/default_text_field.dart';
import 'package:shawky/core/shared/widgets/default_title_widget.dart';
import 'package:shawky/features/settings/cubit/settings_cubit.dart';

class AddSettingsScreen extends StatefulWidget {
  const AddSettingsScreen({
    super.key,
  });

  @override
  State<AddSettingsScreen> createState() => _AddSettingsScreenState();
}

class _AddSettingsScreenState extends State<AddSettingsScreen> {
  SettingsCubit cubit = SettingsCubit();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => cubit,
      child: BlocBuilder<SettingsCubit, SettingsState>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: ColorManager.secondary,
            body: SingleChildScrollView(
              child: Column(
                children: [
                  const DefaultTitleWidget(title: "Settings"),
                  SizedBox(height: 20.h),
                  DefaultTextField(
                    controller: cubit.nameController,
                    hintText: Globals.settings?.name ?? 'Name',
                  ),
                  DefaultTextField(
                    controller: cubit.titleController,
                    hintText: Globals.settings?.title ?? 'Title',
                  ),
                  DefaultTextField(
                    controller: cubit.rateController,
                    hintText: Globals.settings?.rate.toString() ?? 'Rate',
                    keyboardType: TextInputType.number,
                  ),
                  DefaultTextField(
                    controller: cubit.goldController,
                    hintText: Globals.settings?.gold.toString() ?? 'Gold',
                    keyboardType: TextInputType.number,
                  ),
                  SizedBox(height: 20.h),
                  DefaultAppButton(
                    title: "Save",
                    onTap: () {
                      if (Globals.settings == null) {
                        cubit.emitAddSettings();
                      } else {
                        cubit.emitUpdateSettings(model: Globals.settings!);
                      }
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
