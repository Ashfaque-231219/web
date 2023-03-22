import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web/view-model/authBloc/login_bloc.dart';
import 'package:web/view-model/contact_admin_bloc/contact_admin_bloc.dart';
import 'package:web/view-model/maintenanceBloc/maintenance_bloc.dart';
import 'package:web/view-model/notificationBloc/notification_bloc.dart';
import 'package:web/view-model/projectDetailBloc/project_detail_bloc.dart';
import 'package:web/view-model/punchListBloc/punch_list_bloc.dart';
import 'package:web/view-model/schedule_bloc/schedule_bloc.dart';
import 'package:web/view-model/siteSurveyReportBloc/site_survey_report_bloc.dart';
import 'package:web/view-model/task_report_bloc/task_report_bloc.dart';

import '../injection_container.dart' as di;

class CustomBlocProvider extends StatelessWidget {
  final Widget child;

  const CustomBlocProvider({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider<LoginBloc>(create: (context) => di.serviceLocator()),
      BlocProvider<ProjectDetailBloc>(create: (context) => di.serviceLocator()),
      BlocProvider<SiteSurveyReportBloc>(create: (context) => di.serviceLocator()),
      BlocProvider<PunchListBloc>(create: (context) => di.serviceLocator()),
      BlocProvider<ContactAdminBloc>(create: (context) => di.serviceLocator()),
      BlocProvider<MaintenanceBloc>(create: (context) => di.serviceLocator()),
      BlocProvider<ScheduleBloc>(create: (context) => di.serviceLocator()),
      BlocProvider<TaskBloc>(create: (context) => di.serviceLocator()),
      BlocProvider<NotificationBloc>(create: (context) => di.serviceLocator()),
    ], child: child);
  }
}
