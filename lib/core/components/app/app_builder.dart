import 'package:shawky/core/components/app/version_widget.dart';
import 'package:flutter/material.dart';

Widget defaultAppBuilder(BuildContext context, Widget? child) {
  return SafeArea(
    top: true,
    child: Column(
      children: [
        Expanded(child: child ?? const SizedBox()),
        const VersionWidget(),
      ],
    ),
  );
}
