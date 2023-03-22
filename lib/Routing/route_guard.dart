import 'package:auto_route/auto_route.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web/Routing/routing.gr.dart';
import 'package:web/helper/utils/shared_pref.dart';

import '../route_generator.dart';

class RouteGuard extends AutoRedirectGuard {
  final Future<SharedPreferences> _preferences = SharedPreferences.getInstance();

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) async {
    final SharedPreferences preferences = await _preferences;

    print(preferences.getBool("User-detail"));
    print(preferences.getString("login"));
    print(router.currentPath);

    // if (((router.current.name == "LoginRoute" || router.current.name == "HomeRouter") && preferences.getBool("User-detail") == null) ||
    //     (router.current.name != "LoginRoute" &&
    //         router.current.name != "HomeRouter" &&
    //         router.current.name != "Root" &&
    //         preferences.getBool("User-detail") != null) ||
    //     ((router.current.name == "Root" || router.current.name == "HomeRouter") &&
    //         preferences.getString("login") == null &&
    //         preferences.getBool("logout") != true) ||
    //     ((router.current.name == "HomeRouter" || router.current.name == "Root") &&
    //         preferences.getBool("User-detail") != null &&
    //         preferences.getBool("User-detail")! &&
    //         preferences.getString("login") == "login")) {

    if (router.currentPath == RoutesConst.splash ||
        router.currentPath == RoutesConst.forgot ||
        router.currentPath == RoutesConst.verifyOtp ||
        router.currentPath == RoutesConst.resetPass) {
      return resolver.next();
    } else if (router.currentPath == RoutesConst.login) {
      if (preferences.getBool("User-detail") == null) {
        return resolver.next();
      } else {
        await SharedPref.setBool(key: "User-detail", data: true);
        router.push(const Projects());
      }
    } else if (router.currentPath.contains(RoutesConst.homePage)) {
      if (preferences.getBool("User-detail") != null || preferences.getBool("logout") != true) {
        return resolver.next();
      } else {
        await preferences.remove("User-detail");
        return resolver.next(false);
        // router.push(LoginRoute());
      }
    } else if (router.currentPath == RoutesConst.changePass && preferences.getBool("logout") != true) {
      return resolver.next();
    } else if (router.currentPath == RoutesConst.editProfile && preferences.getBool("logout") != true) {
      return resolver.next();
    } else {
      router.pushNamed(RoutesConst.login);
      // return resolver.next();
    }
    // } else {
    //   if ((router.current.name == "LoginRoute" && preferences.getString("login") == null) || preferences.getString("login") == null) {
    //     router.push(const LoginRoute());
    //   } else {
    //     await SharedPref.setBool(key: "User-detail", data: true);
    //     if (router.currentPath == "/login" || router.currentPath == "/home-page/projects") {
    //       router.push(const Projects());
    //     } else {
    //       return resolver.next();
    //     }
    //   }
    // }
    // if (preferences.getString("login") == null) return resolver.next();
    // router.push(const HomeRouter());
    // preferences.getBool("remember_me") == true ? router.push(const HomeRoute()) : router.push(const LoginRoute());
  }

// router.pushNamed("/home-page/projects");
  // preferences.getBool("remember_me") == true ? router.push(const HomeRoute()) : router.push(const LoginRoute());

  @override
  Future<bool> canNavigate(RouteMatch route) {
    return Future.value(true);
  }
}
