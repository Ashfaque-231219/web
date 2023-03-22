// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i25;
import 'package:flutter/material.dart' as _i26;

import '../models/response/project_details_modal.dart' as _i28;
import '../view/screens/auth/change_pass_pass.dart' as _i6;
import '../view/screens/auth/contact_admin_page.dart' as _i19;
import '../view/screens/auth/edit_profile.dart' as _i5;
import '../view/screens/auth/forgot_pass.dart' as _i4;
import '../view/screens/auth/login_page.dart' as _i2;
import '../view/screens/auth/notifications_page.dart' as _i20;
import '../view/screens/auth/otp_screen.dart' as _i3;
import '../view/screens/auth/reset_pass_screen.dart' as _i8;
import '../view/screens/auth/splash_screen.dart' as _i1;
import '../view/screens/dashboard/home_page.dart' as _i9;
import '../view/screens/dashboard/reports.dart' as _i10;
import '../view/screens/project_details/project_details.dart' as _i11;
import '../view/screens/project_details/project_info.dart' as _i14;
import '../view/screens/report/create_report.dart' as _i24;
import '../view/screens/report/maintainance_report_form_page.dart' as _i17;
import '../view/screens/report/punch_list_form_page.dart' as _i15;
import '../view/screens/report/site_inspection_form_page.dart' as _i22;
import '../view/screens/report/site_survey_form_page.dart' as _i13;
import '../view/screens/report/view_mainenance_report_form_page.dart' as _i18;
import '../view/screens/report/view_punch_list_form_page.dart' as _i16;
import '../view/screens/report/view_site_inspection_report.dart' as _i23;
import '../view/screens/report/view_site_survey_form_page.dart' as _i12;
import '../view/screens/sipr/tasks_form_page.dart' as _i21;
import 'auto_wrapper.dart' as _i7;
import 'route_guard.dart' as _i27;

class AppRouter extends _i25.RootStackRouter {
  AppRouter(
      {_i26.GlobalKey<_i26.NavigatorState>? navigatorKey,
      required this.routeGuard})
      : super(navigatorKey);

  final _i27.RouteGuard routeGuard;

