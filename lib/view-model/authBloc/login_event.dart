import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

@immutable
abstract class LoginEvent extends Equatable {
  const LoginEvent();
}

class GetLoginEvent extends LoginEvent {
  final String? email;
  final String? password;
  final String? token;
  final BuildContext context;

  const GetLoginEvent({this.email, this.password, this.token, required this.context});

  @override
  List<Object?> get props => [];
}

class UpdateProfileEvent extends LoginEvent {
  final String? name;
  final String? photo;
  final BuildContext context;

  const UpdateProfileEvent({this.name, this.photo, required this.context});

  @override
  List<Object?> get props => [];
}

class ForgotPassEvent extends LoginEvent {
  final String? email;
  final BuildContext? context;

  const ForgotPassEvent({this.email, this.context});

  @override
  List<Object?> get props => [];
}

class ResendOptEvent extends LoginEvent {
  final String? email;
  final BuildContext? context;

  const ResendOptEvent({this.email, this.context});

  @override
  List<Object?> get props => [];
}

class OtpVerifyEvent extends LoginEvent {
  final String? otp;
  final BuildContext? context;

  const OtpVerifyEvent({this.otp, this.context});

  @override
  List<Object?> get props => [];
}

class GetUserDetailsEvent extends LoginEvent {
  final BuildContext? context;

  const GetUserDetailsEvent({this.context});

  @override
  List<Object?> get props => [];
}

class CheckUserEvent extends LoginEvent {
  final BuildContext? context;

  const CheckUserEvent({this.context});

  @override
  List<Object?> get props => [];
}

class LogoutEvent extends LoginEvent {
  final BuildContext? context;

  const LogoutEvent({
    this.context,
  });

  @override
  List<Object?> get props => [];
}

class CheckStatusEvent extends LoginEvent {
  final BuildContext? context;

  const CheckStatusEvent({this.context});

  @override
  List<Object?> get props => [];
}

class ResetPassEvent extends LoginEvent {
  final BuildContext? context;
  final String? newPass;
  final String? confirmPass;

  const ResetPassEvent({
    this.newPass,
    this.confirmPass,
    this.context,
  });

  @override
  List<Object?> get props => [];
}

class ChangePassEvent extends LoginEvent {
  final BuildContext? context;
  final String? newPass;
  final String? oldPass;

  const ChangePassEvent({this.newPass, this.context, this.oldPass});

  @override
  List<Object?> get props => [];
}
