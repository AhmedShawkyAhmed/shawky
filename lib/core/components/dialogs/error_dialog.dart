import 'package:finance/core/services/navigation_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../resources/color_manger.dart';

class ErrorDialog {
  ErrorDialog._();

  static void show({
    String? message,
    void Function()? onPressed,
    bool canPop = false,
  }) {
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
                      CupertinoIcons.xmark_circle,
                      color: ColorManager.redError,
                      size: 86.sp,
                    ),
                  ),
                  if (message != null) ...[
                    Text(
                      message,
                      style: Theme.of(NavigationService.context)
                          .textTheme
                          .titleMedium,
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
                  child: Text(
                    "Ok",
                    style: Theme.of(NavigationService.context)
                        .textTheme
                        .titleMedium,
                  ),
                ),
                if (canPop)
                  TextButton(
                    onPressed: () {
                      NavigationService.pop();
                    },
                    child: Text(
                      "Back",
                      style: Theme.of(NavigationService.context)
                          .textTheme
                          .titleMedium,
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
