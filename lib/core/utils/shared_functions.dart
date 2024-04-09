import 'dart:async';
import 'dart:developer';

import 'package:finance/core/resources/color_manger.dart';
import 'package:finance/core/services/navigation_service.dart';
import 'package:finance/core/shared/widgets/default_text.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart'
    as permission_handler;

import 'package:url_launcher/url_launcher.dart';

String concatenateListOfStrings(List<String> listOfString) {
  var concatenate = StringBuffer();

  if (listOfString.isEmpty) return "";

  for (var item in listOfString) {
    concatenate.write(item);
    concatenate.write('\n');
  }

  return concatenate.toString();
}

showToast({
  required String message,
  required bool success,
}) {
  final SnackBar snackBar;
  snackBar = SnackBar(
    content: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Icon(
          success ? Icons.check_circle : Icons.error,
          color: ColorManager.primary,
        ),
        const SizedBox(
          width: 8,
        ),
        Expanded(child: DefaultText(text:message)),
      ],
    ),
  );
  ScaffoldMessenger.of(NavigationService.context).showSnackBar(snackBar);
}

int convertDateTimeToTimestamp(DateTime dt) {
  int myTimeStamp = dt.millisecondsSinceEpoch ~/ (1000);
  log("++myTimeStamp $myTimeStamp");
  return myTimeStamp;
}

Future<permission_handler.PermissionStatus> getLocationPermission() async {
  permission_handler.PermissionStatus permissionStatus =
      await permission_handler.Permission.location.request();
  return permissionStatus;
}

bool get isPortrait =>
    MediaQuery.of(NavigationService.context).orientation ==
    Orientation.portrait;

enum LinkType { phone, email, location, other, none }

Future launchURL(String urlLink, {LinkType? type}) async {
  String url = urlLink;
  LaunchMode mode = LaunchMode.externalApplication;
  switch (type) {
    case LinkType.none:
      return;
    case LinkType.phone:
      url = 'tel:$url';
      break;
    case LinkType.email:
      url = 'mailto:$url';
      break;
    case LinkType.location:
      url = 'https://www.google.com/maps/search/?api=1&query=$url';
      break;
    case LinkType.other:
      mode = LaunchMode.externalNonBrowserApplication;
      break;
    default:
      if (await canLaunchUrl(Uri.parse(url))) {
        break;
      } else if (await canLaunchUrl(Uri.parse('https://$url'))) {
        url = 'https://$url';
      }
  }
  if (await canLaunchUrl(Uri.parse(url))) {
    await launchUrl(Uri.parse(url), mode: mode);
  } else {
    showToast(message: "Internal Server Error", success: false);
  }
}

void resetPreferredOrientations() async {
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);
}

String checkMobileNumber(String? text) {
  String mobile = "";
  if (text != null && text.isNotEmpty) {
    if (text.substring(0, 1) == "0") {
      mobile = text.substring(1, text.length);
    } else {
      mobile = text;
    }
  }

  return mobile;
}

void printResponse(Object? object) {
  String text = "$object";
  if (kDebugMode) {
    debugPrint('\x1B[33m$text\x1B[0m');
  }
}

void printSuccess(Object? object) {
  String text = "$object";
  if (kDebugMode) {
    debugPrint('\x1B[32m$text\x1B[0m');
  }
}

void printError(Object? object) {
  String text = "$object";
  if (kDebugMode) {
    debugPrint('\x1B[31m$text\x1B[0m');
  }
}

void printLog(Object? object) {
  String text = "$object";
  if (kDebugMode) {
    debugPrint('\x1B[34m$text\x1B[0m');
  }
}
