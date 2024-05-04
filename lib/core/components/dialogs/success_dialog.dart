import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shawky/core/services/navigation_service.dart';
import 'package:shawky/core/shared/widgets/default_text.dart';

class SuccessDialog {
  SuccessDialog._();

  static void show({String? message, void Function()? onPressed}) {
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
                    CupertinoIcons.check_mark_circled,
                    color: Colors.green,
                    size: 86.sp,
                  ),
                ),
                if (message != null) ...[
                  DefaultText(
                    text: message,
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
                  text: "Ok",
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
