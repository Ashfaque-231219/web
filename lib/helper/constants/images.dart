class AppImages {
  AppImages._internal();

  factory AppImages() {
    return _appImages;
  }

  // get noInternet => 'assets/no_internet.png';
  // get logoBlackName => 'assets/logo_black_name.png';
  get backBlack => 'assets/images/back.svg';
  get info => 'assets/images/info-icon.svg';
  get filter => 'assets/images/filter.svg';
  get edit => 'assets/images/edit.svg';
  get download => 'assets/images/download.svg';
  get share => 'assets/images/share.svg';
  get projectInfo => 'assets/images/projectInfo.png';
  get redwoodFrontLogo => 'assets/images/front_logo.png';
  get rose => 'assets/images/rose.png';
  get selectMultiple => 'assets/images/selectMultiple.svg';
  get contactAdmin => 'assets/images/contact_admin.svg';
  get person => 'assets/images/person.svg';
  get doneDialog => 'assets/images/done.svg';
  get android => 'assets/images/android.svg';
  get apple => 'assets/images/apple.svg';

  static final AppImages _appImages = AppImages._internal();
}

AppImages appImages = AppImages();