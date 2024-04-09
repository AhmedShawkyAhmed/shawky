import 'package:finance/core/routes/routes_manager.dart';
import 'package:finance/core/routes/routes_names.dart';
import 'package:finance/core/services/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'app_builder.dart';

class MyApp extends StatefulWidget {
  const MyApp._internal();

  static const MyApp _instance = MyApp._internal();

  factory MyApp() => _instance;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark,
      ),
    );
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          builder: defaultAppBuilder,
          navigatorKey: NavigationService.navigatorKey,
          debugShowCheckedModeBanner: false,
          onGenerateRoute: RouteGenerator.getRoute,
          initialRoute: Routes.splashRoute,
          title: 'Finance',
        );
      },
    );
  }
}