  @override
  final Map<String, _i25.PageFactory> pagesMap = {
    SplashRoute.name: (routeData) {
      return _i25.CustomPage<dynamic>(
          routeData: routeData,
          child: const _i1.Splash(),
          opaque: true,
          barrierDismissible: false);
    },
    LoginRoute.name: (routeData) {
      return _i25.CustomPage<dynamic>(
          routeData: routeData,
          child: const _i2.Login(),
          opaque: true,
          barrierDismissible: false);
    },
    OTPRoute.name: (routeData) {
      return _i25.CustomPage<dynamic>(
          routeData: routeData,
          child: const _i3.OTPScreen(),
          opaque: true,
          barrierDismissible: false);
    },
    ForgotRoute.name: (routeData) {
      return _i25.CustomPage<dynamic>(
          routeData: routeData,
          child: const _i4.ForgotPassword(),
          opaque: true,
          barrierDismissible: false);
    },
    EditProfile.name: (routeData) {
      return _i25.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i5.EditProfile());
    },
    ChangePassword.name: (routeData) {
      return _i25.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i6.ChangePassword());
    },
    HomeRouter.name: (routeData) {
      return _i25.CustomPage<dynamic>(
          routeData: routeData,
          child: const _i7.AutoWrapper(),
          opaque: true,
          barrierDismissible: false);
    },
    ResetPassword.name: (routeData) {
      return _i25.CustomPage<dynamic>(
          routeData: routeData,
          child: const _i8.ResetPassword(),
          opaque: true,
          barrierDismissible: false);
    },
    Projects.name: (routeData) {
      return _i25.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i9.HomePage());
    },
    Reports.name: (routeData) {
      return _i25.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i10.Reports());
    },
    ProjectDetails.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<ProjectDetailsArgs>(
          orElse: () => ProjectDetailsArgs(id: pathParams.getInt('id')));
      return _i25.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i11.ProjectDetails(id: args.id, key: args.key));
    },
    ViewSiteSurveyFormPage.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<ViewSiteSurveyFormPageArgs>(
          orElse: () => ViewSiteSurveyFormPageArgs(
              reportId: pathParams.getInt('id'),
              reportCategoryId: pathParams.getInt('reportCategoryId'),
              projectId: pathParams.getInt('projectId')));
      return _i25.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i12.ViewSiteSurveyFormPage(
              reportId: args.reportId,
              reportCategoryId: args.reportCategoryId,
              projectId: args.projectId,
              key: args.key));
    },
    SiteSurveyFormPage.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<SiteSurveyFormPageArgs>(
          orElse: () => SiteSurveyFormPageArgs(
              reportCategoryId: pathParams.optInt('reportCategoryId'),
              projectId: pathParams.optString('projectId')));
      return _i25.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i13.SiteSurveyFormPage(
              reportCategoryId: args.reportCategoryId,
              projectId: args.projectId,
              key: args.key));
    },
    ProjectInfo.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<ProjectInfoArgs>(
          orElse: () =>
              ProjectInfoArgs(projectId: pathParams.getInt('projectId')));
      return _i25.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i14.ProjectInfo(projectId: args.projectId, key: args.key));
    },
    PunchList.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<PunchListArgs>(
          orElse: () => PunchListArgs(projectId: pathParams.getInt('id')));
      return _i25.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i15.PunchList(key: args.key, projectId: args.projectId));
    },
    ResolvePunchList.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<ResolvePunchListArgs>(
          orElse: () =>
              ResolvePunchListArgs(punchListId: pathParams.getInt('id')));
      return _i25.MaterialPageX<dynamic>(
          routeData: routeData,
          child:
              _i16.ViewPunchList(key: args.key, punchListId: args.punchListId));
    },
    MaintenanceReportFormPage.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<MaintenanceReportFormPageArgs>(
          orElse: () => MaintenanceReportFormPageArgs(
              projectId: pathParams.getInt('id')));
      return _i25.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i17.MaintenanceReportFormPage(
              key: args.key, projectId: args.projectId));
    },
    ViewMaintenanceFormPage.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<ViewMaintenanceFormPageArgs>(
          orElse: () => ViewMaintenanceFormPageArgs(
              maintenanceId: pathParams.getInt('id')));
      return _i25.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i18.ViewMaintenanceFormPage(
              key: args.key, maintenanceId: args.maintenanceId));
    },
    ContactAdmin.name: (routeData) {
      return _i25.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i19.ContactAdmin());
    },
    NotificationsPage.name: (routeData) {
      return _i25.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i20.NotificationsPage());
    },
    TasksFormPage.name: (routeData) {
      final args = routeData.argsAs<TasksFormPageArgs>(
          orElse: () => const TasksFormPageArgs());
      return _i25.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i21.TasksFormPage(
              view: args.view,
              edit: args.edit,
              taskList: args.taskList,
              projectId: args.projectId,
              key: args.key));
    },
    SiteInspectionFormPage.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<SiteInspectionFormPageArgs>(
          orElse: () =>
              SiteInspectionFormPageArgs(projectId: pathParams.getInt('id')));
      return _i25.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i22.SiteInspectionFormPage(
              key: args.key, projectId: args.projectId));
    },
    ViewSiteInspectionReport.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<ViewSiteInspectionReportArgs>(
          orElse: () => ViewSiteInspectionReportArgs(
              projectId: pathParams.getInt('id'),
              reportId: pathParams.getString('reportId')));
      return _i25.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i23.ViewSiteInspectionReport(
              projectId: args.projectId,
              reportId: args.reportId,
              key: args.key));
    },
    CreateReport.name: (routeData) {
      final args = routeData.argsAs<CreateReportArgs>(
          orElse: () => const CreateReportArgs());
      return _i25.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i24.CreateReport(
              projectId: args.projectId, refresh: args.refresh, key: args.key));
    }
  };

  @override
  List<_i25.RouteConfig> get routes => [
        _i25.RouteConfig(SplashRoute.name, path: '/'),
        _i25.RouteConfig(LoginRoute.name, path: '/login', guards: [routeGuard]),
        _i25.RouteConfig(OTPRoute.name, path: '/verify-otp', children: [
          _i25.RouteConfig('*#redirect',
              path: '*',
              parent: OTPRoute.name,
              redirectTo: '/login',
              fullMatch: true)
        ]),
        _i25.RouteConfig(ForgotRoute.name, path: '/forgot-password'),
        _i25.RouteConfig(EditProfile.name,
            path: '/edit-profile', guards: [routeGuard]),
        _i25.RouteConfig(ChangePassword.name,
            path: '/change-password', guards: [routeGuard]),
        _i25.RouteConfig(HomeRouter.name, path: '/home-page', guards: [
          routeGuard
        ], children: [
          _i25.RouteConfig('#redirect',
              path: '',
              parent: HomeRouter.name,
              redirectTo: 'projects',
              fullMatch: true),
          _i25.RouteConfig(Projects.name,
              path: 'projects', parent: HomeRouter.name),
          _i25.RouteConfig(Reports.name,
              path: 'reports', parent: HomeRouter.name),
          _i25.RouteConfig(ProjectDetails.name,
              path: 'project-details/:id',
              parent: HomeRouter.name,
              children: [
                _i25.RouteConfig(CreateReport.name,
                    path: '*', parent: ProjectDetails.name)
              ]),
          _i25.RouteConfig(ViewSiteSurveyFormPage.name,
              path: 'site-survey-form/:projectId/:reportCategoryId/:id',
              parent: HomeRouter.name,
              guards: [routeGuard]),
          _i25.RouteConfig(SiteSurveyFormPage.name,
              path: 'site-survey-form/:projectId/:reportCategoryId/',
              parent: HomeRouter.name),
          _i25.RouteConfig(ProjectInfo.name,
              path: 'project-info/:projectId', parent: HomeRouter.name),
          _i25.RouteConfig(PunchList.name,
              path: 'punch-list/:id', parent: HomeRouter.name),
          _i25.RouteConfig(ResolvePunchList.name,
              path: 'resolve-punch-list/:id', parent: HomeRouter.name),
          _i25.RouteConfig(MaintenanceReportFormPage.name,
              path: 'maintenance-report/:id', parent: HomeRouter.name),
          _i25.RouteConfig(ViewMaintenanceFormPage.name,
              path: 'resolve-maintenance-report/:id', parent: HomeRouter.name),
          _i25.RouteConfig(ContactAdmin.name,
              path: 'contact-admin', parent: HomeRouter.name),
          _i25.RouteConfig(NotificationsPage.name,
              path: 'notifications', parent: HomeRouter.name),
          _i25.RouteConfig(TasksFormPage.name,
              path: 'add-task', parent: HomeRouter.name),
          _i25.RouteConfig(SiteInspectionFormPage.name,
              path: 'site_inspection_report/:id', parent: HomeRouter.name),
          _i25.RouteConfig(ViewSiteInspectionReport.name,
              path: 'site_inspection_report/:id/:reportId',
              parent: HomeRouter.name)
        ]),
        _i25.RouteConfig(ResetPassword.name,
            path: '/reset-password',
            children: [
              _i25.RouteConfig('*#redirect',
                  path: '*',
                  parent: ResetPassword.name,
                  redirectTo: '/login',
                  fullMatch: true)
            ])
      ];
}

