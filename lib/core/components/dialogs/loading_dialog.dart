
import 'package:finance/core/components/widgets/loading_widget.dart';
import 'package:finance/core/services/navigation_service.dart';
import 'package:flutter/material.dart';

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
