import 'package:finance/core/resources/color_manger.dart';
import 'package:finance/core/services/navigation_service.dart';
import 'package:finance/core/shared/models/home_item_model.dart';
import 'package:finance/core/shared/widgets/default_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DefaultItemCardWidget extends StatelessWidget {
  final DefaultItemModel model;

  const DefaultItemCardWidget({
    required this.model,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        NavigationService.pushNamed(model.route);
      },
      child: Container(
        padding: EdgeInsetsDirectional.all(10.sp),
        decoration: BoxDecoration(
          color: ColorManager.white,
          borderRadius: BorderRadius.circular(15.r),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsetsDirectional.only(top: 6.h),
              child: Icon(
                model.icon,
                color: ColorManager.secondary,
                size: 60.sp,
              ),
            ),
            Row(
              children: [
                DefaultText(
                  text: model.title,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