/// generated route for
/// [_i1.Splash]
class SplashRoute extends _i25.PageRouteInfo<void> {
  const SplashRoute() : super(SplashRoute.name, path: '/');

  static const String name = 'SplashRoute';
}

/// generated route for
/// [_i2.Login]
class LoginRoute extends _i25.PageRouteInfo<void> {
  const LoginRoute() : super(LoginRoute.name, path: '/login');

  static const String name = 'LoginRoute';
}

/// generated route for
/// [_i3.OTPScreen]
class OTPRoute extends _i25.PageRouteInfo<void> {
  const OTPRoute({List<_i25.PageRouteInfo>? children})
      : super(OTPRoute.name, path: '/verify-otp', initialChildren: children);

  static const String name = 'OTPRoute';
}

/// generated route for
/// [_i4.ForgotPassword]
class ForgotRoute extends _i25.PageRouteInfo<void> {
  const ForgotRoute() : super(ForgotRoute.name, path: '/forgot-password');

  static const String name = 'ForgotRoute';
}

/// generated route for
/// [_i5.EditProfile]
class EditProfile extends _i25.PageRouteInfo<void> {
  const EditProfile() : super(EditProfile.name, path: '/edit-profile');

  static const String name = 'EditProfile';
}

/// generated route for
/// [_i6.ChangePassword]
class ChangePassword extends _i25.PageRouteInfo<void> {
  const ChangePassword() : super(ChangePassword.name, path: '/change-password');

