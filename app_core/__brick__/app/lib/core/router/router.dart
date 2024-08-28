import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

DateTime? currentBackPressTime;

class NavigationService {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
}

String initialPath = './';
final GoRouter router = GoRouter(
  navigatorKey: NavigationService.navigatorKey,
  initialLocation: initialPath,
  routes: [],
);
