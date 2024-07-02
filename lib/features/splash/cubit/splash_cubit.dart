import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:shawky/core/components/dialogs/error_dialog.dart';
import 'package:shawky/core/routes/routes_names.dart';
import 'package:shawky/core/services/navigation_service.dart';
import 'package:shawky/core/services/security_settings.dart';
import 'package:shawky/core/utils/shared_functions.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(SplashInitial());

  Future init() async {
    await authenticateUser();
  }

  final LocalAuthentication auth = LocalAuthentication();

  Future<bool> authenticate() async {
    bool isAuthorized = false;
    final List<BiometricType> availableBiometrics =
        await auth.getAvailableBiometrics();
    if (availableBiometrics.isNotEmpty) {
      if (availableBiometrics.contains(BiometricType.strong) ||
          availableBiometrics.contains(BiometricType.face) ||
          availableBiometrics.contains(BiometricType.fingerprint)) {
        printLog("availableBiometrics $availableBiometrics");
      }
      isAuthorized = await auth.authenticate(
        localizedReason: 'برجاء المصادقة لتسجيل الدخول!',
        options: const AuthenticationOptions(
          useErrorDialogs: true,
          stickyAuth: false,
        ),
      );
    } else {
      ErrorDialog.show(
        message: "برجاء اضافة بصمة بيومترية للهاتف",
        canPop: true,
        onPressed: () {
          SecuritySettings.openSettings();
        },
      );
    }
    return isAuthorized;
  }

  Future authenticateUser() async {
    var authenticated = true;//await authenticate();
    if (authenticated) {
      await Future.delayed(const Duration(milliseconds: 500)).then((value) async {
        NavigationService.pushNamedAndRemoveUntil(
          Routes.homeScreen,
          (p0) => false,
          arguments: false,
        );
      });
    }
  }
}