  static const String name = 'ChangePassword';
}

/// generated route for
/// [_i7.AutoWrapper]
class HomeRouter extends _i25.PageRouteInfo<void> {
  const HomeRouter({List<_i25.PageRouteInfo>? children})
      : super(HomeRouter.name, path: '/home-page', initialChildren: children);

  static const String name = 'HomeRouter';
}

/// generated route for
/// [_i8.ResetPassword]
class ResetPassword extends _i25.PageRouteInfo<void> {
  const ResetPassword({List<_i25.PageRouteInfo>? children})
      : super(ResetPassword.name,
            path: '/reset-password', initialChildren: children);

  static const String name = 'ResetPassword';
}

/// generated route for
/// [_i9.HomePage]
class Projects extends _i25.PageRouteInfo<void> {
  const Projects() : super(Projects.name, path: 'projects');

  static const String name = 'Projects';
}

/// generated route for
/// [_i10.Reports]
class Reports extends _i25.PageRouteInfo<void> {
  const Reports() : super(Reports.name, path: 'reports');

  static const String name = 'Reports';
}

/// generated route for
/// [_i11.ProjectDetails]
class ProjectDetails extends _i25.PageRouteInfo<ProjectDetailsArgs> {
  ProjectDetails(
      {required int id, _i26.Key? key, List<_i25.PageRouteInfo>? children})
      : super(ProjectDetails.name,
            path: 'project-details/:id',
            args: ProjectDetailsArgs(id: id, key: key),
            rawPathParams: {'id': id},
            initialChildren: children);

  static const String name = 'ProjectDetails';
}

class ProjectDetailsArgs {
  const ProjectDetailsArgs({required this.id, this.key});

  final int id;

  final _i26.Key? key;

  @override
  String toString() {
    return 'ProjectDetailsArgs{id: $id, key: $key}';
  }
}

/// generated route for
/// [_i12.ViewSiteSurveyFormPage]
class ViewSiteSurveyFormPage
    extends _i25.PageRouteInfo<ViewSiteSurveyFormPageArgs> {
  ViewSiteSurveyFormPage(
      {required int reportId,
      required int reportCategoryId,
      required int projectId,
      _i26.Key? key})
      : super(ViewSiteSurveyFormPage.name,
            path: 'site-survey-form/:projectId/:reportCategoryId/:id',
            args: ViewSiteSurveyFormPageArgs(
                reportId: reportId,
                reportCategoryId: reportCategoryId,
                projectId: projectId,
                key: key),
            rawPathParams: {
              'id': reportId,
              'reportCategoryId': reportCategoryId,
              'projectId': projectId
            });

  static const String name = 'ViewSiteSurveyFormPage';
}

class ViewSiteSurveyFormPageArgs {
  const ViewSiteSurveyFormPageArgs(
      {required this.reportId,
      required this.reportCategoryId,
      required this.projectId,
      this.key});

  final int reportId;

  final int reportCategoryId;

  final int projectId;

  final _i26.Key? key;

  @override
  String toString() {
    return 'ViewSiteSurveyFormPageArgs{reportId: $reportId, reportCategoryId: $reportCategoryId, projectId: $projectId, key: $key}';
  }
}

/// generated route for
/// [_i13.SiteSurveyFormPage]
class SiteSurveyFormPage extends _i25.PageRouteInfo<SiteSurveyFormPageArgs> {
  SiteSurveyFormPage(
      {required int? reportCategoryId,
      required String? projectId,
      _i26.Key? key})
      : super(SiteSurveyFormPage.name,
            path: 'site-survey-form/:projectId/:reportCategoryId/',
            args: SiteSurveyFormPageArgs(
                reportCategoryId: reportCategoryId,
                projectId: projectId,
                key: key),
            rawPathParams: {
              'reportCategoryId': reportCategoryId,
              'projectId': projectId
            });

