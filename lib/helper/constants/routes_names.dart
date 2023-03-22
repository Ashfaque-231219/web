class RouteNames {
  RouteNames._internal();

  factory RouteNames() {
    return _routeNames;
  }

  // get noInternet => 'assets/no_internet.png';
  // get logoBlackName => 'assets/logo_black_name.png';
  get goProjectPage => '/home-page/projects';
  get goEditProfilePage => '/edit-profile';
  get goChangePasswordPage => '/change-password';
  get goOTPVerifyPage => '/otp-page';
  get goResetPasswordPage => '/Reset-password';
  get goPunchListPage => 'punch-list';
  get goSiteSurveyPage => 'site-survey-form';
  get goProjectDetailPage => 'project-details';
  get goProjectInfoPage => 'project-info';
  get goParentProjectPage => 'projects';
  get goForgotPasswordPage => '/forgot-password';
  get goLoginPage => '/login';
  get goSplash => '/';

  static final RouteNames _routeNames = RouteNames._internal();
}

RouteNames routeNames = RouteNames();