class AppString {
  AppString._internal();

  factory AppString() {
    return _appString;
  }

  ///////////////////////////////
  get singaporeID => '62d0fd592425d1bbe7e7ce1c';
  get singaporeCountryCode => '+65';
  get singaporeCountryFlag => '🇸🇬';
  ///////////////////////////////

  get reports => 'Reports';
  get maintenance => 'Maintenance';
  get punchList => 'Punch List';
  get siteInspection => 'Site Inspection';
  get okText => 'OK';
  get proceed => 'Proceed';
  get showAll => 'Show All';
  get all => 'All';
  get open => 'Open';
  get closed => 'Closed';
  get schedule => 'Schedule';
  get tasks => 'Tasks';
  get resolve => 'Resolve';
  get download => 'Download';
  get createReport => 'Create Report';
  get addMaintenance => 'Add Maintenance';
  get addItem => 'Add Item';
  get createReportText => 'Select according to the type of report you want to create';
  get lengthWidthHint => '10000 m';
  get areaHint => '100000000 sq m';
  get loadingLocationHint => '52/53 Biggin Hill Road';
  get descriptionHint => 'Use not more than 100 words';
  get messageHint => 'Type your Message';
  get idHint => 'ID-001';
  get siteSurveyReport => 'Site Survey Report';
  get usernameOrEmail => 'Email / Username';
  get email => 'Email';

  get reportType => ["survey_report","inspection_report","maintenance","punch_list","report_history"];

  static final AppString _appString = AppString._internal();
}

AppString appString = AppString();
