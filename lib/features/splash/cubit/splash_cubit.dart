import 'package:bloc/bloc.dart';
import 'package:finance/core/routes/routes_names.dart';
import 'package:finance/core/services/navigation_service.dart';
import 'package:flutter/material.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(SplashInitial());

  Future init() async {
    await Future.delayed(const Duration(seconds: 1)).then((value) async {
      NavigationService.pushNamedAndRemoveUntil(
        Routes.homeScreen,
        (p0) => false,
        arguments: false,
      );
    });
  }
}
