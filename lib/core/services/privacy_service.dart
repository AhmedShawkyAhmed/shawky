import 'package:flutter/material.dart';
import 'package:privacy_screen/privacy_screen.dart';

class PrivacyService {
  static final PrivacyService _privacyService = PrivacyService._internal();

  factory PrivacyService() {
    return _privacyService;
  }

  PrivacyService._internal();

  static Future<void> init() async {
    await PrivacyScreen.instance.enable(
      iosOptions: const PrivacyIosOptions(
        enablePrivacy: true,
        autoLockAfterSeconds: 120,
        lockTrigger: IosLockTrigger.didEnterBackground,
      ),
      androidOptions: const PrivacyAndroidOptions(
        enableSecure: true,
        autoLockAfterSeconds: 120,
      ),
      backgroundColor: Colors.white.withOpacity(0),
      blurEffect: PrivacyBlurEffect.light,
    );
  }
}
