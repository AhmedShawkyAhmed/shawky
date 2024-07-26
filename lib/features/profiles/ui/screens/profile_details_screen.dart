import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shawky/core/resources/color_manger.dart';
import 'package:shawky/core/routes/arguments/profiles_arguments.dart';
import 'package:shawky/core/shared/widgets/default_title_widget.dart';
import 'package:shawky/features/profiles/ui/widgets/profile_card.dart';
import 'package:shawky/features/profiles/ui/widgets/profile_qr.dart';

class ProfileDetailsScreen extends StatelessWidget {
  final ProfilesArguments args;

  const ProfileDetailsScreen({super.key, required this.args});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.secondary,
      body: SingleChildScrollView(
        child: Column(
          children: [
            DefaultTitleWidget(title: args.title),
            SizedBox(height: 20.h),
            Padding(
              padding: EdgeInsetsDirectional.symmetric(horizontal: 15.w),
              child: ProfileCard(
                model: args.model!,
                cubit: args.cubit,
                canEdit: false,
                onLongPress: () {},
              ),
            ),
            SizedBox(height: 40.h),
            ProfileQr(
              link: args.model!.link,
              type: args.model!.type.name.toLowerCase(),
            ),
          ],
        ),
      ),
    );
  }
}
