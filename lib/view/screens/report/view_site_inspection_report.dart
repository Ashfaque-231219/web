import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:web/helper/constants/dimen.dart';
import 'package:web/helper/constants/images.dart';
import 'package:web/helper/constants/size_constants.dart';
import 'package:web/models/response/project_details_modal.dart';
import 'package:web/view-model/event_status.dart';
import 'package:web/view-model/task_report_bloc/task_report_bloc.dart';
import 'package:web/view-model/task_report_bloc/task_report_event.dart';
import 'package:web/view-model/task_report_bloc/task_report_state.dart';
import 'package:web/view/screens/sipr/tasks_form_page.dart';
import 'package:web/view/shared_widget/custom_label.dart';

class ViewSiteInspectionReport extends StatefulWidget {
  final int projectId;
  final String reportId;

  const ViewSiteInspectionReport({
    @PathParam("id") required this.projectId,
    @PathParam("reportId") required this.reportId,
    Key? key,
  }) : super(key: key);

  @override
  State<ViewSiteInspectionReport> createState() => _ViewSiteInspectionReportState();
}

class _ViewSiteInspectionReportState extends State<ViewSiteInspectionReport> {
  List<TaskList?>? taskList;
  List<String> taskId = [];
  List<String> taskDate = [];
  List<String> taskImage = [];
  List<String> taskDescription = [];
  List<Task> tasksUpdate = [];

  @override
  void initState() {
    super.initState();
    triggerGetListEvent(ViewTaskReportEvent(context: context, reportId: widget.reportId.toString()));
  }

  triggerGetListEvent(TaskReportEvent event) {
    context.read<TaskBloc>().add(event);
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return BlocBuilder<TaskBloc, TaskReportState>(
      builder: (context, state) {
        if (state.viewStateStatus is StateLoaded) {
          if (state.viewInspectionReport != null && state.viewInspectionReport!.data != null) {
            taskList = state.viewInspectionReport!.data!;
            return Scaffold(
              body: Center(
                child: Container(
                  width: width > SizeConstants.tabWidth ? width * 0.7 : width,
                  margin: EdgeInsets.all(appDimen.sp20),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          InkWell(
                            onTap: () {
                              context.router.navigateBack();
                            },
                            child: SvgPicture.asset(
                              appImages.backBlack,
                              width: appDimen.sp40,
                              height: appDimen.sp40,
                            ),
                          ),
                          SizedBox(
                            width: appDimen.sp20,
                          ),
                          Expanded(
                            child: CustomLabel(
                              text: 'Site Inspection Report',
                              size: appDimen.sp16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: appDimen.sp20,
                      ),
                      taskList != null
                          ? Expanded(
                              child: ListView.separated(
                                shrinkWrap: true,
                                itemCount: taskList!.length,
                                physics: const ScrollPhysics(),
                                itemBuilder: (context, int index) {
                                  tasksUpdate.add(Task(
                                    id: taskList?[index]?.id.toString() ?? '',
                                    date: taskList?[index]?.date ?? '',
                                    image: taskList?[index]?.image ?? '',
                                    description: taskList?[index]?.description ?? '',
                                  ));

                                  return TasksFormPage(
                                    view: true,
                                    edit: true,
                                    projectId: widget.projectId.toString(),
                                    taskList: taskList?[index],
                                    saveTask: saveTaskDataInArray,
                                  );
                                },
                                separatorBuilder: (BuildContext context, int index) {
                                  return SizedBox(
                                    height: appDimen.sp10,
                                  );
                                },
                              ),
                            )
                          : Container(),
                      // Center(
                      //   child: CustomRaisedButton(
                      //     width: width * 0.2,
                      //     text: "Update Report",
                      //     color: Color(appColors.brown840000),
                      //     textColor: Color(appColors.white),
                      //     sideColor: Color(appColors.white),
                      //     onPressed: () {},
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ),
            );
          }
        }
        return Scaffold(
          body: Center(
            child: Container(
              width: width > SizeConstants.tabWidth ? width * 0.7 : width,
              margin: EdgeInsets.all(appDimen.sp20),
            ),
          ),
        );
      },
    );
  }

  saveTaskDataInArray(String id, String date, String image, String description) {
    print("task==== $id === $date === $image === $description");

    var taskIndex = tasksUpdate.indexWhere((element) => element.id == id);
    tasksUpdate[taskIndex] = Task(
      id: id,
      date: date,
      image: image,
      description: description,
    );
    print("dscsjdsdhisudhsdh $taskIndex");
    print("dscsjdsdhisudhsdh $tasksUpdate");
  }
}

class Task {
  String id;
  String date;
  String image;
  String description;

  Task({this.id = '', this.date = '', this.image = '', this.description = ''});
}
