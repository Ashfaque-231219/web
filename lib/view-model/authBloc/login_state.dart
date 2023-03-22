import '../../models/response/loginModel/login_model.dart';

class LoginState {
  final bool? successMsg;
  final String? name;
  final String? email;
  final String? createdAt;
  final LoginModel? loginModel;
  final bool? loading;
  final bool? onLoading;
  final bool? otpLoader;
  final bool? resetLoader;
  final String? images;
  final String? date;
  final String? image;

  LoginState(
      {this.successMsg,
      this.loginModel,
      this.name,
      this.email,
      this.createdAt,
      this.loading = true,
      this.onLoading = true,
      this.otpLoader = true,
      this.resetLoader = true,
      this.images,
      this.date,
      this.image});

  LoginState copyWith({
    final bool? successMsg,
    final LoginModel? loginModel,
    final String? name,
    final String? email,
    final String? date,
    final String? image,
    final String? createdAt,
    final bool? loading,
    final bool? onLoading,
    final bool? otpLoader,
    final bool? resetLoader,
    final String? images,
    required stateStatus,
  }) {
    return LoginState(
        successMsg: successMsg ?? this.successMsg,
        loginModel: loginModel ?? this.loginModel,
        name: name ?? this.name,
        email: email ?? this.email,
        createdAt: createdAt ?? this.createdAt,
        loading: loading ?? this.loading,
        onLoading: onLoading ?? this.onLoading,
        otpLoader: otpLoader ?? this.otpLoader,
        resetLoader: resetLoader ?? this.resetLoader,
        images: images ?? this.images,
        date: date ?? this.date,
        image: image ?? this.image);
  }

  @override
  String toString() {
    return "LoginState{successMsg: $successMsg,date:$date,image:$image,loginModel:$loginModel,name:$name,email:$email,createdAt:$createdAt,loading:$loading,onLoading:$onLoading,OtpLoader:$otpLoader,ResetLoader:$resetLoader,Image:$images}";
  }
}
