import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:study_final/constants/routes.dart';
import 'package:study_final/features/settings/views/setting_screen.dart';
import 'package:study_final/home_screen.dart';

final _key = GlobalKey<NavigatorState>();

final routerProvider = Provider<GoRouter>(
  (ref) => GoRouter(
      navigatorKey: _key,
      initialLocation: RoutePath.home,
      redirect: (context, state) {
        return null;
      },
      routes: [
        GoRoute(
          path: RoutePath.home,
          name: RouteName.home,
          builder: (context, state) => const HomeScreen(),
        ),
        GoRoute(
          path: RoutePath.settings,
          name: RouteName.settings,
          builder: (context, state) => const SettingScreen(),
        )
      ]),
);
