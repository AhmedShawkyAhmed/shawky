import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shawky/core/resources/color_manger.dart';
import 'package:shawky/core/routes/arguments/profiles_arguments.dart';
import 'package:shawky/core/shared/widgets/default_app_button.dart';
import 'package:shawky/core/shared/widgets/default_drop_down_menu.dart';
import 'package:shawky/core/shared/widgets/default_text_field.dart';
import 'package:shawky/core/shared/widgets/default_title_widget.dart';
import 'package:shawky/core/utils/enums.dart';
import 'package:shawky/core/utils/extensions.dart';

class AddProfileScreen extends StatelessWidget {
  final ProfilesArguments args;

  const AddProfileScreen({super.key, required this.args});

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
              controller: args.cubit.linkController,
              hintText: args.model?.link ?? 'Link',
              keyboardType: TextInputType.url,
            ),
            DefaultDropdown<ProfileType>(
              items: args.cubit.profileTypeList,
              hint: "Profile Type",
              selectedItem: args.model?.type ?? args.cubit.profileType,
              itemAsString: (ProfileType? u) => u!.name.toCapitalized(),
              onChanged: args.cubit.changeProfileType,
            ),
            SizedBox(height: 20.h),
            DefaultAppButton(
              title: "Save",
              onTap: () {
                if (args.model == null) {
                  args.cubit.emitAddProfile();
                } else {
                  args.cubit.emitUpdateProfile(model: args.model!);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