  static const String name = 'SiteSurveyFormPage';
}

class SiteSurveyFormPageArgs {
  const SiteSurveyFormPageArgs(
      {required this.reportCategoryId, required this.projectId, this.key});

  final int? reportCategoryId;

  final String? projectId;

  final _i26.Key? key;

  @override
  String toString() {
    return 'SiteSurveyFormPageArgs{reportCategoryId: $reportCategoryId, projectId: $projectId, key: $key}';
  }
}

/// generated route for
/// [_i14.ProjectInfo]
class ProjectInfo extends _i25.PageRouteInfo<ProjectInfoArgs> {
  ProjectInfo({required int projectId, _i26.Key? key})
      : super(ProjectInfo.name,
            path: 'project-info/:projectId',
            args: ProjectInfoArgs(projectId: projectId, key: key),
            rawPathParams: {'projectId': projectId});

  static const String name = 'ProjectInfo';
}

class ProjectInfoArgs {
  const ProjectInfoArgs({required this.projectId, this.key});

  final int projectId;

  final _i26.Key? key;

  @override
  String toString() {
    return 'ProjectInfoArgs{projectId: $projectId, key: $key}';
  }
}

/// generated route for
/// [_i15.PunchList]
class PunchList extends _i25.PageRouteInfo<PunchListArgs> {
  PunchList({_i26.Key? key, required int projectId})
      : super(PunchList.name,
            path: 'punch-list/:id',
            args: PunchListArgs(key: key, projectId: projectId),
            rawPathParams: {'id': projectId});

  static const String name = 'PunchList';
}

class PunchListArgs {
  const PunchListArgs({this.key, required this.projectId});

  final _i26.Key? key;

  final int projectId;

  @override
  String toString() {
    return 'PunchListArgs{key: $key, projectId: $projectId}';
  }
}

/// generated route for
/// [_i16.ViewPunchList]
class ResolvePunchList extends _i25.PageRouteInfo<ResolvePunchListArgs> {
  ResolvePunchList({_i26.Key? key, required int punchListId})
      : super(ResolvePunchList.name,
            path: 'resolve-punch-list/:id',
            args: ResolvePunchListArgs(key: key, punchListId: punchListId),
            rawPathParams: {'id': punchListId});

  static const String name = 'ResolvePunchList';
}

class ResolvePunchListArgs {
  const ResolvePunchListArgs({this.key, required this.punchListId});

  final _i26.Key? key;

  final int punchListId;

  @override
  String toString() {
    return 'ResolvePunchListArgs{key: $key, punchListId: $punchListId}';
  }
}

/// generated route for
/// [_i17.MaintenanceReportFormPage]
class MaintenanceReportFormPage
    extends _i25.PageRouteInfo<MaintenanceReportFormPageArgs> {
  MaintenanceReportFormPage({_i26.Key? key, required int projectId})
      : super(MaintenanceReportFormPage.name,
            path: 'maintenance-report/:id',
            args: MaintenanceReportFormPageArgs(key: key, projectId: projectId),
            rawPathParams: {'id': projectId});

  static const String name = 'MaintenanceReportFormPage';
}

class MaintenanceReportFormPageArgs {
  const MaintenanceReportFormPageArgs({this.key, required this.projectId});

  final _i26.Key? key;

  final int projectId;

  @override
  String toString() {
    return 'MaintenanceReportFormPageArgs{key: $key, projectId: $projectId}';
  }
}

/// generated route for
/// [_i18.ViewMaintenanceFormPage]
class ViewMaintenanceFormPage
    extends _i25.PageRouteInfo<ViewMaintenanceFormPageArgs> {
  ViewMaintenanceFormPage({_i26.Key? key, required int maintenanceId})
      : super(ViewMaintenanceFormPage.name,
            path: 'resolve-maintenance-report/:id',
            args: ViewMaintenanceFormPageArgs(
                key: key, maintenanceId: maintenanceId),
            rawPathParams: {'id': maintenanceId});

  static const String name = 'ViewMaintenanceFormPage';
}

class ViewMaintenanceFormPageArgs {
  const ViewMaintenanceFormPageArgs({this.key, required this.maintenanceId});

  final _i26.Key? key;

  final int maintenanceId;

