import 'package:flutter/material.dart';
import 'package:shawky/core/components/widgets/loading_widget.dart';
import 'package:shawky/core/services/navigation_service.dart';

class LoadingDialog {
  LoadingDialog._();

  static void show({bool canPop = false}) {
    showDialog(
      context: NavigationService.context,
      barrierDismissible: false,
      builder: (_) {
        return PopScope(
          canPop: canPop,
          child: const LoadingWidget(),
        );
      },
    );
  }
}
