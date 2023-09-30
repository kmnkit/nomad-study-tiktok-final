import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:study_final/constants/routes.dart';
import 'package:study_final/features/authentication/repositories/auth_repo.dart';
import 'package:study_final/features/authentication/views/sign_in_screen.dart';
import 'package:study_final/features/authentication/views/sign_up_screen.dart';
import 'package:study_final/features/main_navigation/views/main_navigation.dart';
import 'package:study_final/features/settings/views/setting_screen.dart';

final _key = GlobalKey<NavigatorState>();

final routerProvider = Provider<GoRouter>(
  (ref) => GoRouter(
    navigatorKey: _key,
    initialLocation: RoutePath.moods,
    redirect: (context, state) {
      final isLoggedIn = ref.read(authRepo).isLoggedIn;
      print('로그인 여부: $isLoggedIn');
      if (!isLoggedIn) {
        if (state.matchedLocation == RoutePath.signIn ||
            state.matchedLocation == RoutePath.signUp) {
          return state.matchedLocation;
        }
        return RoutePath.signIn;
      }
      return state.matchedLocation;
    },
    routes: [
      ShellRoute(
          builder: (context, state, child) {
            return child;
          },
          routes: [
            GoRoute(
              path: RoutePath.signUp,
              name: RouteName.signUp,
              builder: (context, state) => const SignUpScreen(),
            ),
            GoRoute(
              path: RoutePath.signIn,
              name: RouteName.signIn,
              builder: (context, state) => const SignInScreen(),
            ),
            GoRoute(
              path: RoutePath.settings,
              name: RouteName.settings,
              builder: (context, state) => const SettingScreen(),
            ),
            GoRoute(
              path: "/:tab(moods|post)",
              name: RouteName.mainNav,
              builder: (context, state) {
                final tab = state.pathParameters['tab']!;
                return MainNavigationScreen(tab: tab);
              },
            ),
          ]),
    ],
  ),
);
