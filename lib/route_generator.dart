import 'package:flutter/material.dart';
import 'package:web/helper/utils/shared_pref.dart';
import 'package:web/helper/utils/utils.dart';
import 'package:web/view-model/authBloc/login_bloc.dart';
import 'package:web/view/shared_widget/custom_label.dart';

String token = '';

class RoutesConst {
  // Routes Name

  static const login = '/login';
  static const splash = '/';
  static const forgot = '/forgot-password';
  static const homePage = '/home-page/';
  static const verifyOtp = '/verify-otp';
  static const resetPass = '/reset-password';
  static const changePass = '/change-password';
  static const editProfile = '/edit-profile';
  static const myProfile = "/myProfile";
  static const projectDetails = "project-details";
  static const projectInfo = "project-info";
  static const projects = "projects";
  static const reports = "reports";
  static const siteSurveyForm = "site-survey-form";
  static const viewSiteSurvey = "site-survey";
  static const punchList = "punch-list";
  static const resolvePunchList = "resolve-punch-list";
  static const contactAdmin = "contact-admin";
  static const notifications = "notifications";

  static checkLogin() async {
    // final SharedPreferences preferences = await SharedPreferences.getInstance();
    token = await SharedPref.getString(key: "login");
    stored = await SharedPref.getString(key: "token");
    print(token);
    print(stored);
    print("token");
  }

