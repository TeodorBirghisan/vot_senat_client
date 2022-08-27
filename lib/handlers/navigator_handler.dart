import 'package:flutter/material.dart';

class NavigatorHandler {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey();
  NavigatorHandler._internal();

  static final NavigatorHandler instance = NavigatorHandler._internal();

  Future<dynamic> pushNamedAndRemoveUntil(String path, bool Function(Route<dynamic>) predicate) {
    return navigatorKey.currentState!.pushNamedAndRemoveUntil(path, predicate);
  }
}
