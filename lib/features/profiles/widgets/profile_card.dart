import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shawky/core/resources/assets_manager.dart';
import 'package:shawky/core/resources/color_manger.dart';
import 'package:shawky/core/routes/arguments/profiles_arguments.dart';
import 'package:shawky/core/routes/routes_names.dart';
import 'package:shawky/core/services/navigation_service.dart';
import 'package:shawky/core/shared/widgets/default_text.dart';
import 'package:shawky/core/utils/shared_functions.dart';
import 'package:shawky/features/profiles/cubit/profiles_cubit.dart';
import 'package:shawky/features/profiles/models/profile_model.dart';

class ProfileCard extends StatelessWidget {
  final ProfileModel model;
  final VoidCallback onLongPress;
  final ProfilesCubit cubit;
  final bool canEdit;

  const ProfileCard({
    super.key,
    required this.model,
    required this.onLongPress,
    required this.cubit,
    this.canEdit = true,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        NavigationService.pushNamed(
          Routes.profileDetailsScreen,
          arguments: ProfilesArguments(
            cubit: cubit,
            title: "Profile Details",
            model: model,
          ),
        );
      },
      onLongPress: () {
        onLongPress();
        WidgetsBinding.instance.reassembleApplication();
      },
      child: Container(
        padding:
            EdgeInsetsDirectional.symmetric(horizontal: 15.w, vertical: 5.h),
        decoration: BoxDecoration(
          color: ColorManager.white,
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 50.w,
              height: 50.w,
              child: Image.asset(
                "${AssetsManager.imagePath}${AssetsManager.profileDir}/${model.type.name.toLowerCase()}.png",
              ),
            ),
            SizedBox(width: 8.w),
            DefaultText(
              text: model.name,
            ),
            const Spacer(),
            if (canEdit) ...[
              GestureDetector(
                onTap: () {
                  NavigationService.pushNamed(
                    Routes.addProfileScreen,
                    arguments: ProfilesArguments(
                      cubit: cubit,
                      title: "Edit Profile",
                      model: model,
                    ),
                  );
                },
                child: Icon(
                  Icons.edit,
                  color: ColorManager.secondary,
                  size: 20.sp,
                ),
              ),
            ] else ...[
              GestureDetector(
                onTap: () async {
                  await Clipboard.setData(
                    ClipboardData(text: model.link),
                  );
                  showMyToast(message: "Profile Link Copied");
                },
                child: Container(
                  width: 50.w,
                  height: 50.w,
                  decoration: BoxDecoration(
                    color: ColorManager.primaryFaded,
                    borderRadius: BorderRadius.circular(100.r)
                  ),
                  child: Icon(
                    Icons.share_outlined,
                    color: ColorManager.white,
                    size: 30.sp,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
