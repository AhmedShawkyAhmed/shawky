import 'package:flutter/material.dart';

class NavigationService {
  static final NavigationService _instance = NavigationService._internal();

  factory NavigationService._internal() => _instance;

  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  static BuildContext get context => navigatorKey.currentContext!;

  static Future<dynamic> pushNamed(String routeName, {Object? arguments}) {
    return navigatorKey.currentState!.pushNamed(
      routeName,
      arguments: arguments,
    );
  }

  static Future<dynamic> pushReplacementNamed(String routeName,
      {Object? arguments}) {
    return navigatorKey.currentState!.pushReplacementNamed(
      routeName,
      arguments: arguments,
    );
  }

  static Future<dynamic> pushNamedAndRemoveUntil(
    String routeName,
    bool Function(Route<dynamic>) predicate, {
    Object? arguments,
  }) {
    return navigatorKey.currentState!.pushNamedAndRemoveUntil(
      routeName,
      predicate,
      arguments: arguments,
    );
  }

  static Future<dynamic> push(Widget screen) {
    return navigatorKey.currentState!.push(
      MaterialPageRoute(builder: (context) => screen),
    );
  }

  static Future<dynamic> pushReplacement(Widget screen) {
    return navigatorKey.currentState!.pushReplacement(
      MaterialPageRoute(builder: (context) => screen),
    );
  }

  static Future<dynamic> pushAndRemoveUntil(
      Widget screen, bool Function(Route<dynamic>) predicate) {
    return navigatorKey.currentState!.pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => screen),
      predicate,
    );
  }

  static Future<dynamic> popAndPushNamed(String routeName,
      {Object? arguments}) {
    return navigatorKey.currentState!.popAndPushNamed(
      routeName,
      arguments: arguments,
    );
  }

  static void popUntil(bool Function(Route<dynamic>) predicate) {
    return navigatorKey.currentState!.popUntil(predicate);
  }

  static void pop([dynamic result]) async {
    await Future.delayed(
      const Duration(milliseconds: 0),
      () => navigatorKey.currentState!.pop(result),
    );
  }
}
