import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:shawky/core/resources/assets_manager.dart';
import 'package:shawky/core/resources/color_manger.dart';

class ProfileQr extends StatelessWidget {
  final String link;
  final String type;

  const ProfileQr({
    super.key,
    required this.link,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350.w,
      height: 350.w,
      margin: EdgeInsetsDirectional.all(15.w),
      decoration: BoxDecoration(
        color: ColorManager.white,
        borderRadius: BorderRadius.circular(15.r),
      ),
      child: QrImageView(
        data: link,
        version: QrVersions.min,
        size: 100.sp,
        embeddedImage: AssetImage(
            "${AssetsManager.imagePath}${AssetsManager.profileDir}/$type.png"),
        embeddedImageStyle: QrEmbeddedImageStyle(
          size: Size(80.sp, 80.sp),
        ),
      ),
    );
  }
}
