import 'dart:async';
import 'dart:html';

import 'package:auto_route/auto_route.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web/Routing/routing.gr.dart';
import 'package:web/helper/utils/shared_pref.dart';
import 'package:web/helper/utils/utils.dart';
import 'package:web/models/response/OTPModel/otp_model.dart';
import 'package:web/models/response/get_user_model.dart';
import 'package:web/route_generator.dart';

import '../../Repository/auth_repo.dart';
import '../../models/response/ForgotPassModel/forgot_pass_model.dart';
import '../../models/response/changePasswordModel/change_pass_model.dart';
import '../../models/response/editModel/edit_model.dart';
import '../../models/response/loginModel/login_model.dart';
import '../../models/response/logoutModel/logout_model.dart';
import '../../models/response/resetPasswordModel/reset_model.dart';
import 'login_event.dart';
import 'login_state.dart';

var stored = "";

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  AuthRepo authRepo;
  Dio? dio;

  LoginBloc({required this.authRepo, this.dio}) : super(LoginState()) {
    on<GetLoginEvent>((event, emit) async {
      await _getLoginEvent(event, emit);
    });
    on<ForgotPassEvent>((event, emit) async {
      await _forgotPassEvent(event, emit);
    });
    on<GetUserDetailsEvent>((event, emit) async {
      await _getUserDetailsEvent(event, emit);
    });
    on<CheckUserEvent>((event, emit) async {
      await _checkUserEvent(event, emit);
    });
    on<OtpVerifyEvent>((event, emit) async {
      await _otpVerifyEvent(event, emit);
    });
    on<LogoutEvent>((event, emit) async {
      await _logoutEvent(event, emit);
    });
    on<ResetPassEvent>((event, emit) async {
      await _resetPassEvent(event, emit);
    });
    on<ChangePassEvent>((event, emit) async {
      await _changePassEvent(event, emit);
    });
    on<CheckStatusEvent>((event, emit) async {
      await _checkStatusEvent(event, emit);
    });
    on<ResendOptEvent>((event, emit) async {
      await _resendOptEvent(event, emit);
    });
    on<UpdateProfileEvent>((event, emit) async {
      await _updateProfileEvent(event, emit);
    });
  }

  _forgotPassEvent(ForgotPassEvent event, Emitter<LoginState> emit) async {
    debugPrint("loading before${state.onLoading}");
    emit(state.copyWith(onLoading: false, stateStatus: null));
    try {
      Map<String, dynamic> req = {};
      req['email'] = event.email.toString();
      // var email = SharedPref.setString(key: 'email', data: event.email.toString());

      ForgotPass forgotPass = await authRepo.forgotService(req, event.context!);
      debugPrint("forgot::::$forgotPass");
      if (forgotPass.status!) {
        SharedPref.setString(key: 'user-email', data: event.email.toString());
        event.context?.router.pushNamed(RoutesConst.verifyOtp);

        // Navigator.pushReplacementNamed(event.context!, RoutesConst.verifyOtp);
        showSnackBar(event.context!, forgotPass.message!);
        emit(state.copyWith(onLoading: true, stateStatus: null));
      } else {
        debugPrint("error");
      }
    } catch (e) {
      emit(state.copyWith(onLoading: true, stateStatus: null));
      debugPrint(e.toString());
    }
  }

  _resendOptEvent(ResendOptEvent event, Emitter<LoginState> emit) async {
    debugPrint("loading before${state.onLoading}");
    try {
      final String email = await SharedPref.getString(key: "user-email");

      Map<String, dynamic> req = {};
      req['email'] = email;

      ForgotPass forgotPass = await authRepo.forgotService(req, event.context!);
      debugPrint("forgot::::$forgotPass");
      if (forgotPass.status!) {
        showSnackBar(event.context!, forgotPass.message!);
      } else {
        debugPrint("error");
      }
    } catch (e) {
      emit(state.copyWith(onLoading: true, stateStatus: null));
      debugPrint(e.toString());
    }
  }

  _getUserDetailsEvent(GetUserDetailsEvent event, Emitter<LoginState> emit) async {
    try {
      GetUserModel getUserModel = await authRepo.getUserService(event.context!);
      if (getUserModel.success == true) {
        emit(state.copyWith(
            name: getUserModel.data?.name,
            date: getUserModel.data?.createdAt,
            email: getUserModel.data?.email,
            image: getUserModel.data?.photo,
            stateStatus: null));
      } else {
        Future.delayed(Duration.zero, () {
          checkStatus(event.context!);
        });
        debugPrint("error");
      }
    } catch (e) {
      checkStatus(event.context!);
      debugPrint(e.toString());
    }
  }

  _checkUserEvent(CheckUserEvent event, Emitter<LoginState> emit) async {
    try {
      final SharedPreferences preferences = await SharedPreferences.getInstance();
      preferences.remove("User-detail");
      debugPrint("pref:::::::${preferences.remove("User-detail")}");
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  _otpVerifyEvent(OtpVerifyEvent event, Emitter<LoginState> emit) async {
    emit(state.copyWith(otpLoader: false, stateStatus: null));
    try {
      final String userEmail = await SharedPref.getString(key: "user-email");
      debugPrint("userEmail===$userEmail");

      Map<String, dynamic> req = {};
      req["email"] = userEmail;
      req["otp"] = event.otp;

      OTPVerify otpVerify = await authRepo.otpService(req, event.context!);

      if (otpVerify.status!) {
        event.context?.router.pushNamed(RoutesConst.resetPass);

        // Navigator.pushReplacementNamed(event.context!, RoutesConst.resetPass);
        showSnackBar(event.context!, otpVerify.message!);
        emit(state.copyWith(otpLoader: true, stateStatus: null));
      }
    } catch (e) {
      emit(state.copyWith(otpLoader: true, stateStatus: null));
      debugPrint(e.toString());
    }
  }

  _logoutEvent(LogoutEvent event, Emitter<LoginState> emit) async {
    try {
      Logout? logout = await authRepo.logoutService();
      if (logout?.success == true) {
        final SharedPreferences preferences = await SharedPreferences.getInstance();
        preferences.remove("User-detail");
        preferences.remove("remember_me");
        preferences.remove("token");
        preferences.remove("login");
        token = "";
        document.cookie = "token=";
        // SharedPref.setString(key: "login", data: "");

        // Navigator.pushNamedAndRemoveUntil(
        //   event.context!,
        //   RoutesConst.login,
        //   (route) => false,
        // );
        // SharedPref.clear();
        // event.context?.router.removeLast()
        // event.context?.router.pushNamed('/login');
        event.context?.router.popUntilRoot();
        // event.context?.router.replaceAll([
        //   LoginRoute()
        // ]);
        event.context?.pushRoute(const LoginRoute());
        // Navigator.of(event.context!)
        //     .pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);
        // Navigator.pushNamedAndRemoveUntil(
        //     event.context!, RoutesConst.login, (route) => false);
        // showSnackBar(event.context!, logout!.message!);
        emit(state.copyWith(loading: true, stateStatus: null));
      } else {
        Future.delayed(Duration.zero, () {
          checkStatus(event.context!);
        });
        debugPrint("error");
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  _resetPassEvent(ResetPassEvent event, Emitter<LoginState> emit) async {
    try {
      final String email = await SharedPref.getString(key: "user-email");

      Map<String, dynamic> req = {};
      req["email"] = email;
      req["password"] = event.newPass;
      req["password_confirmation"] = event.confirmPass;

      ResetModel resetModel = await authRepo.resetService(req, event.context!);
      if (resetModel.status == true) {
        showSnackBar(event.context!, resetModel.message!);
        event.context?.router.pushNamed(RoutesConst.login);
        // Navigator.pushReplacementNamed(event.context!, RoutesConst.login);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  _getLoginEvent(GetLoginEvent event, Emitter<LoginState> emit) async {
    debugPrint("loading before bloc :${state.loading}");
    emit(state.copyWith(loading: false, stateStatus: null));
    try {
      Map<String, dynamic> req = {};
      req["email"] = event.email;
      req["password"] = event.password;
      req["device_token"] = event.token;

      LoginModel loginModel = await authRepo.loginService(req, event.context);

      debugPrint("modelValue:::::${loginModel.message}");
      if (loginModel.success!) {
        var token = loginModel.token;
        var androidUrl = loginModel.androidAppUrl;
        var androidVersion = loginModel.androidAppVersion;
        var iOSUrl = loginModel.iosAppUrl;
        var iOSVersion = loginModel.iosAppVersion;
        await SharedPref.setString(key: "token", data: token!);
        await SharedPref.setString(key: "android-url", data: androidUrl!);
        await SharedPref.setString(key: "android-version", data: androidVersion!);
        await SharedPref.setString(key: "ios-url", data: iOSUrl!);
        await SharedPref.setString(key: "ios-version", data: iOSVersion!);
        debugPrint("out token :::::$token");
        debugPrint("out url/version :::::$androidUrl==$androidVersion==$iOSUrl==$iOSVersion");
        stored = token;
        stored = await SharedPref.getString(
          key: "token",
        );
        emit(state.copyWith(loading: true, stateStatus: null));
        await SharedPref.setString(key: "old-password", data: event.password!);
        await SharedPref.setInt(key: "user-id", data: loginModel.data!.id!);
        await SharedPref.setString(key: "user-email", data: loginModel.data!.email!);
        await SharedPref.setString(key: "user-name", data: loginModel.data!.name!);
        await SharedPref.setString(key: "user-createdDate", data: loginModel.data!.createdAt!);
        await SharedPref.setString(key: "user-Image", data: loginModel.data!.photo!);
        await SharedPref.setString(key: "user-status", data: loginModel.data!.status!);
        await SharedPref.setBool(key: "User-detail", data: true);
        await SharedPref.setBool(key: "logout", data: false);

        document.cookie = "token=$stored";

        Future.delayed(const Duration(milliseconds: 200), () {
          showSnackBar(event.context, loginModel.message!);
          event.context.router.pushNamed(RoutesConst.homePage);
          // event.context.pushRoute( Projects());
          event.context.router.removeLast();
          // event.context.go(routeNames.goProjectPage);
          // event.context.replace('/project');
          // print("stored$stored");
          // if(stored.isNotEmpty) {
          //   Navigator.pushNamedAndRemoveUntil(event.context, RoutesConst.homePage + RoutesConst.projects, (route) => false);
          // }
        });
      } else {
        emit(state.copyWith(loading: true, stateStatus: null));
        Future.delayed(Duration.zero, () {
          showErrorSnackBar(event.context, loginModel.message!);
        });
      }
    } catch (e) {
      emit(state.copyWith(loading: true, stateStatus: null));
      debugPrint(e.toString());
    }
  }

  _changePassEvent(ChangePassEvent event, Emitter<LoginState> emit) async {
    try {
      // final String oldPass = await SharedPref.getString(key: "old-password");

      Map<String, dynamic> req = {};
      req['old_password'] = event.oldPass;
      req['password'] = event.newPass;

      ChangePass changePass = await authRepo.changePassService(req, event.context!);
      if (changePass.status!) {
        // event.context?.router.pushNamed(RoutesConst.projects);
        // event.context?.router.removeLast();
        event.context?.router.navigateBack();
        // Navigator.pushReplacementNamed(event.context!, RoutesConst.homePage + RoutesConst.projects);
        showSnackBar(event.context!, changePass.message!);
      } else {
        Future.delayed(Duration.zero, () {
          checkStatus(event.context!);
        });
        debugPrint("error");
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  _checkStatusEvent(CheckStatusEvent event, Emitter<LoginState> emit) async {
    try {
      Map<String, dynamic> req = {};

      LoginModel loginModel = await authRepo.statusCode(req, event.context!);
      if (loginModel.data!.status != "active") {
        // event.context!.router.pushNamed("/");
        // Navigator.pushNamedAndRemoveUntil(event.context!,RoutesConst.login, (route) => false);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  _updateProfileEvent(UpdateProfileEvent event, Emitter<LoginState> emit) async {
    try {
      if (event.photo == null) {
        Map<String, dynamic> req = {};
        req['name'] = event.name;
        req['type'] = 'web';
        EditModel editModel = await authRepo.editService(req, event.context);
        if (editModel.success == true) {
          event.context.router.navigateBack();
          // Future.delayed(Duration.zero, () {
          //   Navigator.pushNamedAndRemoveUntil(
          //     event.context,
          //     RoutesConst.homePage + RoutesConst.projects,
          //     (route) => false,
          //   );
          // });
          //Navigator.pop(event.context);
          await SharedPref.setString(key: "user-name", data: editModel.data!.name!);
          await SharedPref.setString(key: "user-Image", data: editModel.data!.photo!);
        }
      } else {
        Map<String, dynamic> req = {};
        req['name'] = event.name;
        req['image'] = event.photo;
        req['type'] = 'web';
        EditModel editModel = await authRepo.editService(req, event.context);
        if (editModel.success == true) {
          event.context.router.navigateBack();
          // event.context.router.pushNamed(RoutesConst.projects);
          // event.context.router.removeLast();
          // Future.delayed(Duration.zero, () {
          //   Navigator.pushNamedAndRemoveUntil(
          //     event.context,
          //     RoutesConst.homePage + RoutesConst.projects,
          //     (route) => false,
          //   );
          // });
          await SharedPref.setString(key: "user-name", data: editModel.data!.name!);
          await SharedPref.setString(key: "user-Image", data: editModel.data!.photo!);
        } else {
          Future.delayed(Duration.zero, () {
            checkStatus(event.context);
          });
          debugPrint("error");
        }
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
