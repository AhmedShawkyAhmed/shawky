import 'package:shawky/core/resources/assets_manager.dart';
import 'package:shawky/core/resources/color_manger.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';


class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ColorFiltered(
        colorFilter: const ColorFilter.mode(
          ColorManager.primary,
          BlendMode.modulate,
        ),
        child: Lottie.asset(
          JsonAssets.loadingAnimations,
        ),
      ),
    );
  }
}
