import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:web/Repository/auth_repo.dart';
import 'package:web/Repository/contact_us_repo.dart';
import 'package:web/Repository/maintenance_repository.dart';
import 'package:web/Repository/notification_repository.dart';
import 'package:web/Repository/project_repository.dart';
import 'package:web/Repository/punch_list_repository.dart';
import 'package:web/Repository/report_repository.dart';
import 'package:web/Repository/schedule_repo.dart';
import 'package:web/Repository/share_repository.dart';
import 'package:web/Repository/task_repo.dart';
import 'package:web/helper/utils/request_interceptor.dart';
import 'package:web/services/auth_services.dart';
import 'package:web/services/contact_us_service.dart';
import 'package:web/services/maintenance_service.dart';
import 'package:web/services/notification_services.dart';
import 'package:web/services/project_services.dart';
import 'package:web/services/punch_list_services.dart';
import 'package:web/services/report_services.dart';
import 'package:web/services/share_services.dart';
import 'package:web/services/task_services.dart';
import 'package:web/view-model/authBloc/login_bloc.dart';
import 'package:web/view-model/contact_admin_bloc/contact_admin_bloc.dart';
import 'package:web/view-model/maintenanceBloc/maintenance_bloc.dart';
import 'package:web/view-model/notificationBloc/notification_bloc.dart';
import 'package:web/view-model/projectDetailBloc/project_detail_bloc.dart';
import 'package:web/view-model/punchListBloc/punch_list_bloc.dart';
import 'package:web/view-model/schedule_bloc/schedule_bloc.dart';
import 'package:web/view-model/siteSurveyReportBloc/site_survey_report_bloc.dart';

import 'services/schedule_services.dart';
import 'view-model/task_report_bloc/task_report_bloc.dart';

final serviceLocator = GetIt.instance;

Future<void> init() async {
  serviceLocator.registerFactory(() => LoginBloc(authRepo: serviceLocator()));
  serviceLocator.registerFactory(() => ProjectDetailBloc(
        authRepo: serviceLocator(),
        projectRepository: serviceLocator(),
        shareRepository: serviceLocator(),
      ));
  serviceLocator.registerFactory(() => SiteSurveyReportBloc(reportRepository: serviceLocator(), shareRepository: serviceLocator()));
  serviceLocator.registerFactory(() => PunchListBloc(punchListRepository: serviceLocator()));
  serviceLocator.registerFactory(() => ContactAdminBloc(contactUsRepository: serviceLocator()));
  serviceLocator.registerFactory(() => MaintenanceBloc(maintenanceRepository: serviceLocator()));
  serviceLocator.registerFactory(() => ScheduleBloc(scheduleRepository: serviceLocator()));
  serviceLocator.registerFactory(() => TaskBloc(taskRepository: serviceLocator()));
  serviceLocator.registerFactory(() => NotificationBloc(notificationRepository: serviceLocator()));

  //
  serviceLocator.registerLazySingleton<AuthRepo>(() => AuthService(dio: serviceLocator()));
  serviceLocator.registerLazySingleton<ReportRepository>(() => ReportServices(dio: serviceLocator()));
  serviceLocator.registerLazySingleton<ProjectRepository>(() => ProjectServices(dio: serviceLocator()));
  serviceLocator.registerLazySingleton<PunchListRepository>(() => PunchListServices(dio: serviceLocator()));
  serviceLocator.registerLazySingleton<ContactUsRepository>(() => ContactUsService(dio: serviceLocator()));
  serviceLocator.registerLazySingleton<MaintenanceRepository>(() => MaintenanceService(dio: serviceLocator()));
  serviceLocator.registerLazySingleton<ScheduleRepository>(() => ScheduleService(dio: serviceLocator()));
  serviceLocator.registerLazySingleton<TaskRepository>(() => TaskService(dio: serviceLocator()));
  serviceLocator.registerLazySingleton<NotificationRepository>(() => NotificationService(dio: serviceLocator()));
  serviceLocator.registerLazySingleton<ShareRepository>(() => ShareServices(dio: serviceLocator()));
  serviceLocator.registerLazySingleton<Dio>(() => DioClient().provideDio());
}
