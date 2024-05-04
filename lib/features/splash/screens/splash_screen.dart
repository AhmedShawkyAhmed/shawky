import 'package:shawky/core/resources/assets_manager.dart';
import 'package:shawky/core/resources/color_manger.dart';
import 'package:shawky/features/splash/cubit/splash_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SplashCubit, SplashState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: ColorManager.secondary,
          body: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Stack(
              children: [
                Positioned(
                  left: -120,
                  top: 140,
                  child: RotationTransition(
                    turns: const AlwaysStoppedAnimation(-30 / 360),
                    child: Container(
                      width: 300.w,
                      height: 60.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100.r),
                        gradient: const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.topRight,
                          colors: [
                            ColorManager.white,
                            ColorManager.primaryLight,
                            ColorManager.primary,
                            ColorManager.primaryDark,
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  right: -100,
                  top: 130,
                  child: Stack(
                    children: [
                      Container(
                        width: 200.w,
                        height: 200.w,
                        decoration: BoxDecoration(
                          color: ColorManager.white,
                          borderRadius: BorderRadius.circular(200.r),
                          gradient: const LinearGradient(
                            end: Alignment.topLeft,
                            begin: Alignment.topRight,
                            colors: [
                              ColorManager.white,
                              ColorManager.primaryLight,
                              ColorManager.primary,
                              ColorManager.primaryDark,
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        left: -5,
                        top: 25,
                        child: Container(
                          width: 200.w,
                          height: 200.w,
                          decoration: BoxDecoration(
                            color: ColorManager.secondary,
                            borderRadius: BorderRadius.circular(200.r),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Center(
                  child: Image.asset(
                    AssetsManager.logo,
                    width: 130.w,
                  ),
                ),
                Positioned(
                  right: -120,
                  bottom: 140,
                  child: RotationTransition(
                    turns: const AlwaysStoppedAnimation(-30 / 360),
                    child: Container(
                      width: 300.w,
                      height: 60.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100.r),
                        gradient: const LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.topLeft,
                          colors: [
                            ColorManager.white,
                            ColorManager.primaryLight,
                            ColorManager.primary,
                            ColorManager.primaryDark,
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: -100,
                  bottom: 60,
                  child: Stack(
                    children: [
                      Container(
                        width: 200.w,
                        height: 200.w,
                        decoration: BoxDecoration(
                          color: ColorManager.white,
                          borderRadius: BorderRadius.circular(200.r),
                          gradient: const LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.topRight,
                            colors: [
                              ColorManager.white,
                              ColorManager.primaryLight,
                              ColorManager.primary,
                              ColorManager.primaryDark,
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        left: -5,
                        top: 25,
                        child: Container(
                          width: 200.w,
                          height: 200.w,
                          decoration: BoxDecoration(
                            color: ColorManager.secondary,
                            borderRadius: BorderRadius.circular(200.r),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