  //Router...
  static Route<dynamic> generateRoute(RouteSettings settings) {
    Map<dynamic, dynamic>? params = settings.arguments == null ? null : settings.arguments as Map;
    late Widget page;
    String routeName = '';
    String? route;
    Map? queryParameters;
    // String clicked;

    checkLogin();
    print(getCookiesData());
    Map cookies = getCookiesData();
    if (cookies.containsKey("token")) {
      token = cookies["token"];
    }
    // if(cookies.containsKey("clicked")) {
    //   clicked = cookies["clicked"];
    // }

    if (settings.name != null) {
      var uriData = Uri.parse(settings.name!);
      route = uriData.path;
      queryParameters = uriData.queryParameters;
    }
    var message = 'generateRoute: Route $route, QueryParameters $queryParameters';
    print(message);
    /* if (settings.name == splash) {
      page = const Splash();
    } else if (settings.name == login) {
      if (token.isEmpty || stored.isEmpty) {
        page = const Login();
      } else {
        page = const AutoWrapper(
          child: HomePage(),
        );
        routeName = homePage + projects;
      }
    } else if (settings.name == myProfile) {
      page = const MyProfile();
    } else if (settings.name == editProfile) {
      if (token.isNotEmpty || stored.isNotEmpty) {
        page = const EditProfile();
      } else {
        page = const Login();
        routeName = login;
      }
    } else if (settings.name == forgot) {
      if (token.isEmpty ||  stored.isEmpty ) {
        page = const ForgotPassword();
      } else {
        page = const AutoWrapper(
          child: HomePage(),
        );
        routeName = homePage + projects;
      }
    } else if (settings.name == verifyOtp) {
      page = const OTPScreen();
    } else if (settings.name == resetPass) {
      if (token.isEmpty && stored.isEmpty) {
        page = const ResetPassword();
      } else {
        page = const AutoWrapper(
          child: HomePage(),
        );
        routeName = homePage + projects;
      }
    } else if (settings.name == changePass) {
      if (token.isNotEmpty|| stored.isNotEmpty) {
        page = const ChangePassword();
      } else {
        page = const Login();
        routeName = login;
      }
    } else if (settings.name!.contains(homePage)) {
      final subRoute = settings.name!.substring(homePage.length);
      print("subRoute");
      print(subRoute);
      print(settings.name!);
      print(token.isNotEmpty || stored.isNotEmpty);
      if (token.isNotEmpty || stored.isNotEmpty) {
        if (settings.name!.contains(projects)) {
          page = const AutoWrapper(
            child: HomePage(),
          );
        } else if (settings.name!.contains(reports)) {
          page = const AutoWrapper(
            child: Reports(),
          );
        } else if (settings.name!.contains(projectDetails)) {
          var id = settings.name!.contains(RegExp(r'[0-9]'))
              ? int.parse(settings.name!.substring(settings.name!.indexOf(RegExp(r'[0-9]'))))
              : params != null && params.containsKey("id")
                  ? params["id"]
                  : 0;
          page = AutoWrapper(child: ProjectDetails(id: id));
          routeName = settings.name!.contains(id.toString()) ? settings.name! : "${settings.name!}?id=$id";
        } else if (settings.name!.contains(projectInfo)) {
          var id = settings.name!.contains(RegExp(r'[0-9]'))
              ? int.parse(settings.name!.substring(settings.name!.indexOf(RegExp(r'[0-9]'))))
              : params != null && params.containsKey("id")
                  ? params["id"]
                  : 0;
          page = AutoWrapper(child: ProjectInfo(projectId: id));
          routeName = settings.name!.contains(id.toString()) ? settings.name! : "${settings.name!}?id=$id";
        } else if (subRoute == siteSurveyForm) {
          var id = params != null && params.containsKey("projectId")
              ? params["projectId"]
              : 0;
          var reportCategoryId =  params != null && params.containsKey("reportCategoryId")
              ? params["reportCategoryId"]
              : 0;
          page = AutoWrapper(
            child: SiteSurveyFormPage(projectId: id.toString(), reportCategoryId: reportCategoryId, ),
          );
        } else if (settings.name!.contains(viewSiteSurvey)) {
          var id = settings.name!.contains(RegExp(r'[0-9]'))
              ? int.parse(settings.name!.substring(settings.name!.indexOf(RegExp(r'[0-9]'))))
              : params != null && params.containsKey("id")
                  ? params["id"]
                  : 0;
          var reportCategoryId = settings.name!.contains(RegExp(r'[0-9]'))
              ? int.parse(settings.name!.substring(settings.name!.indexOf(RegExp(r'[0-9]'))))
              : params != null && params.containsKey("reportCategoryId")
                  ? params["reportCategoryId"]
                  : 0;
          page = AutoWrapper(
              child: SiteSurveyFormPage(
            reportId: id,
            reportCategoryId: reportCategoryId,
            viewReport: true,
          ));
          routeName = settings.name!.contains(id.toString()) ? settings.name! : "${settings.name!}?id=$id";
        } else if (subRoute == punchList) {
          var id = params != null && params.containsKey("projectId")
              ? params["projectId"]
              : 0;
          page = AutoWrapper(
            child: PunchList(resolve: false, projectId: id,),
          );
        } else if (settings.name!.contains(resolvePunchList)) {
          var id = settings.name!.contains(RegExp(r'[0-9]'))
              ? int.parse(settings.name!.substring(settings.name!.indexOf(RegExp(r'[0-9]'))))
              : params != null && params.containsKey("id")
                  ? params["id"]
                  : 0;
          var punchList = params != null && params.containsKey("punchList") ? params["punchList"] : null;
          page = AutoWrapper(
            child: PunchList(resolve: true, punchList: punchList),
          );
          routeName = settings.name!.contains(id.toString()) ? settings.name! : "${settings.name!}?id=$id";
        } else {
          null;
        }
      }
      else {
        page = const Login();
        routeName = login;
      }
    } else {
      return _GeneratePageRoute(
        widget: const Scaffold(
          body: Center(child: CustomLabel(text: "Not Found.")),
        ),
        routeName: settings.name,
        queryParameters: params,
      );
    }*/

    return _GeneratePageRoute(
      // widget: page,
      widget: const Scaffold(
        body: Center(child: CustomLabel(text: "Not Found.")),
      ),
      routeName: routeName.isNotEmpty ? routeName : settings.name,
      queryParameters: params,
    );

    // switch (settings.name) {
    //   //! Splash Route
    //   case splash:
    //     return _GeneratePageRoute(widget: const Splash(), routeName: settings.name);
    //
    //   case login:
    //     return _GeneratePageRoute(
    //       widget: const Login(),
    //       routeName: settings.name,
    //     );
    //   case myProfile:
    //     return _GeneratePageRoute(
    //       widget: const MyProfile(),
    //       routeName: settings.name,
    //     );
    //
    //   //! Forgot Password
    //   case forgot:
    //     return _GeneratePageRoute(widget: const ForgotPassword(), routeName: settings.name);
    //
    //   case changePass:
    //     return _GeneratePageRoute(widget: const ChangePassword(), routeName: settings.name);
    //
    //   //! verify otp
    //   case verifyOtp:
    //     return _GeneratePageRoute(widget: const OTPScreen(), routeName: settings.name);
    //
    //   //! reset Password
    //   case resetPass:
    //     return _GeneratePageRoute(widget: const ResetPassword(), routeName: settings.name);
    //
    //   case editProfile:
    //     return _GeneratePageRoute(widget: const EditProfile(), routeName: settings.name);
    //
    // //! home Page
    //   case homePage:
    //     {
    //       return _GeneratePageRoute(widget: const AutoWrapper(child: HomePage()), routeName: settings.name);
    //     }
    //
    //   case projectDetails:
    //     var id = params != null && params.containsKey("id") ? params["id"] : 0;
    //     return _GeneratePageRoute(widget: AutoWrapper(child: ProjectDetails(id: id)), routeName: "${settings.name!}/$id");
    //
    //   case projectInfo:
    //     var id = params != null && params.containsKey("id") ? params["id"] : 0;
    //     return _GeneratePageRoute(widget: AutoWrapper(child: ProjectInfo(projectId: id)), routeName: "${settings.name!}/$id");
    //
    //   default:
    //     return _GeneratePageRoute(
    //       widget: const Scaffold(
    //         body: Center(child: CustomLabel(text: "Not Found.")),
    //       ),
    //       routeName: settings.name,
    //     );
    // }
  }
}

class _GeneratePageRoute extends PageRouteBuilder {
  final Widget widget;
  final String? routeName;
  final Map? queryParameters;
  final bool isAction;

  _GeneratePageRoute({
    required this.widget,
    required this.routeName,
    required this.queryParameters,
    this.isAction = false,
  }) : super(
          settings: RouteSettings(name: routeName, arguments: queryParameters),
          pageBuilder: (
            BuildContext context,
            _,
            __,
          ) {
            return widget;
          },
        );
}
