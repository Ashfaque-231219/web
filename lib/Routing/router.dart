import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:web/Routing/auto_wrapper.dart';
import 'package:web/helper/constants/routes_names.dart';
import 'package:web/helper/utils/shared_pref.dart';
import 'package:web/view/screens/auth/change_pass_pass.dart';
import 'package:web/view/screens/auth/forgot_pass.dart';
import 'package:web/view/screens/auth/login_page.dart';
import 'package:web/view/screens/auth/reset_pass_screen.dart';
import 'package:web/view/screens/auth/splash_screen.dart';
import 'package:web/view/screens/dashboard/home_page.dart';
import 'package:web/view/screens/website_wrapper_page.dart';

import '../view/screens/project_details/project_details.dart';

class AppRoute {
  final SharedPref loginState;

  AppRoute(this.loginState);

  // late final router = GoRouter(
  //   debugLogDiagnostics: true,
  //   routes: <GoRoute>[
  //     GoRoute(
  //       path: '/',
  //       builder: (BuildContext context, GoRouterState state) => const Splash(),
  //       routes: <GoRoute>[
  //         GoRoute(
  //           path: '/login',
  //           builder: (BuildContext context,
  //               GoRouterState state) => const LogoScreen(),
  //         ),
  //         GoRoute(
  //           path: '/home-page',
  //           builder: (BuildContext context,
  //               GoRouterState state) => const HomePage(),
  //         ),
  //       ],
  //     ),
  //   ],
  // );

  late final router = GoRouter(
      // refreshListenable: loginState,
      debugLogDiagnostics: true,
      // urlPathStrategy: UrlPathStrategy.hash,
      initialLocation: routeNames.goSplash,
      routes: [
        ShellRoute(
          builder: (context, state, child) {
            return WebsiteWrapperPage(
              child: child,
            );
          },
          routes: [
            GoRoute(
              name: 'Splash',
              path: routeNames.goSplash,
              pageBuilder: (context, state) => MaterialPage<void>(
                key: state.pageKey,
                child: const Splash(),
              ),
            ),
            GoRoute(
              name: 'Login',
              path: routeNames.goLoginPage,
              pageBuilder: (context, state) => MaterialPage<void>(
                key: state.pageKey,
                child: const Login(),
              ),
            ),
            GoRoute(
              name: 'ForgotPassword',
              path: routeNames.goForgotPasswordPage,
              pageBuilder: (context, state) => MaterialPage<void>(
                key: state.pageKey,
                child: const ForgotPassword(),
              ),
            ),
            GoRoute(
              name: 'ChangePassword',
              path: routeNames.goChangePasswordPage,
              pageBuilder: (context, state) => MaterialPage<void>(
                key: state.pageKey,
                child: const ChangePassword(),
              ),
            ),
            GoRoute(
              name: 'ResetPassword',
              path: routeNames.goResetPasswordPage,
              pageBuilder: (context, state) => MaterialPage<void>(
                key: state.pageKey,
                child: const ResetPassword(),
              ),
            )
          ],
        ),
        ShellRoute(
          builder: (context, state, child) {
            return const AutoWrapper();
          },
          routes: [
            GoRoute(
              name: 'HomePage',
              path: routeNames.goProjectPage,
              pageBuilder: (context, state) {
                return MaterialPage<void>(
                  key: state.pageKey,
                  child: const HomePage(),
                );
              },
            ),
            GoRoute(
              name: 'ProjectsDetails',
              path: /*routeNames.goProjectDetailPage*/'/home-page/project-details',
              pageBuilder: (context, state) {
                var id = state.params['id']!;
                return MaterialPage<void>(
                  key: state.pageKey,
                  child: const ProjectDetails(id: 1),
                );
              },
            )
          ],
        )
      ],
      redirect: (context, state) async {
        final publicRoutes = [
          state.namedLocation('Splash'),
          state.namedLocation('Login'),
          state.namedLocation('ForgotPassword'),
        ];

        final homeRoutes = [
          state.namedLocation('HomePage'),
          state.namedLocation('ProjectsDetails'),
        ];

        var currentRoute = state.subloc;

        debugPrint("========================");
        debugPrint(currentRoute.toString());
        debugPrint("========================");

        final loginRoute = state.namedLocation('Login');
        var homeScreen = loginRoute;

        var user = await SharedPref.getBool(key: "User-detail");
        if (user) {
          if (publicRoutes.contains(currentRoute)) {
            return homeScreen;
          } else if (homeRoutes.contains(currentRoute) || homeRoutes.contains(currentRoute)) {
            return null;
          }
        } else {
          if (publicRoutes.contains(currentRoute)) {
            return null;
          } else {
            return loginRoute;
          }
        }
        return null;
      });
}
