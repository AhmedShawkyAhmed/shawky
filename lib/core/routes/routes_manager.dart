import 'package:finance/core/components/app/error_screen.dart';
import 'package:finance/core/routes/routes_names.dart';
import 'package:finance/core/utils/shared_functions.dart';
import 'package:finance/features/home/cubit/home_cubit.dart';
import 'package:finance/features/home/screens/home_screen.dart';
import 'package:finance/features/money/cubit/money_cubit.dart';
import 'package:finance/features/money/screens/money_home_screen.dart';
import 'package:finance/features/splash/cubit/splash_cubit.dart';
import 'package:finance/features/splash/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    printLog("Route ${settings.name}");
    switch (settings.name) {
      case Routes.splashRoute:
        return MaterialPageRoute(
          settings: const RouteSettings(name: Routes.splashRoute),
          builder: (_) =>
              BlocProvider(
                create: (context) =>
                SplashCubit()
                  ..init(),
                child: const SplashScreen(),
              ),
        );
      case Routes.errorScreen:
        return MaterialPageRoute(
          settings: const RouteSettings(name: Routes.errorScreen),
          builder: (_) => const ErrorScreen(),
        );
      case Routes.homeScreen:
        return MaterialPageRoute(
          settings: const RouteSettings(name: Routes.homeScreen),
          builder: (_) =>
              BlocProvider(
                create: (context) => HomeCubit(),
                child: const HomeScreen(),
              ),
        );
      case Routes.moneyHomeScreen:
        return MaterialPageRoute(
          settings: const RouteSettings(name: Routes.moneyHomeScreen),
          builder: (_) =>
              BlocProvider(
                create: (context) => MoneyCubit(),
                child: const MoneyHomeScreen(),
              ),
        );
      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: "unDefinedRoute"),
      builder: (_) =>
          Scaffold(
            appBar: AppBar(
              title: const Text("No Route Found"),
            ),
            body: const Center(child: Text("No Route Found")),
          ),
    );
  }
}
