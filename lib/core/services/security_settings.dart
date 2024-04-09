import 'dart:io';
import 'package:finance/core/utils/shared_functions.dart';
import 'package:flutter/services.dart';

class SecuritySettings {
  static const MethodChannel _channel = MethodChannel('security_settings');

  static Future<void> openSettings()async {
    if(Platform.isAndroid){
      await _openSecuritySettings();
    }else{
      await _openLockScreenSettings();
    }
  }

  static Future<void> _openSecuritySettings() async {
    try {
      await _channel.invokeMethod('openSecuritySettings');
    } on PlatformException catch (e) {
      printError("Failed to open security settings: '${e.message}'.");
    }
  }
  static Future<void> _openLockScreenSettings() async {
    try {
      await _channel.invokeMethod('openLockScreenSettings');
    } on PlatformException catch (e) {
      printError("Failed to open lock screen settings: '${e.message}'.");
    }
  }
}