  @override
  String toString() {
    return 'ViewMaintenanceFormPageArgs{key: $key, maintenanceId: $maintenanceId}';
  }
}

/// generated route for
/// [_i19.ContactAdmin]
class ContactAdmin extends _i25.PageRouteInfo<void> {
  const ContactAdmin() : super(ContactAdmin.name, path: 'contact-admin');

  static const String name = 'ContactAdmin';
}

/// generated route for
/// [_i20.NotificationsPage]
class NotificationsPage extends _i25.PageRouteInfo<void> {
  const NotificationsPage()
      : super(NotificationsPage.name, path: 'notifications');

  static const String name = 'NotificationsPage';
}

/// generated route for
/// [_i21.TasksFormPage]
class TasksFormPage extends _i25.PageRouteInfo<TasksFormPageArgs> {
  TasksFormPage(
      {bool view = false,
      bool edit = true,
      _i28.TaskList? taskList,
      String? projectId,
      _i26.Key? key})
      : super(TasksFormPage.name,
            path: 'add-task',
            args: TasksFormPageArgs(
                view: view,
                edit: edit,
                taskList: taskList,
                projectId: projectId,
                key: key));

  static const String name = 'TasksFormPage';
}

class TasksFormPageArgs {
  const TasksFormPageArgs(
      {this.view = false,
      this.edit = true,
      this.taskList,
      this.projectId,
      this.key});

  final bool view;

  final bool edit;

  final _i28.TaskList? taskList;

  final String? projectId;

  final _i26.Key? key;

  @override
  String toString() {
    return 'TasksFormPageArgs{view: $view, edit: $edit, taskList: $taskList, projectId: $projectId, key: $key}';
  }
}

/// generated route for
/// [_i22.SiteInspectionFormPage]
class SiteInspectionFormPage
    extends _i25.PageRouteInfo<SiteInspectionFormPageArgs> {
  SiteInspectionFormPage({_i26.Key? key, required int projectId})
      : super(SiteInspectionFormPage.name,
            path: 'site_inspection_report/:id',
            args: SiteInspectionFormPageArgs(key: key, projectId: projectId),
            rawPathParams: {'id': projectId});

  static const String name = 'SiteInspectionFormPage';
}

class SiteInspectionFormPageArgs {
  const SiteInspectionFormPageArgs({this.key, required this.projectId});

  final _i26.Key? key;

  final int projectId;

  @override
  String toString() {
    return 'SiteInspectionFormPageArgs{key: $key, projectId: $projectId}';
  }
}

/// generated route for
/// [_i23.ViewSiteInspectionReport]
class ViewSiteInspectionReport
    extends _i25.PageRouteInfo<ViewSiteInspectionReportArgs> {
  ViewSiteInspectionReport(
      {required int projectId, required String reportId, _i26.Key? key})
      : super(ViewSiteInspectionReport.name,
            path: 'site_inspection_report/:id/:reportId',
            args: ViewSiteInspectionReportArgs(
                projectId: projectId, reportId: reportId, key: key),
            rawPathParams: {'id': projectId, 'reportId': reportId});

  static const String name = 'ViewSiteInspectionReport';
}

class ViewSiteInspectionReportArgs {
  const ViewSiteInspectionReportArgs(
      {required this.projectId, required this.reportId, this.key});

  final int projectId;

  final String reportId;

  final _i26.Key? key;

  @override
  String toString() {
    return 'ViewSiteInspectionReportArgs{projectId: $projectId, reportId: $reportId, key: $key}';
  }
}

/// generated route for
/// [_i24.CreateReport]
class CreateReport extends _i25.PageRouteInfo<CreateReportArgs> {
  CreateReport({String? projectId, Function? refresh, _i26.Key? key})
      : super(CreateReport.name,
            path: '*',
            args: CreateReportArgs(
                projectId: projectId, refresh: refresh, key: key));

  static const String name = 'CreateReport';
}

class CreateReportArgs {
  const CreateReportArgs({this.projectId, this.refresh, this.key});

  final String? projectId;

  final Function? refresh;

  final _i26.Key? key;

  @override
  String toString() {
    return 'CreateReportArgs{projectId: $projectId, refresh: $refresh, key: $key}';
  }
}
