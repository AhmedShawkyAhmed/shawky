import 'package:finance/core/services/navigation_service.dart';
import 'package:finance/core/shared/widgets/default_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../resources/color_manger.dart';

class WarningDialog {
  WarningDialog._();

  static void show({
    String? message,
    void Function()? onPressed,
  })  {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showDialog(
        context: NavigationService.context,
        builder: (_) {
          return PopScope(
            canPop: false,
            child: AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Icon(
                      Icons.warning_amber_rounded,
                      color: ColorManager.redError,
                      size: 50.sp,
                    ),
                  ),
                  if (message != null) ...[
                    DefaultText(
                      text: message,
                      maxLines: 5,
                      align: TextAlign.center,
                    ),
                  ]
                ],
              ),
              actionsAlignment: MainAxisAlignment.spaceBetween,
              actions: [
                TextButton(
                  onPressed: onPressed ??
                      () {
                        NavigationService.pop();
                      },
                  child: const DefaultText(
                    text: "Yes",
                  ),
                ),
                TextButton(
                  onPressed: () {
                    NavigationService.pop();
                  },
                  child: const DefaultText(
                    text: "Cancel",
                  ),
                ),
              ],
            ),
          );
        },
      );
    });
  }
}
