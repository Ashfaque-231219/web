import 'package:auto_route/annotations.dart';
import 'package:web/Routing/route_guard.dart';
import 'package:web/view/screens/auth/change_pass_pass.dart';
import 'package:web/view/screens/auth/contact_admin_page.dart';
import 'package:web/view/screens/auth/edit_profile.dart';
import 'package:web/view/screens/auth/forgot_pass.dart';
import 'package:web/view/screens/auth/login_page.dart';
import 'package:web/view/screens/auth/notifications_page.dart';
import 'package:web/view/screens/auth/otp_screen.dart';
import 'package:web/view/screens/auth/reset_pass_screen.dart';
import 'package:web/view/screens/dashboard/home_page.dart';
import 'package:web/view/screens/project_details/project_details.dart';
import 'package:web/view/screens/project_details/project_info.dart';
import 'package:web/view/screens/report/create_report.dart';
import 'package:web/view/screens/report/maintainance_report_form_page.dart';
import 'package:web/view/screens/report/punch_list_form_page.dart';
import 'package:web/view/screens/report/site_inspection_form_page.dart';
import 'package:web/view/screens/report/site_survey_form_page.dart';
import 'package:web/view/screens/report/view_mainenance_report_form_page.dart';
import 'package:web/view/screens/report/view_punch_list_form_page.dart';
import 'package:web/view/screens/report/view_site_inspection_report.dart';
import 'package:web/view/screens/report/view_site_survey_form_page.dart';
import 'package:web/view/screens/sipr/tasks_form_page.dart';

import '../view/screens/auth/splash_screen.dart';
import '../view/screens/dashboard/reports.dart';
import 'auto_wrapper.dart';

@MaterialAutoRouter(
  routes: <AutoRoute>[
    CustomRoute(
      page: Splash,
      name: 'SplashRoute',
      path: '/',
      initial: true,
    ),
    CustomRoute(page: Login, name: 'LoginRoute', path: '/login', guards: [RouteGuard]),
    CustomRoute(
      page: OTPScreen,
      name: 'OTPRoute',
      path: '/verify-otp',
      children: [
        RedirectRoute(path: "*", redirectTo: "/login"),
      ],
    ),
    CustomRoute(
      page: ForgotPassword,
      name: 'ForgotRoute',
      path: '/forgot-password',
    ),
    AutoRoute(
      page: EditProfile,
      name: 'EditProfile',
      path: '/edit-profile',
      guards: [RouteGuard],
    ),
    AutoRoute(page: ChangePassword, name: 'ChangePassword', path: '/change-password', guards: [RouteGuard],),
    CustomRoute(
      page: AutoWrapper,
      name: 'HomeRouter',
      path: '/home-page',
      guards: [RouteGuard],
      children: [
        AutoRoute(
          path: 'projects',
          page: HomePage,
          name: 'projects',
          initial: true,
        ),
        AutoRoute(path: 'reports', page: Reports, name: 'reports',),
        AutoRoute(
          path: 'project-details/:id',
          page: ProjectDetails,
          name: 'projectDetails',
          children: [
            AutoRoute(page: CreateReport, name: 'CreateReport', path: '*'),
          ],
        ),
        AutoRoute(
            path: 'site-survey-form/:projectId/:reportCategoryId/:id',
            page: ViewSiteSurveyFormPage,
            name: 'ViewSiteSurveyFormPage',
            guards: [RouteGuard]),
        AutoRoute(
          path: 'site-survey-form/:projectId/:reportCategoryId/',
          page: SiteSurveyFormPage,
          name: 'SiteSurveyFormPage',
        ),
        AutoRoute(
          path: 'project-info/:projectId',
          page: ProjectInfo,
          name: 'ProjectInfo',
        ),
        AutoRoute(
          page: PunchList,
          name: 'PunchList',
          path: 'punch-list/:id',
        ),
        AutoRoute(
          page: ViewPunchList,
          name: 'ResolvePunchList',
          path: 'resolve-punch-list/:id',
        ),
        AutoRoute(
          page: MaintenanceReportFormPage,
          name: 'MaintenanceReportFormPage',
          path: 'maintenance-report/:id',
        ),
        AutoRoute(
          page: ViewMaintenanceFormPage,
          name: 'ViewMaintenanceFormPage',
          path: 'resolve-maintenance-report/:id',
        ),
        AutoRoute(
          page: ContactAdmin,
          name: 'ContactAdmin',
          path: 'contact-admin',
        ),
        AutoRoute(
          page: NotificationsPage,
          name: 'NotificationsPage',
          path: 'notifications',
        ),
        AutoRoute(
          page: TasksFormPage,
          name: 'TasksFormPage',
          path: 'add-task',
        ),
        AutoRoute(
          page: SiteInspectionFormPage,
          name: 'SiteInspectionFormPage',
          path: 'site_inspection_report/:id',
        ),
        AutoRoute(
          page: ViewSiteInspectionReport,
          name: 'ViewSiteInspectionReport',
          path: 'site_inspection_report/:id/:reportId',
        )
      ],
    ),
    CustomRoute(
      page: ResetPassword,
      name: 'ResetPassword',
      path: '/reset-password',
      children: [
        RedirectRoute(path: "*", redirectTo: "/login"),
      ],
    ),
  ],
)
class $AppRouter {}
