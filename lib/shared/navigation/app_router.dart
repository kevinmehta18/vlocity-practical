import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:practical/presentation/dashboard/dashboard_screen.dart';
import 'package:practical/presentation/dashboard/splash/splash_screen.dart';
import 'package:practical/presentation/dashboard/todo/add_todo_screen.dart';

import 'navigation_types.dart';
import 'routes.dart';

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

final router = GoRouter(
  navigatorKey: navigatorKey,
  initialLocation: splashRoute,
  routes: [
    createGoRoute(splashRoute, const SplashScreen()),
    createGoRoute(dashboardRoute, const DashboardScreen()),
    createGoRouteWithOptionalParams(
      addTodoRoute,
      (extra) => AddTodoScreen(data: extra),
    ),
  ],
);
