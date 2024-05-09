import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shawky/core/components/dialogs/warning_dialog.dart';
import 'package:shawky/core/resources/color_manger.dart';
import 'package:shawky/core/routes/arguments/profiles_arguments.dart';
import 'package:shawky/core/routes/routes_names.dart';
import 'package:shawky/core/services/navigation_service.dart';
import 'package:shawky/core/shared/widgets/default_floating_button.dart';
import 'package:shawky/core/shared/widgets/default_text.dart';
import 'package:shawky/core/shared/widgets/default_title_widget.dart';
import 'package:shawky/features/profiles/cubit/profiles_cubit.dart';
import 'package:shawky/features/profiles/widgets/profile_card.dart';

class ProfilesScreen extends StatelessWidget {
  const ProfilesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ProfilesCubit cubit = BlocProvider.of(context);
    return BlocBuilder<ProfilesCubit, ProfilesState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: ColorManager.secondary,
          floatingActionButton: DefaultFloatingButton(
            onPressed: () {
              NavigationService.pushNamed(
                Routes.addProfileScreen,
                arguments: ProfilesArguments(
                  cubit: cubit,
                  title: "Add Profile",
                ),
              );
            },
          ),
          body: Column(
            children: [
              const DefaultTitleWidget(title: "Profiles"),
              Expanded(
                child: cubit.profileList.isEmpty
                    ? Center(
                        child: DefaultText(
                          text: "No Profiles Found !",
                          textColor: ColorManager.white,
                          fontSize: 18.sp,
                        ),
                      )
                    : GridView.builder(
                        shrinkWrap: true,
                        padding: EdgeInsets.only(
                          top: 5.h,
                          bottom: 55.h,
                          left: 15.w,
                          right: 15.w,
                        ),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 1,
                          crossAxisSpacing: 20.sp,
                          mainAxisSpacing: 10.sp,
                          mainAxisExtent: 60.h,
                        ),
                        scrollDirection: Axis.vertical,
                        itemCount: cubit.profileList.length,
                        itemBuilder: (context, index) {
                          return ProfileCard(
                            model: cubit.profileList[index],
                            cubit: cubit,
                            onLongPress: () {
                              WarningDialog.show(
                                message:
                                    "Are you Sure you want to Delete this Profile ?",
                                onPressed: () {
                                  NavigationService.pop();
                                  cubit.emitDeleteProfile(
                                    profileId: cubit.profileList[index].id!,
                                  );
                                },
                              );
                            },
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
